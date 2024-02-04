part of 'bottom_nav_bar_cubit.dart';


class BottomNavBarStale extends Equatable {
  final ButtomNavItem selectedItem;

  const BottomNavBarStale({required this.selectedItem});

@override
List<Object> get props => [selectedItem];
}