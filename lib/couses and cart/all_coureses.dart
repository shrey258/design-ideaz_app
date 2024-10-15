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
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        currentIndex: currentPage,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: '')
        ],
      ),
    );
  }
}
