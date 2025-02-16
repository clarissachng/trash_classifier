use("waste_log")

db.createCollection("users")
db.createCollection("scans")
db.createCollection("achievements")

// Insert sample user
db.users.insertOne({
    "user_id": "12345",
    "name": "Sample User",
    "email": "sample@example.com",
    "points": 0,
    "badges": []
})

// Sample scans for 12 categories
db.scans.insertMany([
    {"user_id": "12345", "category": "paper", "timestamp": new Date()},
    {"user_id": "12345", "category": "plastic", "timestamp": new Date()},
    {"user_id": "12345", "category": "metal", "timestamp": new Date()},
    {"user_id": "12345", "category": "batteries", "timestamp": new Date()}
])

// Achievement examples
db.achievements.insertOne({
    "badge_name": "Eco Starter",
    "requirement": 10,
    "description": "Scan 10 waste items."
})

print("MongoDB initialized successfully with 12 categories!")
