import 'package:flutter/material.dart';
 import 'package:fluttertest/assets/enums.dart';

class BottomNavBar extends StatelessWidget {
  final Map<ButtomNavItem, IconData> items;
  final ButtomNavItem selectedItem;
  final Function(int) onTap;

  const BottomNavBar({super.key, 
  required this.items, 
  required this.selectedItem,
  required this.onTap});

 

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey.withOpacity(0.5),
      currentIndex: ButtomNavItem.values.indexOf(selectedItem),
      onTap: onTap,
      items: items.map((item, icon) => 
      MapEntry(item.toString(), 
      BottomNavigationBarItem(
        label: '',
        icon: Icon(icon, size: 30.0),
          ),
        ),
      ).values.toList(),
    );
  }
}

// ignore: unused_element
_bottomBarItem(IconData icon, String label) {
  return BottomNavigationBarItem(icon: Icon(icon), label: label);
}
