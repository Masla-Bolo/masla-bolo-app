import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'styles/styles.dart';

class ImageHelper {
  final picker = ImagePicker();
  Future<XFile?> getImage(ImageSource source) async {
    final file = await picker.pickImage(source: source);
    if (file != null) {
      return file;
    }
    return null;
  }

  Future<XFile?> showOptions(BuildContext context) async {
    return await showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              'Photo Gallery',
              style: Styles.semiBoldStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSecondary),
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
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSecondary),
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
}
