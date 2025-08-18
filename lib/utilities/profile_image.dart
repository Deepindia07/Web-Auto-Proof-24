import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:html' as html; // Only used for web

import 'package:auto_proof/constants/const_image.dart';
import '../constants/const_color.dart';

class ProfileImageUploader extends StatefulWidget {
  const ProfileImageUploader({super.key});

  @override
  State<ProfileImageUploader> createState() => _ProfileImageUploaderState();
}

class _ProfileImageUploaderState extends State<ProfileImageUploader> {
  Uint8List? _imageBytes;

  Future<void> _pickImage() async {
    if (kIsWeb) {
      // Web: use native HTML input element
      final html.FileUploadInputElement input = html.FileUploadInputElement();
      input.accept = 'image/*';
      input.click();

      input.onChange.listen((event) {
        final files = input.files;
        if (files != null && files.isNotEmpty) {
          final reader = html.FileReader();
          reader.readAsArrayBuffer(files[0]);
          reader.onLoadEnd.listen((event) {
            setState(() {
              _imageBytes = reader.result as Uint8List;
            });
          });
        }
      });
    } else {
      // Mobile/Desktop: use FilePicker
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _imageBytes = result.files.first.bytes;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.amber,
            child: CircleAvatar(
              radius: 42,
              backgroundColor: Colors.blueGrey,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: _imageBytes != null
                    ? MemoryImage(_imageBytes!)
                    : const AssetImage(personDarkIcon) as ImageProvider,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 2,
            right: 1,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                Icons.edit,
                color: AppColor().darkCharcoalBlueColor,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
