import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  static String formatDate(DateTime date) {
    return date.day.toString().padLeft(2, '0') +
        '-' +
        date.month.toString().padLeft(2, '0') +
        '-' +
        date.year.toString();
  }

  static Future<void> getImage() async {
    final picker = ImagePicker();

    await picker.getImage(source: ImageSource.camera).then((pickedFile) {
      if (pickedFile != null && pickedFile.path != null) {
        GallerySaver.saveImage(pickedFile.path).then((isSaved) {});
      }
    });
  }
}
