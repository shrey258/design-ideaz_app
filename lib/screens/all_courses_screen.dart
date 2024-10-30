import 'package:flutter/material.dart';
import 'package:design_ideaz_app/widgets/course_card_widget.dart';
import 'package:design_ideaz_app/widgets/search_widget.dart';
import 'package:design_ideaz_app/main.dart'; // Import for responsive extensions
import 'package:design_ideaz_app/course_data.dart'; // Import course data

class AllCoursesScreen extends StatelessWidget {
  const AllCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.responsiveSize(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchWidget(
                onSearch: (query) {
                  // Implement search functionality
                },
              ),
              SizedBox(height: context.responsiveSize(16)),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8, // Adjusted for better height
                    crossAxisSpacing: context.responsiveSize(10),
                    mainAxisSpacing: context.responsiveSize(10),
                  ),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return CourseCard(course: courses[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
