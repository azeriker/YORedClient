import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthResponse {
  String token;
  String login;

  AuthResponse({this.token, this.login});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      login: json['login'],
    );
  }
}

class AuthRequest {
  final String phone;
  final String password;

  AuthRequest(this.phone, this.password);

  Map<String, dynamic> toJson() =>
    {
      'login': phone,
      'password': password,
    };
}

class HttpHelper{
  static Future<AuthResponse> Login(AuthRequest request) async {
    return http.post("http://10.0.2.2:5000/api/auth/token?login=${request.phone}&password=${request.password}").then((response) {
      final int statusCode = response.statusCode;
      print(statusCode);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Неправильное имя пользователя или пароль");
      }
      return AuthResponse.fromJson(json.decode(response.body));
    });
  }
}