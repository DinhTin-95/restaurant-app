import 'package:flutter/material.dart';

enum MenuItem {
  menu,
  history,
  table,
  checkout,
  discount,
  notification,
  infomation,
  setting,
}

extension MenuData on MenuItem {
  IconData get iconMenu {
    switch (this) {
      case MenuItem.menu:
        return Icons.restaurant_menu;
      case MenuItem.history:
        return Icons.history;
      case MenuItem.table:
        return Icons.table_chart;
      case MenuItem.checkout:
        return Icons.check_circle_outline;
      case MenuItem.discount:
        return Icons.dangerous;
      case MenuItem.notification:
        return Icons.ring_volume;
      case MenuItem.infomation:
        return Icons.blender_outlined;
      default:
        return Icons.settings;
    }
  }

  String get title {
    switch (this) {
      case MenuItem.menu:
        return 'Menus';
      case MenuItem.history:
        return 'History Payment';
      case MenuItem.table:
        return 'Tables';
      case MenuItem.checkout:
        return 'Check out';
      case MenuItem.discount:
        return 'Discount';
      case MenuItem.notification:
        return 'Notification';
      case MenuItem.infomation:
        return 'information';
      default:
        return 'Setting';
    }
  }

  Color get color {
    switch (this) {
      case MenuItem.menu:
        return Colors.red;
      case MenuItem.history:
        return Colors.green;
      case MenuItem.table:
        return Colors.blue;
      case MenuItem.checkout:
        return Colors.orange;
      case MenuItem.discount:
        return Colors.purple;
      case MenuItem.notification:
        return Colors.indigo;
      case MenuItem.infomation:
        return Colors.teal;
      default:
        return Colors.lightGreenAccent;
    }
  }
}
