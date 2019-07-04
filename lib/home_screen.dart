import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:yo_red/all_activity_screen.dart';
import 'package:yo_red/auth_storage.dart';
import 'package:yo_red/report_info_screen.dart';
import 'report_screen.dart';

class HomeScreen extends StatefulWidget {
  String token;
  HomeScreen(this.token);

  @override
  State<StatefulWidget> createState() {
    return _HomeState(token);
  }
}

class _HomeState extends State<HomeScreen> {
  int _currentIndex = 0;
  var token="";
  _HomeState(this.token){
    _children = [
      AllActivityScreen(token),
      ReportScreen(token),
      AllActivityScreen(token)];
  }

  List<Widget> _children = [];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Привет, ${widget.token}'), actions: <Widget>[
        // action button
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            AuthStorage.clearAuth();
            Navigator.pushReplacementNamed(context, '/login');
          },
        )
      ]),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.library_books),
            title: new Text('Лента'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.send),
            title: new Text('Сообщить'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), title: Text('Моя активность'))
        ],
      ),
    );
  }
}
