import 'package:image_picker/image_picker.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();

  // Method to pick an image from the gallery
  Future<String?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      return image?.path;
    } catch (e) {
      print('Failed to pick image: $e');
      return null;
    }
  }

  // Method to capture an image using the camera
  Future<String?> captureImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      return image?.path;
    } catch (e) {
      print('Failed to capture image: $e');
      return null;
    }
  }
}
