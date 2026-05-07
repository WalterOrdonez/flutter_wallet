import 'package:flutter/material.dart';

class AppColors {
  // Constructor privado para evitar instanciación
  AppColors._();

  // Primary colors
  static const Color primary = Color(0xFF262524); // Negro base
  static const Color secondary = Color(0xFFF2BF27); // Amarillo
  static const Color accent = Color(0xFFF27141); // Naranja para acentos

  static const Color buttonPrincipal = Color(0xFFF2BF27);
  static const Color buttonSecondary = Color(0xFFFFFFFF);
  static const Color buttonDisabled = Color(0xFF757575);

  // Neutral colors
  static const Color background = Color(
    0xFFF5F5F5,
  ); // Fondo general gris muy claro
  static const Color surface = Color(
    0xFFFFFFFF,
  ); // Superficies blancas (tarjetas, diálogos)
  static const Color divider = Color(0xFF757575);

  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF); // Blanco para títulos
  static const Color textSecondary = Color(0xFF757575); // Gris para subtítulos
  static const Color textGeneral = Color(0xFF262524); // Gris para subtítulos

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFFFA000);
}
