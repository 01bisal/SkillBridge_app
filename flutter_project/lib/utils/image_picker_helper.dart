import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  // ✅ Pick image from gallery (Web Compatible)
  static Future<dynamic> pickImageFromGallery(BuildContext context) async {
    // Check permission (skip on web)
    if (!kIsWeb) {
      final status = await Permission.photos.request();
      if (status.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Permission denied to access gallery'),
            backgroundColor: Colors.red,
          ),
        );
        return null;
      }
    }

    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );

    if (image != null) {
      if (kIsWeb) {
        // ✅ For web: return bytes
        final bytes = await image.readAsBytes();
        return bytes;
      } else {
        // ✅ For mobile/desktop: return path
        return image.path;
      }
    }
    return null;
  }

  // ✅ Take photo with camera (Web Compatible)
  static Future<dynamic> pickImageFromCamera(BuildContext context) async {
    // Check permission (skip on web)
    if (!kIsWeb) {
      final status = await Permission.camera.request();
      if (status.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Permission denied to access camera'),
            backgroundColor: Colors.red,
          ),
        );
        return null;
      }
    }

    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );

    if (image != null) {
      if (kIsWeb) {
        // ✅ For web: return bytes
        final bytes = await image.readAsBytes();
        return bytes;
      } else {
        // ✅ For mobile/desktop: return path
        return image.path;
      }
    }
    return null;
  }

  // ✅ Show image picker dialog
  static Future<dynamic> showImagePickerDialog(BuildContext context) async {
    return showDialog<dynamic>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Profile Picture'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF2B2C6B)),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  final result = await pickImageFromGallery(context);
                  if (result != null) {
                    Navigator.pop(context, result);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFF2B2C6B)),
                title: const Text('Take Photo with Camera'),
                onTap: () async {
                  final result = await pickImageFromCamera(context);
                  if (result != null) {
                    Navigator.pop(context, result);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
