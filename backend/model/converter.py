import h5py

file_path = "/Users/hyoyeon/Desktop/ai_powered_trash_classifier/backend/model/model.h5"

with h5py.File(file_path, "r") as f:
    print("Keys in .h5 file:", list(f.keys()))
