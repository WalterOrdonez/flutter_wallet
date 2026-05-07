import 'package:bam_wallet_transfers/core/local_storage.dart';
import 'package:bam_wallet_transfers/core/navigation/app_routes.dart';
import 'package:bam_wallet_transfers/core/utils/jwt_decoder.dart';
import 'package:bam_wallet_transfers/features/auth/presentation/state/auth_notifier.dart';
import 'package:bam_wallet_transfers/features/auth/presentation/state/auth_state.dart';
import 'package:bam_wallet_transfers/features/auth/presentation/views/login_view.dart';
import 'package:bam_wallet_transfers/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:bam_wallet_transfers/features/history/presentation/views/history_view.dart';
import 'package:bam_wallet_transfers/features/settings/presentation/views/settings_view.dart';
import 'package:bam_wallet_transfers/features/transfers/presentation/views/transfers_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Key del token en SharedPreferences (misma que usa LocalAuthDataSource)
const String _accessTokenKey = 'auth_access_token';

/// Provider del GoRouter que maneja la navegación de toda la app.
/// Incluye redirect de autenticación con validación de expiración del token
/// en cada navegación.
final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = _AuthRefreshNotifier(ref);

  return GoRouter(
    initialLocation: AppRoutes.dashboard,
    refreshListenable: notifier,
    redirect: (context, state) {
      final authState = ref.read(authNotifierProvider);
      final isLoggingIn = state.matchedLocation == AppRoutes.login;
      final isAuthenticated = authState.status == AuthStatus.authenticated;

      // Si está autenticado, validar que el token no haya expirado
      if (isAuthenticated && !isLoggingIn) {
        final token = LocalStorage().prefs.getString(_accessTokenKey);
        if (token == null || JwtDecoder.isExpired(token)) {
          // Token vencido: cerrar sesión y redirigir a login
          ref.read(authNotifierProvider.notifier).signOut();
          return AppRoutes.login;
        }
      }

      // Si no está autenticado y no está en login, redirigir a login
      if (!isAuthenticated && !isLoggingIn) {
        return AppRoutes.login;
      }

      // Si ya está autenticado y está en login, redirigir a dashboard
      if (isAuthenticated && isLoggingIn) {
        return AppRoutes.dashboard;
      }

      // No redirigir
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardView(),
      ),
      GoRoute(
        path: AppRoutes.transfers,
        builder: (context, state) => const TransfersView(),
      ),
      GoRoute(
        path: AppRoutes.history,
        builder: (context, state) => const HistoryView(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsView(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Ruta no encontrada: ${state.matchedLocation}')),
    ),
  );
});

/// Listenable que notifica al GoRouter cuando el estado de auth cambia.
class _AuthRefreshNotifier extends ChangeNotifier {
  _AuthRefreshNotifier(Ref ref) {
    ref.listen(authNotifierProvider, (previous, next) {
      notifyListeners();
    });
  }
}
