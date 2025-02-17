from flask import Flask, request, jsonify
from pymongo import MongoClient
from datetime import datetime
from waste_classifier import classify_image

app = Flask(__name__)

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")
db = client['waste_log']

@app.route('/monthly_summary/<user_id>', methods=['GET'])
def get_monthly_summary(user_id):
    """Get monthly waste scan summary."""
    try:
        summary = db.scans.aggregate([
            {"$match": {"user_id": user_id}},
            {"$group": {
                "_id": {"year": {"$year": "$timestamp"}, "month": {"$month": "$timestamp"}},
                "total": {"$sum": 1}
            }},
            {"$sort": {"_id.year": 1, "_id.month": 1}}
        ])

        monthly_data = [
            {
                "month": f"{item['_id']['year']}-{str(item['_id']['month']).zfill(2)}",
                "total": item["total"]
            }
            for item in summary
        ]

        return jsonify(monthly_data), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/category_summary/<user_id>/<month>', methods=['GET'])
def get_category_summary(user_id, month):
    """Get category-wise waste summary for a specific month."""
    try:
        start_date = datetime.strptime(month, '%Y-%m')
        end_date = datetime(start_date.year, start_date.month + 1, 1) if start_date.month < 12 else \
            datetime(start_date.year + 1, 1, 1)

        summary = db.scans.aggregate([
            {"$match": {
                "user_id": user_id,
                "timestamp": {"$gte": start_date, "$lt": end_date}
            }},
            {"$group": {
                "_id": "$category",
                "total": {"$sum": 1}
            }}
        ])

        CATEGORIES = [
            'paper', 'cardboard', 'biological', 'metal',
            'plastic', 'green-glass', 'brown-glass', 'white-glass',
            'clothes', 'shoes', 'batteries', 'trash'
        ]

        category_summary = {cat: 0 for cat in CATEGORIES}
        for item in summary:
            category_summary[item["_id"]] = item["total"]

        return jsonify(category_summary), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Maintain achievements endpoint
@app.route('/achievements/<user_id>', methods=['GET'])
def get_achievements(user_id):
    """Get achievements based on category counts."""
    try:
        category_counts = db.scans.aggregate([
            {"$match": {"user_id": user_id}},
            {"$group": {"_id": "$category", "total": {"$sum": 1}}}
        ])
        counts = {item["_id"]: item["total"] for item in category_counts}

        achievements = []

        if counts.get("paper", 0) >= 20:
            achievements.append("🌱 Eco Paper Saver")
        if counts.get("cardboard", 0) >= 15:
            achievements.append("📦 Cardboard Collector")
        if counts.get("biological", 0) >= 25:
            achievements.append("🍃 Organic Hero")
        if counts.get("metal", 0) >= 15:
            achievements.append("🛠️ Metal Recycler")
        if counts.get("plastic", 0) >= 30:
            achievements.append("🧴 Plastic Warrior")
        if (counts.get("green-glass", 0) >= 10 and counts.get("brown-glass", 0) >= 10 and counts.get("white-glass", 0) >= 10):
            achievements.append("🥂 Glass Collector")
        if (counts.get("clothes", 0) >= 10 and counts.get("shoes", 0) >= 5):
            achievements.append("👔 Fashion Saver")
        if counts.get("batteries", 0) >= 5:
            achievements.append("⚡ Battery Recycler")
        if counts.get("trash", 0) >= 20:
            achievements.append("🗑️ Trash Reducer")
        if all(counts.get(cat, 0) >= 5 for cat in [
            "paper", "cardboard", "biological", "metal", "plastic",
            "green-glass", "brown-glass", "white-glass",
            "clothes", "shoes", "batteries", "trash"
        ]):
            achievements.append("🌟 All-Round Recycler")

        return jsonify({"achievements": achievements}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
