import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'dart:io' as io;
import '../helpers/styles/styles.dart';

class ImageService {
  final picker = ImagePicker();
  Future<XFile?> getImage(ImageSource source) async {
    final file = await picker.pickImage(source: source);
    if (file != null) {
      return file;
    }
    return null;
  }

  Future<XFile?> showOptions() async {
    return await showCupertinoModalPopup(
      context: AppNavigation.context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              'Photo Gallery',
              style: Styles.semiBoldStyle(
                  family: FontFamily.varela,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
            onPressed: () async {
              final file = await getImage(ImageSource.gallery);
              if (context.mounted) {
                Navigator.of(context).pop(file);
              }
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Camera',
              style: Styles.semiBoldStyle(
                  family: FontFamily.varela,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              final file = await getImage(ImageSource.camera);
              if (context.mounted) {
                Navigator.of(context).pop(file);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<String?> uploadImage() async {
    late UploadTask uploadTask;
    final file = await showOptions();
    if (file != null) {
      final url = await loader(() async {
        final path = "images/${file.name}";
        final ref = FirebaseStorage.instance.ref().child(path);

        final metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': file.path},
        );
        uploadTask = ref.putFile(io.File(file.path), metadata);
        final snapshot = await uploadTask.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      });
      return url.toString();
    }
    return null;
  }
}
