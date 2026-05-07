// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get loginWelcomeBack => 'Bienvenido de nuevo';

  @override
  String get loginSubtitle =>
      'Ingresa tu usuario y contraseña para acceder a tu cuenta';

  @override
  String get loginUsernameLabel => 'Usuario';

  @override
  String get loginUsernameHint => 'Ingresa tu usuario';

  @override
  String get loginPasswordLabel => 'Contraseña';

  @override
  String get loginPasswordHint => 'Ingresa tu contraseña';

  @override
  String get loginRememberMe => 'Recordarme';

  @override
  String get loginForgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get loginSignInButton => 'Iniciar sesión';

  @override
  String get loginEmptyFieldsError => 'Ingresa tu usuario y contraseña';

  @override
  String get authErrorBadRequest => 'Usuario o contraseña incorrectos.';

  @override
  String get authErrorUnauthorized => 'Usuario o contraseña incorrectos.';

  @override
  String get authErrorNotFound => 'Usuario no encontrado.';

  @override
  String get authErrorServerError => 'Error en el servidor. Intenta más tarde.';

  @override
  String get authErrorNoInternet => 'Sin conexión a internet. Verifica tu red.';

  @override
  String get authErrorUnknown =>
      'Ocurrió un error inesperado. Intenta de nuevo.';
}
