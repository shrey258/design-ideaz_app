import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_ideaz_app/screens/course_overview_screen.dart';

class CartNotifier extends StateNotifier<List<Course>> {
  CartNotifier() : super([]);

  void addToCart(Course course) {
    if (!state.contains(course)) {
      state = [...state, course];
    }
  }

  void removeFromCart(Course course) {
    state = state.where((item) => item != course).toList();
  }

  double get total => state.fold(0, (sum, course) => sum + course.price);
}

final cartProvider = StateNotifierProvider<CartNotifier, List<Course>>((ref) {
  return CartNotifier();
});