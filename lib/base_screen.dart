import 'package:design_ideaz_app/providers/cart_provider.dart';
import 'package:design_ideaz_app/screens/all_courses_screen.dart';
import 'package:design_ideaz_app/screens/cart_screen.dart';
import 'package:design_ideaz_app/screens/course_overview_screen.dart';
import 'package:design_ideaz_app/screens/home_screen.dart';
import 'package:design_ideaz_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;
  Widget _currentScreen = const HomePage();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _currentScreen = _getScreenForIndex(index);
    });
  }

  Widget _getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const AllCoursesScreen();
      case 2:
        return const Profile();
      default:
        return const HomePage();
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
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              toolbarHeight: context.responsiveSize(80),
              title: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveSize(8),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.responsiveSize(12),
                        vertical: context.responsiveSize(8),
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'DI',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final cartItems = ref.watch(cartProvider);
                            return _buildActionButton(
                              icon: Icons.shopping_cart_outlined,
                              badge: cartItems.length,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartScreen(),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: context.responsiveSize(12)),
                        _buildActionButton(
                          icon: Icons.notifications_none_rounded,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      body: _currentScreen,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: NavigationBar(
            height: context.responsiveSize(70),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              _onItemTapped(index);
            },
            destinations: [
              NavigationDestination(
                icon: Icon(
                  Icons.home_outlined,
                  color: _selectedIndex == 0 
                      ? Theme.of(context).primaryColor 
                      : Colors.grey,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.explore_outlined,
                  color: _selectedIndex == 1 
                      ? Theme.of(context).primaryColor 
                      : Colors.grey,
                ),
                label: 'Explore',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.person_outline,
                  color: _selectedIndex == 2 
                      ? Theme.of(context).primaryColor 
                      : Colors.grey,
                ),
                label: 'Profile',
              ),
            ],
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            indicatorColor: Theme.of(context).primaryColor.withOpacity(0.1),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    int? badge,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.responsiveSize(4)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: EdgeInsets.all(context.responsiveSize(12)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.1),
                  Theme.of(context).primaryColor.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Stack(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                  size: context.responsiveSize(22),
                ),
                if (badge != null && badge > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(context.responsiveSize(4)),
                      decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      constraints: BoxConstraints(
                        minWidth: context.responsiveSize(18),
                        minHeight: context.responsiveSize(18),
                      ),
                      child: Text(
                        '$badge',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: context.responsiveSize(10),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
