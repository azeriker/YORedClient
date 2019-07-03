import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'http_helper.dart';
import 'auth_storage.dart';
import 'dart:async';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _loginScreenState();
}

class _loginScreenState extends State<LoginScreen> {
  String _phone = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildBar(context),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text("Вход"),
      centerTitle: true,
    );
  }

  Widget _buildButtons() {
    return new Container(
      child: new Column(
        children: <Widget>[
          RaisedButton(
            child: new Text('Войти'),
            onPressed: _loginPressed,
          ),
        ],
      ),
    );
  }

  Widget _buildTextFields() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              onChanged: (t) => _phone = t,
              maxLength: 11,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  labelText: 'Телефон',
                  icon: Icon(Icons.phone_iphone),
                  hintText: '79993332244'),
            ),
          ),
          new Container(
            child: new TextField(
              onChanged: (t) => _password = t,
              //controller: _passwordFilter,
              decoration: new InputDecoration(
                labelText: 'Пароль',
                icon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  void _loginPressed() {
    print('The user wants to login with $_phone and $_password');
    HttpHelper.Login(new AuthRequest(_phone, _password))
        .then((response) async => {
              print("get response"),
              await AuthStorage.writeAuth(response.token),
              Navigator.pushReplacementNamed(context, '/home/${response.token}')
            });
  }
}
