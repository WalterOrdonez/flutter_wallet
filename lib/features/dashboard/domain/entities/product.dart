import 'package:flutter/material.dart';

/// Entidad de dominio que representa un producto bancario del usuario
class Product {
  final String id;
  final String productType;
  final String balance;
  final String accountNumber;
  final String holderName;
  final Color backgroundColor;
  final Color accentColor;
  final IconData icon;

  const Product({
    required this.id,
    required this.productType,
    required this.balance,
    required this.accountNumber,
    required this.holderName,
    required this.backgroundColor,
    required this.accentColor,
    required this.icon,
  });
}
