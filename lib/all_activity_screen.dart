import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yo_red/http_helper.dart';

class AllActivityScreen extends StatefulWidget {
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

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new AllActivityScreenState();
  }
}

class AllActivityScreenState extends State<AllActivityScreen> {
  List<ReportResponse> reports=[];

  AllActivityScreenState() {
    HttpHelper.GetAllReports()
        .then((response) async => {print(response), this.reports = response});
  }
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: reports.length,
        itemBuilder: (BuildContext ctxt, int index) {
          var report = this.reports[index];
          return new ListTile(
              //leading: Image.memory(BASE64.decode(report.photos.first())),
              title: Text(report.title),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                print('kek');
              });
        });
  }
}
