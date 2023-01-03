import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker(this.onimagePick);

  final Function(File pickedImage) onimagePick;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onimagePick(_pickedImageFile as File);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImageFile != null
              ? FileImage(_pickedImageFile as File)
              : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.purple),
              backgroundColor: MaterialStateProperty.all(Colors.white)),
          label: Text(
            'Adicionar imagem',
          ),
          icon: Icon(Icons.image),
        )
      ],
    );
  }
}
