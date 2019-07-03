import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yo_red/http_helper.dart';

class AllActivityScreen extends StatefulWidget {
 final Color color;
 List<ReportResponse> reports; 

 AllActivityScreen(this.color){

    HttpHelper.GetAllReports()
        .then((response) async => {
          print(response),
          reports = response
        });
 }

 @override
 Widget build(BuildContext context) {
   return new ListView.builder
      (
        itemCount: reports.length,
        itemBuilder: (BuildContext ctxt, int index) {
          var report = reports[index];
          return new ListTile(
          //leading: Image.memory(BASE64.decode(report.photos.first())),
          title: Text(report.title),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            print('kek');
          });
      });

   /*return ListView(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(horseUrl),
          ),
          title: Text('Horse'),
          subtitle: Text('A strong animal'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            print('horse');
          },
          selected: true,
        ))*/
 }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}