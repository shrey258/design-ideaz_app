import 'package:flutter/material.dart';
import 'package:design_ideaz_app/widgets/course_card_widget.dart';
import '../widgets/search_widget.dart';
import 'course_overview_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample course data
    final List<Course> courses = [
      Course(
        title: 'Web design fundamentals',
        duration: '8h 30min',
        lessonCount: 32,
        rating: 4.8,
        imageUrl: 'https://placehold.co/600x400/90EE90/ffffff/png?text=Web+Design+Course',
        lessons: [
          Lesson(title: 'Introduction to Web Design', duration: '45min'),
          Lesson(title: 'HTML Basics', duration: '1h 30min'),
          // Add more lessons as needed
        ],
        price: 49.99,
      ),
      Course(
        title: 'Figma Master Class',
        duration: '6h30m',
        lessonCount: 28,
        rating: 4.9,
        imageUrl: 'https://placehold.co/600x400/87CEEB/ffffff/png?text=UI+Design+Course',
        lessons: [
          Lesson(title: 'Figma Interface Overview', duration: '1h'),
          Lesson(title: 'Creating Your First Design', duration: '2h'),
          // Add more lessons as needed
        ],
        price: 59.99,
      ),
      // Add more courses as needed
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchWidget(
              onSearch: (query) {
                // Add search functionality here
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Discover Top Picks',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Spacer(),
                Text(
                  '+100 lessons',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Color(0xFF3D8FEF)),
                ),
              ],
            ),
            SizedBox(height: 16),
            CourseCard(course: courses[0]),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: Text('Explore more'),
            ),
            SizedBox(height: 16),
            Text(
              'Popular lessons',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            CourseCard(course: courses[1]),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              child: Text('See All'),
            ),
          ],
        ),
      ),
    );
  }
}