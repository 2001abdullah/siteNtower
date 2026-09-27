import 'package:flutter/material.dart';

import 'app_colors.dart';

/// The six personas a user can sign in as.
enum UserRole {
  management(
    title: 'Management',
    subtitle: 'Head Office /\nAdmin',
    icon: Icons.person_rounded,
    color: AppColors.roleManagement,
  ),
  siteOperations(
    title: 'Site Operations',
    subtitle: 'Site Manager /\nIn-charge',
    icon: Icons.person_pin_circle_rounded,
    color: AppColors.roleSiteOps,
  ),
  fieldForce(
    title: 'Field Force',
    subtitle: 'Engineer /\nTechnician',
    icon: Icons.engineering_rounded,
    color: AppColors.roleFieldForce,
  ),
  fleet(
    title: 'Fleet',
    subtitle: 'Fleet Manager /\nDriver',
    icon: Icons.local_shipping_rounded,
    color: AppColors.roleFleet,
  ),
  inventory(
    title: 'Inventory',
    subtitle: 'Inventory /\nWarehouse',
    icon: Icons.inventory_2_rounded,
    color: AppColors.roleInventory,
  ),
  external(
    title: 'External',
    subtitle: 'Vendor /\nTechnician',
    icon: Icons.storefront_rounded,
    color: AppColors.roleExternal,
  );

  const UserRole({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
}
