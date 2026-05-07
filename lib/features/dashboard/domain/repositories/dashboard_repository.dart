import 'package:bam_wallet_transfers/features/dashboard/domain/entities/product.dart';
import 'package:bam_wallet_transfers/features/dashboard/domain/entities/quick_action.dart';

/// Contrato abstracto del repositorio del dashboard.
/// Define las operaciones disponibles para la capa de dominio.
abstract class DashboardRepository {
  /// Obtiene la lista de productos bancarios del usuario
  Future<List<Product>> getProducts();

  /// Obtiene la lista de acciones rápidas disponibles
  Future<List<QuickAction>> getQuickActions();
}
