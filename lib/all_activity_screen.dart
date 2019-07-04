import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:yo_red/http_helper.dart';

class AllActivityScreen extends StatefulWidget {
  var token;
  AllActivityScreen(this.token);
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
    return new AllActivityScreenState(token);
  }
}

class AllActivityScreenState extends State<AllActivityScreen> {
  List<ReportResponse> reports=[];
  AllActivityScreenState(token) {
    HttpHelper.GetAllReports(token)
        .then((response) async => {print(response), reports = response, setState(() { })
        });
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
              trailing: report.status==ReportStatus.New ? Icon(Icons.alarm_add) : Icon(report.status==ReportStatus.InProgress?Icons.alarm: (report.status==ReportStatus.Done?Icons.thumb_up:Icons.thumb_down)),
              subtitle: Text(DateFormat('kk:mm dd-MM-yyyy').format(report.date)),
              onTap: () {
                print('kek');
              });
        });
  }
}
