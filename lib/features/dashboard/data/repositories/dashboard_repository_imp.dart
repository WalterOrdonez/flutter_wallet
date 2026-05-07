import 'package:bam_wallet_transfers/features/dashboard/data/data_sources/remote_dashboard_data_source.dart';
import 'package:bam_wallet_transfers/features/dashboard/domain/entities/product.dart';
import 'package:bam_wallet_transfers/features/dashboard/domain/entities/quick_action.dart';
import 'package:bam_wallet_transfers/features/dashboard/domain/repositories/dashboard_repository.dart';

/// Implementación concreta del repositorio del dashboard.
/// Coordina con el data source remoto para obtener datos.
class DashboardRepositoryImp implements DashboardRepository {
  final RemoteDashboardDataSource _remoteDataSource;

  DashboardRepositoryImp({RemoteDashboardDataSource? remoteDataSource})
    : _remoteDataSource = remoteDataSource ?? RemoteDashboardDataSource();

  @override
  Future<List<Product>> getProducts() async {
    final models = await _remoteDataSource.getProducts();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<QuickAction>> getQuickActions() async {
    final models = await _remoteDataSource.getQuickActions();
    return models.map((model) => model.toEntity()).toList();
  }
}
