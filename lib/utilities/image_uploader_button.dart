import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploaderButton extends StatelessWidget {
  const ImageUploaderButton({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          children: [
            Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
              size: 32,
            ),
            Text(
              'Add Image',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageHandler {
  BuildContext context;
  File image;
  String name;
  String url;

  ImageHandler(String userId) {
    setName(userId);
  }

  void setName(String userId) {
    this.name = DateTime.now().toString() + '-' + userId;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    this.image = File(pickedFile.path);
  }

  Future<void> uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('recipe_images/${this.name}');

    UploadTask uploadTask = ref.putFile(this.image);
    await uploadTask.then((res) async {
      await res.ref.getDownloadURL().then((url) {
        this.url = url;
      });
    });
  }
}
