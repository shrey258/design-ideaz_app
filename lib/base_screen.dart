import 'package:design_ideaz_app/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:design_ideaz_app/screens/home_screen.dart';
import 'package:design_ideaz_app/screens/course_overview_screen.dart';
import 'package:design_ideaz_app/screens/all_courses_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_ideaz_app/screens/cart_screen.dart';
import 'package:design_ideaz_app/providers/cart_provider.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;
  Widget _currentScreen = HomePage();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _currentScreen = _getScreenForIndex(index);
    });
  }

  Widget _getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        // return CoursesScreen();
        return AllCoursesScreen(); // Replace with actual CoursesScreen when available
      case 2:
        // return ProfileScreen();
        return Profile(); // Replace with actual ProfileScreen when available
      default:
        return HomePage();
    }
  }

  void navigateToCourseOverview(Course course) {
    setState(() {
      _currentScreen = CourseOverviewScreen(course: course);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentScreen is CourseOverviewScreen
          ? null
          : AppBar(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Design Ideaz',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              actions: [
                Consumer(
                  builder: (context, ref, child) {
                    final cartItems = ref.watch(cartProvider);
                    return Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.shopping_cart_outlined),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartScreen(),
                              ),
                            );
                          },
                        ),
                        if (cartItems.isNotEmpty)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '${cartItems.length}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_active_outlined),
                  onPressed: () {},
                ),
              ],
            ),
      body: _currentScreen,
      bottomNavigationBar: _currentScreen is CourseOverviewScreen
          ? null
          : BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'Courses',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              unselectedItemColor: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor,
            ),
    );
  }
}
