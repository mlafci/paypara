import 'dart:convert';
import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paypara/ui/view_models/image_picker/image_picker_model.dart';

class ImagePickerController {
  static getImageFromGallery(ImagePickerModel imagePickerModel) async {
    XFile pickedImage = await imagePickerModel.picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      File croppedImage = await imageCropper(pickedImage);
      var imageBytes = croppedImage.readAsBytesSync();
      imagePickerModel.image = base64Encode(imageBytes);
    }
  }

  static getImageFromCamera(ImagePickerModel imagePickerModel, bool isCheque) async {
    XFile pickedImage = await imagePickerModel.picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      File croppedImage = await imageCropper(pickedImage);
      var imageBytes = croppedImage.readAsBytesSync();
      imagePickerModel.image = base64Encode(imageBytes);
    }
  }

  static imageCropper(XFile pickedImage) async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: pickedImage.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    return cropped;
  }
}
