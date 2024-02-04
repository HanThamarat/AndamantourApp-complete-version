
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/assets/Nav/cubit/bottom_nav_bar_cubit.dart';
import 'package:fluttertest/assets/enums.dart';

import 'widgets/widget.dart';

class NavScreen extends StatelessWidget {
  static const String routeName = "/Nav";

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (_, __, ___) => BlocProvider<BottomNavBarCubit>(
        create: (_) => BottomNavBarCubit(),
        child: NavScreen(),
      ),
    );
  }

  final Map<ButtomNavItem, GlobalKey<NavigatorState>> navigatorKeys = {
    ButtomNavItem.feed: GlobalKey<NavigatorState>(),
    ButtomNavItem.reserve: GlobalKey<NavigatorState>(),
    // ButtomNavItem.sale: GlobalKey<NavigatorState>(),
    ButtomNavItem.notifications: GlobalKey<NavigatorState>(),
    ButtomNavItem.porfile: GlobalKey<NavigatorState>(),
  };

  final Map<ButtomNavItem, IconData> items = const {
    ButtomNavItem.feed: Icons.home,
    ButtomNavItem.reserve: Icons.luggage,
    // ButtomNavItem.sale: Icons.local_offer,
    ButtomNavItem.notifications: Icons.favorite_border,
    ButtomNavItem.porfile: Icons.account_circle,
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBarCubit(),
      child: BlocBuilder<BottomNavBarCubit, BottomNavBarStale>(
        builder: (context, stale) {
          return Scaffold(
            body: Stack(
              children: items
                  .map((item, _) => MapEntry(
                        item,
                        _buildOffstageNavigator(
                            item, item == stale.selectedItem),
                      ))
                  .values
                  .toList(),
            ),
            bottomNavigationBar: BottomNavBar(
              items: items,
              selectedItem: stale.selectedItem,
              onTap: (index) {
                final selectedItem = ButtomNavItem.values[index];
                _selectedBottomNavItem(
                  context,
                  selectedItem,
                  selectedItem == stale.selectedItem,
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _selectedBottomNavItem(
      BuildContext context, ButtomNavItem selectedItem, bool isSameItem) {
    if (isSameItem) {
      navigatorKeys[selectedItem]!
          .currentState
          ?.popUntil((route) => route.isFirst);
    }
    context.read<BottomNavBarCubit>().updateSelectedItem(selectedItem);
  }

  Widget _buildOffstageNavigator(ButtomNavItem currentItem, bool isSelected) {
    return Offstage(
      offstage: !isSelected,
      child: TabNavigator(
        navigatorKey: navigatorKeys[currentItem]!,
        item: currentItem,
      ),
    );
  }
}

