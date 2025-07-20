import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/helpers.dart';
import '../navigation/app_navigation.dart';
import 'dart:io' as io;
import '../helpers/styles/styles.dart';

class ImageService {
  final picker = ImagePicker();
  Future<XFile?> getImage(ImageSource source) async {
    final file = await picker.pickImage(source: source);
    return file;
  }

  Future<List<XFile>> getImages() async {
    final files = await picker.pickMultiImage();
    return files.isNotEmpty ? files : [];
  }

  Future<List<XFile>> showOptionsWithMulti() async {
    final result = await showCupertinoModalPopup<List<XFile>>(
      context: AppNavigation.context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              'Photo Gallery',
              style: Styles.semiBoldStyle(
                family: FontFamily.varela,
                fontSize: 15,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            onPressed: () async {
              final files = await getImages();
              if (context.mounted) {
                Navigator.of(context).pop(files); // Always return List<XFile>
              }
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Camera',
              style: Styles.semiBoldStyle(
                family: FontFamily.varela,
                fontSize: 15,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            onPressed: () async {
              final file = await getImage(ImageSource.camera);
              if (context.mounted) {
                Navigator.of(context).pop(file != null ? [file] : []);
              }
            },
          ),
        ],
      ),
    );

    return result ?? [];
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

  Future<String?> uploadImage({XFile? newFile}) async {
    late UploadTask uploadTask;
    XFile? file = newFile ?? await showOptions();
    String? url;
    if (file != null) {
      await loader(() async {
        final path = "images/${file.name}";
        final ref = FirebaseStorage.instance.ref().child(path);
        final metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': file.path},
        );
        uploadTask = ref.putFile(io.File(file.path), metadata);
        final snapshot = await uploadTask.whenComplete(() {});
        url = await snapshot.ref.getDownloadURL();
      });
      return url;
    }
    return null;
  }

  Future<List<String>> uploadImages(List<XFile> files) async {
    if (files.isEmpty) {
      return [];
    }

    final uploadFutures =
        files.map((file) => uploadImage(newFile: file)).toList();
    final results = await Future.wait(uploadFutures);
    final urls =
        results.where((url) => url != null).map((url) => url!).toList();
    return urls;
  }
}
