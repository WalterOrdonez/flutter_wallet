import 'package:bam_wallet_transfers/core/error/exceptions.dart';
import 'package:bam_wallet_transfers/features/auth/data/constants/api_consts.dart';
import 'package:bam_wallet_transfers/features/auth/data/constants/auth_error_consts.dart';
import 'package:bam_wallet_transfers/features/auth/data/data_sources/local_auth_data_source.dart';
import 'package:bam_wallet_transfers/features/auth/data/data_sources/remote_auth_data_source.dart';
import 'package:bam_wallet_transfers/features/auth/data/models/login_request_model.dart';
import 'package:bam_wallet_transfers/features/auth/domain/entities/user.dart';
import 'package:bam_wallet_transfers/features/auth/domain/repositories/authentication_repository.dart';

/// Implementación concreta del repositorio de autenticación.
/// Coordina entre data sources remotos y locales.
/// Personaliza los mensajes de error según el código de respuesta.
class AuthenticationRepositoryImp implements AuthenticationRepository {
  final RemoteAuthenticationDataSource _remoteDataSource;
  final LocalAuthDataSource _localDataSource;

  AuthenticationRepositoryImp({
    RemoteAuthenticationDataSource? remoteDataSource,
    LocalAuthDataSource? localDataSource,
  }) : _remoteDataSource = remoteDataSource ?? RemoteAuthenticationDataSource(),
       _localDataSource = localDataSource ?? LocalAuthDataSource();

  @override
  Future<User> login({
    required String username,
    required String password,
  }) async {
    final request = LoginRequestModel(
      username: username,
      password: password,
      expiresInMins: AuthApiConsts.tokenExpiresInMins,
    );

    try {
      final loginResponse = await _remoteDataSource.login(request);
      await _localDataSource.saveSession(loginResponse);
      return User.fromLoginResponse(loginResponse);
    } on ServerException catch (e) {
      throw Exception(_mapServerError(e.statusCode));
    } on NoInternetException {
      throw Exception(AuthErrorConsts.noInternet);
    } catch (_) {
      throw Exception(AuthErrorConsts.unknown);
    }
  }

  @override
  Future<void> signOut() async {
    await _localDataSource.clearSession();
  }

  @override
  Future<bool> isSignedIn() async {
    return await _localDataSource.hasActiveSession();
  }

  @override
  Future<User?> getCurrentUser() async {
    final cachedUser = await _localDataSource.getCachedUser();
    if (cachedUser == null) {
      return null;
    }
    return User.fromLoginResponse(cachedUser);
  }

  /// Mapea el código de error HTTP a la constante de mensaje correspondiente
  String _mapServerError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return AuthErrorConsts.badRequest;
      case 401:
        return AuthErrorConsts.unauthorized;
      case 404:
        return AuthErrorConsts.notFound;
      case 500:
        return AuthErrorConsts.serverError;
      default:
        return AuthErrorConsts.unknown;
    }
  }
}
