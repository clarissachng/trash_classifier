import os
import numpy as np
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Lambda, Dense, GlobalAveragePooling2D
import tensorflow.keras.applications.xception as xception
from tensorflow.keras.preprocessing import image

# Define constants (Ensure these match your training setup)
IMAGE_WIDTH = 299  # Xception's default input size
IMAGE_HEIGHT = 299
IMAGE_CHANNELS = 3  # RGB images

# Load the pre-trained Xception model without the top classification layer
xception_layer = xception.Xception(
    include_top=False,
    input_shape=(IMAGE_WIDTH, IMAGE_HEIGHT, IMAGE_CHANNELS),
    weights=None  # Set to None initially, as we will load weights later
)

# Freeze the pre-trained model layers
xception_layer.trainable = False

# Define preprocessing function
def xception_preprocessing(img):
    return xception.preprocess_input(img)

# Rebuild the model architecture
model = Sequential([
    tf.keras.Input(shape=(IMAGE_WIDTH, IMAGE_HEIGHT, IMAGE_CHANNELS)),
    Lambda(xception_preprocessing),
    xception_layer,
    GlobalAveragePooling2D(),
    Dense(12, activation='softmax')  # Change 12 to your actual class count
])

# Compile the model (Ensure settings match the original training setup)
model.compile(
    loss='categorical_crossentropy',
    optimizer='adam',
    metrics=['categorical_accuracy']
)

# Load pre-trained weights (Ensure the file exists)
weights_path = "backend/model.h5"
if os.path.exists(weights_path):
    model.load_weights(weights_path)
    print("✅ Weights loaded successfully.")
else:
    print("❌ No weights file found.")

# Print model summary to verify architecture
model.summary()


### 🔹 Function to Make Predictions ###
def predict_image(image_path, class_labels):
    """
    Loads an image, preprocesses it, and predicts the class using the trained model.
    """
    # Load and preprocess image
    img = image.load_img(image_path, target_size=(IMAGE_WIDTH, IMAGE_HEIGHT))
    img_array = image.img_to_array(img)  # Convert to NumPy array
    img_array = np.expand_dims(img_array, axis=0)  # Add batch dimension
    img_array = xception.preprocess_input(img_array)  # Apply Xception preprocessing

    # Make prediction
    predictions = model.predict(img_array)
    predicted_class_index = np.argmax(predictions, axis=1)[0]  # Get highest probability index
    predicted_class_label = class_labels[predicted_class_index]

    print(f"🔮 Predicted Class: {predicted_class_label} (Confidence: {np.max(predictions) * 100:.2f}%)")
    return predicted_class_label


### 🔹 Example Usage ###
# Define class labels (ensure these match your dataset)
dataset_path = "dataset/garbage_classification"
class_labels = sorted(os.listdir(dataset_path))

# Path to the image you want to classify
test_image_path = "dataset/garbage_classification/clothes/clothes1.jpg"  # Change this to the actual image path

# Make a prediction
predicted_label = predict_image(test_image_path, class_labels)
