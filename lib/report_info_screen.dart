import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:yo_red/http_helper.dart';

class ReportInfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ReportInfoScreenState();
  }
}

class ReportInfoScreenState extends State<ReportInfoScreen> {
  ReportResponse report = new ReportResponse();
  
  ReportInfoScreenState() {
    HttpHelper.GetReport("5d1cdfb6905ecc487cf940a4").then((response) async =>
        {print(response), report = response, setState(() {})});
  }

  @override
  Widget build(BuildContext context) {
    var labelFontWeight = FontWeight.bold;
    var textFontSize = 20.0;

    var base64Images = []; 
    for (var file in report.photos) { 
      base64Images.add(base64Decode(file)); 
    } 

    var image = Image.memory(base64Images[0], width: 100, height: 100);
    return image;

    return new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.all(10),
              child: new Row(
                children: <Widget>[
                  Text("Заголовок: ", style: TextStyle(
                    fontWeight: labelFontWeight, fontSize: textFontSize)),
                  Text(report.title, style: TextStyle(fontSize: textFontSize))
                ],
              )
            ),
            new Container(
              padding: const EdgeInsets.all(10),
              child: new Row(
                children: <Widget>[
                  Text("Дата: ", style: TextStyle(
                    fontWeight: labelFontWeight, fontSize: textFontSize)),
                  Text(report.date.toString(), style: TextStyle(fontSize: textFontSize))
                ],
              )
            ),
            new Container(
              padding: const EdgeInsets.all(10),
              child: new Row(
                children: <Widget>[
                  Text("Статус: ", style: TextStyle(
                    fontWeight: labelFontWeight, fontSize: textFontSize)),
                  Text(report.status.toString(), style: TextStyle(fontSize: textFontSize))
                ],
              )
            ),
            new Container(
              padding: const EdgeInsets.all(10),
              child: new Row(
                children: <Widget>[
                  Text("Описание: ", style: TextStyle(
                    fontWeight: labelFontWeight, fontSize: textFontSize)),
                  Text(report.description, maxLines: 4, style: TextStyle(fontSize: textFontSize))
                ],
              )
            ),
            new Container(
              padding: const EdgeInsets.all(10),
              child: new Row(
                children: <Widget>[
                  Text("Комментарий: ", style: TextStyle(
                    fontWeight: labelFontWeight, fontSize: textFontSize)),
                  Text(report.description, maxLines: 4, style: TextStyle(fontSize: textFontSize))
                ],
              )
            ),
            new Container(
              padding: const EdgeInsets.all(10),
              child: new Row(
                children: <Widget>[
                  Text("Широта: ", style: TextStyle(
                    fontWeight: labelFontWeight, fontSize: textFontSize)),
                  Text(report.latitude, style: TextStyle(fontSize: textFontSize))
                ],
              )
            ),
            new Container(
              padding: const EdgeInsets.all(10),
              child: new Row(
                children: <Widget>[
                  Text("Долгота: ", style: TextStyle(
                    fontWeight: labelFontWeight, fontSize: textFontSize)),
                  Text(report.longitude, style: TextStyle(fontSize: textFontSize))
                ],
              )
            ),
            /*new Container(
              padding: const EdgeInsets.all(10),
              child: new Column(children: <Widget>[
                  ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  itemCount: base64Images.length,
                  itemBuilder: (context, index) {
                    return Container(child: Image.memory(base64Images[index], width: 100, height: 100), padding: const EdgeInsets.all(10));
                  })
                ])
            )*/
          ]
        )
      );

    /*return new ListTile(
        //leading: Image.memory(BASE64.decode(report.photos.first())),
        title: Text(report.title),
        trailing: report.status == ReportStatus.New
            ? Icon(Icons.alarm_add)
            : Icon(report.status == ReportStatus.InProgress
                ? Icons.alarm
                : (report.status == ReportStatus.Done
                    ? Icons.thumb_up
                    : Icons.thumb_down)),
        subtitle: Text(DateFormat('kk:mm dd-MM-yyyy').format(report.date)),
        onTap: () {
          print('kek');
        });*/
  }
}
