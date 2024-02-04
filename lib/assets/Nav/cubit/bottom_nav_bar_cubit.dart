import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/assets/buttom_nav_item.dart';
import 'package:equatable/equatable.dart';


part 'bottom_nav_bar_stale.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarStale> {
  BottomNavBarCubit() 
      : super(BottomNavBarStale(selectedItem : ButtomNavItem.feed));
  
  void updateSelectedItem(ButtomNavItem item) {
    if(item != state.selectedItem) {
      emit(BottomNavBarStale(selectedItem: item));
    }
  }
}