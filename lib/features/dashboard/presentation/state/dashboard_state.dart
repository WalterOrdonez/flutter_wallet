import 'package:bam_wallet_transfers/features/dashboard/domain/entities/product.dart';
import 'package:bam_wallet_transfers/features/dashboard/domain/entities/quick_action.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_state.freezed.dart';

/// Representa los posibles estados del dashboard
enum DashboardStatus { initial, loading, loaded, error }

/// Estado inmutable del dashboard generado con Freezed.
@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(DashboardStatus.initial) DashboardStatus status,
    @Default([]) List<Product> products,
    @Default([]) List<QuickAction> quickActions,
    @Default(0) int currentProductIndex,
    String? errorMessage,
  }) = _DashboardState;
}

/// Extensión para propiedades computadas del estado
extension DashboardStateX on DashboardState {
  bool get isLoading => status == DashboardStatus.loading;
}
