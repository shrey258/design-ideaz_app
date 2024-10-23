import 'package:design_ideaz_app/couses%20and%20cart/cartpage.dart';
import 'package:design_ideaz_app/couses%20and%20cart/productlist.dart';
import 'package:flutter/material.dart';

class AllCoureses extends StatefulWidget {
  const AllCoureses({super.key});

  @override
  State<AllCoureses> createState() => _AllCouresesState();
}

class _AllCouresesState extends State<AllCoureses> {
  int currentPage = 0;
  List<Widget> pages = const [Productlist(), Cartpage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: pages,
        // ),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.book),
        //       label: 'Courses',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.account_circle),
        //       label: 'Profile',
        //     ),
        //   ],
        //   selectedItemColor:
        //       Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        //   unselectedItemColor:
        //       Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      ),
    );
  }
}
