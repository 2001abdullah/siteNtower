import 'package:flutter/material.dart';

/// Brand and semantic colours taken from the App_UI mockups.
abstract final class AppColors {
  // Ops palette (blue / navy)
  static const primary = Color(0xFF1545E8);
  static const primaryLight = Color(0xFFEAF0FF);
  static const navy = Color(0xFF0B1A5C);
  static const accentBlue = Color(0xFF2F6BFF);

  // Supply palette (green) — Inventory & External
  static const supplyPrimary = Color(0xFF1B6B35);

  // Neutrals
  static const background = Color(0xFFFFFFFF);
  static const surface = Color(0xFFF7F8FC);
  static const border = Color(0xFFE6E9F2);
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);

  // Semantic
  static const success = Color(0xFF16A34A);
  static const warning = Color(0xFFF59E0B);
  static const danger = Color(0xFFE11D48);
  static const info = Color(0xFF2563EB);

  // Role accents (role selection / splash badges)
  static const roleManagement = Color(0xFF1F4FE0);
  static const roleSiteOps = Color(0xFF22A06B);
  static const roleFieldForce = Color(0xFF6D4AE8);
  static const roleFleet = Color(0xFFF7811E);
  static const roleInventory = Color(0xFF1AA6B7);
  static const roleExternal = Color(0xFFE8456B);
}
