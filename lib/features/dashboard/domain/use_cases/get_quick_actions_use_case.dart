import 'package:bam_wallet_transfers/features/dashboard/data/repositories/dashboard_repository_imp.dart';
import 'package:bam_wallet_transfers/features/dashboard/domain/entities/quick_action.dart';
import 'package:bam_wallet_transfers/features/dashboard/domain/repositories/dashboard_repository.dart';

/// Caso de uso para obtener las acciones rápidas del dashboard.
class GetQuickActionsUseCase {
  final DashboardRepository _repository;

  GetQuickActionsUseCase({DashboardRepository? repository})
    : _repository = repository ?? DashboardRepositoryImp();

  /// Ejecuta el caso de uso y retorna la lista de acciones rápidas
  Future<List<QuickAction>> call() async {
    return await _repository.getQuickActions();
  }
}
