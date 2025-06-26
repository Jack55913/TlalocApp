import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:provider/provider.dart';

class FormPhotoSender extends StatefulWidget {
  final void Function(File? file)? onImageSelected;

  const FormPhotoSender({super.key, this.onImageSelected});

  @override
  State<FormPhotoSender> createState() => _FormPhotoSenderState();
}

class _FormPhotoSenderState extends State<FormPhotoSender> {
  File? selectedImageFile;
  Uint8List? selectedWebImage;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source, imageQuality: 75);

    if (picked != null) {
      final file = File(picked.path);
      setState(() {
        selectedImageFile = file;
        selectedWebImage = null;
      });
      widget.onImageSelected?.call(file);
    }
  }

  Future<void> _pickImageWeb() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.bytes != null) {
      final imageBytes = result.files.single.bytes!;
      setState(() {
        selectedWebImage = imageBytes;
        selectedImageFile = null;
      });
      context.read<AppState>().newWebImage = imageBytes;
      widget.onImageSelected?.call(null); // para web, no es File
    }
  }

  void _removeImage() {
    setState(() {
      selectedImageFile = null;
      selectedWebImage = null;
    });
    context.read<AppState>().newWebImage = null;
    widget.onImageSelected?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = selectedImageFile != null || selectedWebImage != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasImage)
          Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: kIsWeb
                      ? Image.memory(selectedWebImage!, width: 200)
                      : Image.file(selectedImageFile!, width: 200),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: _removeImage,
              )
            ],
          ),
        Row(
          children: [
            if (kIsWeb)
              ElevatedButton.icon(
                onPressed: _pickImageWeb,
                icon: const Icon(Icons.image),
                label: const Text("Seleccionar imagen"),
              )
            else ...[
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: const Icon(Icons.camera_alt),
                label: const Text("Cámara"),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: const Icon(Icons.image),
                label: const Text("Galería"),
              ),
            ]
          ],
        )
      ],
    );
  }
}
