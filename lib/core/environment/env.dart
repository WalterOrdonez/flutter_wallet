import 'dart:convert';

import 'package:flutter/services.dart';

enum Environment { dev, prod }

class Env {
  Env._();
  static Env? _instance;
  static Env get instance {
    if (_instance == null) {
      throw Exception('Env is not initialized');
    }
    return _instance!;
  }

  static String get apiBaseUrl => _values['apiUrl'] as String;
  static String get apiKey => _values['apiKey'] as String;
  static String get appName => _values['appName'] as String;

  //final String apiBaseUrl;
  static Map<String, dynamic> _values = {};
  static Map<String, dynamic> get values => _values;

  static late final Environment env;

  static Future<void> init() async {
    String fileName;
    switch (env) {
      case Environment.dev:
        fileName = 'env_dev.json';
        break;
      case Environment.prod:
        fileName = 'env_prod.json';
        break;
    }

    _values = await load(fileName);
  }

  static Future<Map<String, dynamic>> load(String fileName) async {
    return rootBundle.loadString(fileName).then((jsonString) {
      return json.decode(jsonString);
    });
  }

  // Env({required this.apiBaseUrl});
}
