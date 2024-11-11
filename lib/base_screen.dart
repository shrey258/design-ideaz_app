import 'package:design_ideaz_app/screens/profile_screen.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:design_ideaz_app/screens/home_screen.dart';
import 'package:design_ideaz_app/screens/course_overview_screen.dart';
import 'package:design_ideaz_app/screens/all_courses_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_ideaz_app/screens/cart_screen.dart';
import 'package:design_ideaz_app/providers/cart_provider.dart';
import 'dart:ui';

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
        return UserProfile(
          userName: "John Doe",
          userEmail: "john@example.com",
          profileImage: "https://example.com/profile.jpg",
          lessonsLearned: 42,
          overallProgress: 0.75,
          coursesProgress: [
            CourseProgress(
              courseName: "Flutter Development",
              progress: 0.8,
            ),
            // Add more courses...
          ],
          purchasedCourses: [
            PurchasedCourse(
              courseName: "Mobile App Development",
              purchaseDate: "2024-03-15",
            ),
            // Add more purchased courses...
          ],
          achievements: [
            Achievement(
              name: "Fast Learner",
              icon: Icons.speed,
              unlocked: true,
            ),
            // Add more achievements...
          ],
        );
      // Replace with actual ProfileScreen when available
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
              elevation: 0,
              backgroundColor: Colors.white,
              toolbarHeight: context.responsiveSize(70),
              title: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveSize(8),
                ),
                child: Row(
                  children: [
                    // Logo with CircleAvatar
                    CircleAvatar(
                      radius: context.responsiveSize(32),
                      backgroundColor: Colors.white,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'asset/images/desiznideaz logo.png',
                            height: context.responsiveSize(55),
                            width: context.responsiveSize(55),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Action Buttons
                    Row(
                      children: [
                        // Cart Button
                        Consumer(
                          builder: (context, ref, child) {
                            final cartItems = ref.watch(cartProvider);
                            return _buildActionButton(
                              icon: Icons.shopping_cart_outlined,
                              badge: cartItems.length,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CartScreen(),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(width: context.responsiveSize(8)),
                        // Notifications Button
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
      bottomNavigationBar: _currentScreen is CourseOverviewScreen
          ? null
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveSize(16),
                vertical: context.responsiveSize(8),
              ),
              child: Container(
                height: context.responsiveSize(65),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: context.responsiveSize(20),
                      offset: Offset(0, context.responsiveSize(4)),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(context.responsiveSize(24)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(context.responsiveSize(24)),
                  child: BottomNavigationBar(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    selectedFontSize: context.responsiveSize(12),
                    unselectedFontSize: context.responsiveSize(12),
                    iconSize: context.responsiveSize(24),
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
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
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
