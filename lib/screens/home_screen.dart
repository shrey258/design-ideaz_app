import 'package:flutter/material.dart';
import 'package:design_ideaz_app/widgets/course_card_widget.dart';
import '../widgets/search_widget.dart';
import 'package:design_ideaz_app/main.dart'; // Import for responsive extensions
import 'package:design_ideaz_app/course_data.dart'; // Import course data

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(context.responsiveSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchWidget(
              onSearch: (query) {
                // Add search functionality here
              },
            ),
            SizedBox(height: context.responsiveSize(24)),
            Row(
              children: [
                Text(
                  'Discover Top Picks',
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '+100 lessons',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.responsiveSize(16)),
            SizedBox(
              height: context.responsiveSize(280),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: context.responsiveSize(16)),
                    child: CourseCard(course: courses[index]),
                  );
                },
              ),
            ),
            SizedBox(height: context.responsiveSize(24)),
            Text(
              'Popular Courses',
              style: context.textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.responsiveSize(16)),
            SizedBox(
              height: context.responsiveSize(280),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: context.responsiveSize(16)),
                    child: CourseCard(course: courses[index]),
                  );
                },
              ),
            ),
            SizedBox(height: context.responsiveSize(16)),
            ElevatedButton(
              onPressed: () {},
              child: Text('Explore more'),
            ),
          ],
        ),
      ),
    );
  }
}
