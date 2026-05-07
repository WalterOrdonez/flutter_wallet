import 'package:bam_wallet_transfers/core/network/api_client.dart';
import 'package:bam_wallet_transfers/features/auth/data/constants/api_consts.dart';
import 'package:bam_wallet_transfers/features/auth/data/models/login_request_model.dart';
import 'package:bam_wallet_transfers/features/auth/data/models/login_response_model.dart';

/// Data source remoto para operaciones de autenticación.
/// Se comunica con la API de DummyJSON usando Dio a través del ApiClient.
class RemoteAuthenticationDataSource {
  final ApiClient _apiClient;

  RemoteAuthenticationDataSource({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient(baseUrl: AuthApiConsts.baseUrl);

  /// Realiza el login contra el servidor de DummyJSON.
  /// Envía username y password, retorna un [LoginResponseModel]
  /// con tokens y datos del usuario.
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await _apiClient.post(
      AuthApiConsts.loginPath,
      data: request.toJson(),
    );

    return LoginResponseModel.fromJson(response as Map<String, dynamic>);
  }
}
