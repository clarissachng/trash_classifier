import torch
import torchvision.transforms as transforms
import io
from PIL import Image

# Load EfficientNetV2-B1 model from .pth file
model = torch.load('models/efficientnetv2_b1_waste_model.pth')
model.eval()

# Image transformations
transform = transforms.Compose([
    transforms.Resize((224, 224)),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
])

# 12 Household Waste Categories
CATEGORIES = [
    'paper', 'cardboard', 'biological', 'metal',
    'plastic', 'green-glass', 'brown-glass', 'white-glass',
    'clothes', 'shoes', 'batteries', 'trash'
]

def classify_image(image_bytes):
    """Classify waste into 12 categories using EfficientNetV2-B1."""
    try:
        img = Image.open(io.BytesIO(image_bytes))
        img_t = transform(img).unsqueeze(0)

        with torch.no_grad():
            output = model(img_t)
            _, predicted = torch.max(output, 1)

        return CATEGORIES[predicted.item()]
    except Exception as e:
        print(f"Classification error: {e}")
        return None
