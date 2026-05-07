import 'package:shared_preferences/shared_preferences.dart';

/// Singleton para acceder a SharedPreferences en toda la app.
/// Debe inicializarse con `init()` antes de usarse.
class LocalStorage {
  late final SharedPreferences prefs;

  static final LocalStorage _instance = LocalStorage._internal();

  LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  /// Inicializa la instancia de SharedPreferences.
  /// Llamar en el arranque de la app antes de runApp.
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
