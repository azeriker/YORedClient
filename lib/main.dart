import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import 'home_screen.dart';
import 'login_screen.dart';

Future<void> main() async {
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: LoginScreen(),
      initialRoute: '/',
      routes: {
      '/login': (context) => LoginScreen(),
      '/home': (context) => HomeScreen(""),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'home') {
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => HomeScreen(pathElements[2]),
          );
        }
        return null;
      },
    ),
  );
}



