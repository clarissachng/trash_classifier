from flask import Flask, request, jsonify
from pymongo import MongoClient
from datetime import datetime
from waste_classifier import classify_image

app = Flask(__name__)

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")
db = client['waste_log']


@app.route('/scan', methods=['POST'])
def scan_waste():
    """Classify scanned waste and save results."""
    try:
        data = request.json
        user_id = data.get("user_id", "unknown")

        # Assume the image is sent as bytes in request.data
        image_bytes = request.data
        category = classify_image(image_bytes)

        if category is None:
            return jsonify({"error": "Classification failed"}), 500

        # Save scan result with 12 categories
        scan_entry = {
            "user_id": user_id,
            "category": category,
            "timestamp": datetime.utcnow()
        }
        db.scans.insert_one(scan_entry)

        return jsonify({
            "user_id": user_id,
            "category": category,
            "timestamp": scan_entry["timestamp"].isoformat()
        }), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/history/<user_id>', methods=['GET'])
def get_history(user_id):
    """Get scan history for the user."""
    scans = list(db.scans.find({"user_id": user_id}, {"_id": 0}))
    return jsonify(scans), 200

@app.route('/summary/<user_id>', methods=['GET'])
def get_summary(user_id):
    """Get a summary of how many items were recycled by category."""
    try:
        # Aggregate total items per category for the user
        summary = db.scans.aggregate([
            {"$match": {"user_id": user_id}},
            {"$group": {"_id": "$category", "total": {"$sum": 1}}}
        ])

        # Convert results to a dictionary
        summary_dict = {item["_id"]: item["total"] for item in summary}

        # Include all 12 categories, even if 0
        CATEGORIES = [
            'paper', 'cardboard', 'biological', 'metal',
            'plastic', 'green-glass', 'brown-glass', 'white-glass',
            'clothes', 'shoes', 'batteries', 'trash'
        ]
        full_summary = {category: summary_dict.get(category, 0) for category in CATEGORIES}

        return jsonify(full_summary), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/achievements/<user_id>', methods=['GET'])
def get_achievements(user_id):
    """Get achievements based on category counts."""
    try:
        # Get total counts per category
        category_counts = db.scans.aggregate([
            {"$match": {"user_id": user_id}},
            {"$group": {"_id": "$category", "total": {"$sum": 1}}}
        ])
        counts = {item["_id"]: item["total"] for item in category_counts}

        achievements = []

        # Category-specific achievements
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

        # Glass combined achievement
        if (
            counts.get("green-glass", 0) >= 10 and
            counts.get("brown-glass", 0) >= 10 and
            counts.get("white-glass", 0) >= 10
        ):
            achievements.append("🥂 Glass Collector")

        # Fashion combined achievement
        if (
            counts.get("clothes", 0) >= 10 and
            counts.get("shoes", 0) >= 5
        ):
            achievements.append("👔 Fashion Saver")

        if counts.get("batteries", 0) >= 5:
            achievements.append("⚡ Battery Recycler")

        if counts.get("trash", 0) >= 20:
            achievements.append("🗑️ Trash Reducer")

        # All-round Recycler Achievement (5 items in each category)
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
