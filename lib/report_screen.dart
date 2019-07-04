import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yo_red/http_helper.dart';
import 'image_picker.dart';
import 'dart:io';

class ReportScreen extends StatelessWidget {
  ReportScreen(this.token);

  var title;
  var description;
  List<String> base64Images;
  var long;
  var lat;

  var token;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextField(
        onChanged: (t) => title = t,
        decoration: InputDecoration(
            labelText: 'Название',
            icon: Icon(Icons.short_text),
            hintText: 'Краткое описание'),
      ),
      TextField(
        onChanged: (t) => description = t,
        decoration: InputDecoration(

            labelText: 'Описание',
            icon: Icon(Icons.comment),
            hintText: 'Полное описание ситуации/проблемы'),
        minLines: 5,
        maxLines: 5,
      ),
      Expanded(child: ImageList(_imageListCallback)),
      new RaisedButton(child: new Text('Отправить'), onPressed: ()=>_sendPressed(context))
    ]);
  }

  void _imageListCallback(List<File> files) {
    print("callback ${files.length}");
    base64Images = [];
    for (var file in files) {
      base64Images.add(base64Encode(file.readAsBytesSync()));
    }
  }

  void _sendPressed(context) {
    var report = new ReportResponse();
    report.description = description;
    report.title = title;
    report.photos = base64Images;

    HttpHelper.PostReport(report, token).then((success) => {
      if(success == true)
      {
        Navigator.pushReplacementNamed(context, '/home/${token}')
      }
    });
    print("${base64Images.length}");
  }
}

class ImageList extends StatefulWidget {
  var callback;
  ImageList(this.callback);
  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  final List<File> images = [];

  _addItem(File file) {
    images.add(file);
    widget.callback(images);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        ImagePickerWidget((file) async => (_addItem(await file))),
        Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Container(
                      child: Image.file(images[index], width: 100, height: 100),
                      padding: const EdgeInsets.all(10));
                })),
      ],
    );
  }
}

/*Column(
        children: <Widget>[
          TextField(
            onChanged: title,
            decoration: InputDecoration(
                labelText: 'Название',
                icon: Icon(Icons.short_text),
                hintText: 'Краткое описание'),
          ),
          TextField(
            onChanged: description,
            decoration: InputDecoration(
                labelText: 'Описание',
                icon: Icon(Icons.comment),
                hintText: 'Полное описание ситуации/проблемы'),
                minLines: 5,
                maxLines: 5,
          ),
          ListView.builder(
            itemBuilder: (context,index)=> Text("Done"),
          )
          ImagePickerWidget((file)=>
            showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Center(
                child: LimitedBox(
              child: Image.file(file),
              maxHeight: 300,
            ));
          })
          )
        ],
      ),
      */
