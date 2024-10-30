import 'package:design_ideaz_app/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class Ncoursespage extends StatefulWidget {
  const Ncoursespage({super.key});

  @override
  State<Ncoursespage> createState() => _NcoursespageState();
}

class _NcoursespageState extends State<Ncoursespage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SearchWidget(
                onSearch: (query) {
                  // Add search functionality here
                },
              ),
              SizedBox(height: 20)
            ])));
  }
}
