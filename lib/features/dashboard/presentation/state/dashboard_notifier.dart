import 'package:bam_wallet_transfers/features/dashboard/domain/use_cases/get_products_use_case.dart';
import 'package:bam_wallet_transfers/features/dashboard/domain/use_cases/get_quick_actions_use_case.dart';
import 'package:bam_wallet_transfers/features/dashboard/presentation/state/dashboard_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier que maneja la lógica de estado del dashboard.
/// Delega la obtención de datos a los use cases.
/// Controla la navegación del carrusel de productos.
class DashboardNotifier extends StateNotifier<DashboardState> {
  final GetProductsUseCase _getProductsUseCase;
  final GetQuickActionsUseCase _getQuickActionsUseCase;

  DashboardNotifier({
    GetProductsUseCase? getProductsUseCase,
    GetQuickActionsUseCase? getQuickActionsUseCase,
  }) : _getProductsUseCase = getProductsUseCase ?? GetProductsUseCase(),
       _getQuickActionsUseCase =
           getQuickActionsUseCase ?? GetQuickActionsUseCase(),
       super(const DashboardState());

  /// Carga los datos iniciales del dashboard a través de los use cases
  Future<void> loadDashboard() async {
    state = state.copyWith(status: DashboardStatus.loading);

    try {
      final products = await _getProductsUseCase.call();
      final quickActions = await _getQuickActionsUseCase.call();

      state = state.copyWith(
        status: DashboardStatus.loaded,
        products: products,
        quickActions: quickActions,
      );
    } catch (e) {
      state = state.copyWith(
        status: DashboardStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// Actualiza el índice del producto visible en el carrusel
  void updateCurrentProductIndex(int index) {
    state = state.copyWith(currentProductIndex: index);
  }

  /// Navega a la página siguiente del carrusel
  void goToNextProduct() {
    final nextIndex = state.currentProductIndex + 1;
    if (nextIndex < state.products.length) {
      state = state.copyWith(currentProductIndex: nextIndex);
    }
  }

  /// Navega a la página anterior del carrusel
  void goToPreviousProduct() {
    final prevIndex = state.currentProductIndex - 1;
    if (prevIndex >= 0) {
      state = state.copyWith(currentProductIndex: prevIndex);
    }
  }

  /// Navega a una página específica del carrusel
  void goToProduct(int index) {
    if (index >= 0 && index < state.products.length) {
      state = state.copyWith(currentProductIndex: index);
    }
  }
}

/// Provider del DashboardNotifier para inyectar en la UI
final dashboardNotifierProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
      final notifier = DashboardNotifier();
      notifier.loadDashboard();
      return notifier;
    });
