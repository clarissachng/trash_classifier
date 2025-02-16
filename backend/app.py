from flask import Flask, request, jsonify
import tensorflow as tf
import numpy as np

# Load the model
model = tf.keras.models.load_model('efficientnet_model.h5')

app = Flask(__name__)

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Get image from request
        file = request.files['file']
        img = tf.keras.preprocessing.image.load_img(file, target_size=(224, 224))
        img_array = tf.keras.preprocessing.image.img_to_array(img) / 255.0
        img_array = np.expand_dims(img_array, axis=0)

        # Make prediction
        prediction = model.predict(img_array)
        predicted_class = np.argmax(prediction[0])

        return jsonify({'class': int(predicted_class), 'confidence': float(np.max(prediction))})
    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
