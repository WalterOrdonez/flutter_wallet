// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginWelcomeBack => 'Welcome Back';

  @override
  String get loginSubtitle =>
      'Enter your username and password to access your account';

  @override
  String get loginUsernameLabel => 'Username';

  @override
  String get loginUsernameHint => 'Enter your username';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginPasswordHint => 'Enter your password';

  @override
  String get loginRememberMe => 'Remember me';

  @override
  String get loginForgotPassword => 'Forgot Password';

  @override
  String get loginSignInButton => 'Sign In';

  @override
  String get loginEmptyFieldsError => 'Enter your username and password';

  @override
  String get authErrorBadRequest => 'Incorrect username or password.';

  @override
  String get authErrorUnauthorized => 'Incorrect username or password.';

  @override
  String get authErrorNotFound => 'User not found.';

  @override
  String get authErrorServerError => 'Server error. Please try again later.';

  @override
  String get authErrorNoInternet =>
      'No internet connection. Check your network.';

  @override
  String get authErrorUnknown =>
      'An unexpected error occurred. Please try again.';
}
