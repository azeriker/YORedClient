import 'package:flutter/material.dart';
import 'image_picker.dart';
import 'dart:io';

class ReportScreen extends StatelessWidget {
  var title;
  var description;
  List<String> images;
  var long;
  var lat;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:<Widget>[
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
          Expanded(child:ImageList()),
          new RaisedButton(
            child: new Text('Отправить'),
            onPressed: _loginPressed)
          ]
    );
  }
  void _loginPressed()
  {

  }
}


class ImageList extends StatefulWidget {
  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  final List<File> images = [];

  _addItem(File file) {

    images.add(file);

    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        ImagePickerWidget((file) async =>(_addItem(await file))),
        Expanded( child:
        ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Container(child: Image.file(images[index],width: 100, height: 100), padding: const EdgeInsets.all(10));
          })),
        ] ,
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