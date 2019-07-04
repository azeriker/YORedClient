import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
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

  Map<String, dynamic> toJson() => {
        'login': phone,
        'password': password,
      };
}

class ListReportResponse {
  List<ReportResponse> reports;

  ListReportResponse({this.reports});

  factory ListReportResponse.fromJson(Map<String, dynamic> json) {
    return ListReportResponse(reports: json['reports']);
  }
}

class ReportResponse {
  String id;
  String title;
  List<String> photos;
  DateTime date;
  String description;
  ReportStatus status;
  String comment;
  String latitude;
  String longitude;

  ReportResponse(
      {this.id,
      this.title,
      this.photos,
      this.date,
      this.description,
      this.status,
      this.comment,
      this.latitude,
      this.longitude});

  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    return ReportResponse(
      id: json['id'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      description: json['description'],
      status: ReportStatus.values[json['status']],
      comment: json['comment'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      photos: List.from(json['photos']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'photos': photos,
        'date': date,
        'description': description,
        'status': status,
        'comment': comment,
        'latitude': latitude,
        'longitude': longitude
      };
}

enum ReportStatus { New, InProgress, Done, Rejected }

class HttpHelper {
  static Future<AuthResponse> Login(AuthRequest request) async {
    return http
        .post(
            "http://10.0.2.2:5000/api/auth/token?login=${request.phone}&password=${request.password}")
        .then((response) {
      final int statusCode = response.statusCode;
      print(statusCode);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Неправильное имя пользователя или пароль");
      }
      return AuthResponse.fromJson(json.decode(response.body));
    });
  }

  static Future<bool> PostReport(ReportResponse report, token) async {
    var body = jsonEncode(report);
    print(body);
    return http.post(
        "http://10.0.2.2:5000/api/Reports/Create",
         body :body, headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          "Content-Type": "application/json"
        }).then((response) {
      final int statusCode = response.statusCode;
      print(statusCode);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        return false;
      }
      print("response ${response.body}");
      return true;
    });
  }

  static Future<List<ReportResponse>> GetAllReports(token) async {
    return http.get("http://10.0.2.2:5000/api/Reports/Get", headers: {
      HttpHeaders.authorizationHeader: "Bearer $token"
    }).then((response) {
      final int statusCode = response.statusCode;
      print(statusCode);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Ошибка при загрузке заявок");
      }

      Iterable l = json.decode(response.body);
      List<ReportResponse> reports =
          l.map((model) => ReportResponse.fromJson(model)).toList();
      return reports;
    });
  }

  static Future<List<ReportResponse>> GetMyReports(token) async {
    return http.get("http://10.0.2.2:5000/api/Reports/GetByUser", headers: {
      HttpHeaders.authorizationHeader: "Bearer $token"
    }).then((response) {
      final int statusCode = response.statusCode;
      print(statusCode);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Ошибка при загрузке заявок");
      }

      Iterable l = json.decode(response.body);
      List<ReportResponse> reports =
          l.map((model) => ReportResponse.fromJson(model)).toList();
      return reports;
    });
  }

  static Future<ReportResponse> GetReport(String id) async {
    return http
        .get("http://10.0.2.2:5000/api/reports/getById?id=" + id)
        .then((response) {
      final int statusCode = response.statusCode;
      print(statusCode);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Ошибка при загрузке заявки");
      }

      var report = ReportResponse.fromJson(json.decode(response.body));
      return report;
    });
  }
}
