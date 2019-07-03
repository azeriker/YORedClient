import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  var _onSuccess;
  ImagePickerWidget(this._onSuccess);

  @override
  ImagePickerWidgetState createState() => ImagePickerWidgetState();
}

class ImagePickerWidgetState extends State<ImagePickerWidget> {
  File _file;

  void _getImageFromPhotoLibrary(context) {
    _getFile(ImageSource.gallery, context);
  }

  void _getFromCamera(context) {
    _getFile(ImageSource.camera, context);
  }

  Future<void> _getFile(ImageSource source, BuildContext context) async {
    try {
      print(source);
      await ImagePicker.pickImage(source: source)
          .then((file) => widget._onSuccess(file));
    } catch (e) {
      print(e);
    }
  }

  void _showBottomSheet(context) {
    if (_file != null) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Center(
                child: LimitedBox(
              child: Image.file(_file),
              maxHeight: 300,
            ));
          });
    }
  }

  String get buttonText => "Сделать фотографию";

  IconData get buttonIcon => Icons.photo_camera;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton.icon(
            icon: Icon(buttonIcon),
            label: Text(buttonText),
            onPressed: () {
              _getFromCamera(context);
            },
          ),
          RaisedButton.icon(
            icon: Icon(Icons.photo),
            label: Text("Выбрать из каталога"),
            onPressed: () {
              _getImageFromPhotoLibrary(context);
            },
          )
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ));
  }
}
