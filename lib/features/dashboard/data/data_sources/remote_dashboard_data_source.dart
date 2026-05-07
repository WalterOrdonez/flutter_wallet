import 'package:bam_wallet_transfers/features/dashboard/data/models/product_model.dart';
import 'package:bam_wallet_transfers/features/dashboard/data/models/quick_action_model.dart';
import 'package:flutter/material.dart';

/// Data source remoto del dashboard (mock).
/// Simula el consumo de una API que retorna productos y acciones rápidas.
class RemoteDashboardDataSource {
  /// Simula la obtención de productos bancarios desde la API
  Future<List<ProductDataModel>> getProducts() async {
    // Simula latencia de red
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock de respuesta de API
    final List<Map<String, dynamic>> response = [
      {
        'id': 'prod_001',
        'productType': 'Tarjeta de Débito',
        'balance': 'Q 12,450.00',
        'accountNumber': '•••• •••• •••• 8635',
        'holderName': 'Walter Ordoñez',
        'backgroundColorHex': 0xFF4A7CF7,
        'accentColorHex': 0xFF6C63FF,
        'iconCodePoint': Icons.credit_card.codePoint,
      },
      {
        'id': 'prod_002',
        'productType': 'Cuenta de Ahorro',
        'balance': 'Q 45,230.50',
        'accountNumber': '0101-2345-6789',
        'holderName': 'Walter Ordoñez',
        'backgroundColorHex': 0xFF2E7D32,
        'accentColorHex': 0xFF43A047,
        'iconCodePoint': Icons.account_balance_wallet.codePoint,
      },
      {
        'id': 'prod_003',
        'productType': 'Préstamo Personal',
        'balance': 'Q 8,500.00',
        'accountNumber': 'Cuota: Q 1,200.00/mes',
        'holderName': 'Walter Ordoñez',
        'backgroundColorHex': 0xFFF27141,
        'accentColorHex': 0xFFF2BF27,
        'iconCodePoint': Icons.monetization_on.codePoint,
      },
    ];

    return response.map((json) => ProductDataModel.fromJson(json)).toList();
  }

  /// Simula la obtención de acciones rápidas desde la API
  Future<List<QuickActionDataModel>> getQuickActions() async {
    // Simula latencia de red
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock de respuesta de API
    final List<Map<String, dynamic>> response = [
      {
        'id': 'action_001',
        'iconCodePoint': Icons.swap_horiz.codePoint,
        'label': 'Transferir',
        'iconColorHex': 0xFF4CAF50,
      },
      {
        'id': 'action_002',
        'iconCodePoint': Icons.receipt_long.codePoint,
        'label': 'Pagar',
        'iconColorHex': 0xFF5C6BC0,
      },
      {
        'id': 'action_003',
        'iconCodePoint': Icons.account_balance.codePoint,
        'label': 'Entre Cuentas',
        'iconColorHex': 0xFF757575,
      },
      {
        'id': 'action_004',
        'iconCodePoint': Icons.phone_android.codePoint,
        'label': 'Recargar',
        'iconColorHex': 0xFFF27141,
      },
      {
        'id': 'action_005',
        'iconCodePoint': Icons.qr_code_scanner.codePoint,
        'label': 'Escanear QR',
        'iconColorHex': 0xFF00897B,
      },
    ];

    return response.map((json) => QuickActionDataModel.fromJson(json)).toList();
  }
}
