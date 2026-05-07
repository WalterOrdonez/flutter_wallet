import 'package:bam_wallet_transfers/features/dashboard/data/repositories/dashboard_repository_imp.dart';
import 'package:bam_wallet_transfers/features/dashboard/domain/entities/product.dart';
import 'package:bam_wallet_transfers/features/dashboard/domain/repositories/dashboard_repository.dart';

/// Caso de uso para obtener los productos bancarios del usuario.
class GetProductsUseCase {
  final DashboardRepository _repository;

  GetProductsUseCase({DashboardRepository? repository})
    : _repository = repository ?? DashboardRepositoryImp();

  /// Ejecuta el caso de uso y retorna la lista de productos
  Future<List<Product>> call() async {
    return await _repository.getProducts();
  }
}
