import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahl_edu/core/resources/resources.dart';
import 'package:sahl_edu/core/utils/alerts.dart';

class Pickers {
  static Future<File?> pickImage(ImageSource imageSource) async {
    try {
      XFile? image = await ImagePicker().pickImage(source: imageSource);
      return image != null ? File(image.path) : null;
    } on PlatformException catch (_) {
      Alerts.showToast(AppStrings.errorOccurred);
      return null;
    }
  }
}
