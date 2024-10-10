import 'package:design_ideaz_app/main.dart';
import 'package:design_ideaz_app/widgets/course_card_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(context.responsiveSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: context.responsiveSize(16.0), // Spacing between widgets
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.responsiveSize(16.0)),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search now...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.filter_list),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.responsiveSize(16.0)),
              child: Row(
                children: [
                  Text(
                    'Discover Top Picks',
                    style: context.textLarge?.copyWith(
                      fontSize: context.responsiveSize(18.0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '+100 lessons',
                    style: context.textTheme.bodyMedium?.copyWith(color: Color(0xFF3D8FEF)),
                  ),
                ],
              ),
            ),
            CourseCard(
              title: 'Web design fundamentals',
              subtitle: 'UX Design (32 lessons)',
              duration: '8h 30min',
              rating: 4.8,
              imageUrl: 'https://placehold.co/600x400/90EE90/ffffff/png?text=Web+Design+Course',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.responsiveSize(16.0)),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Explore more',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.responsiveSize(16.0)),
              child: Text(
                'Popular lessons',
                style: context.textLarge?.copyWith(
                  fontSize: context.responsiveSize(18.0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CourseCard(
              title: "Figma Master Class",
              subtitle: "28 Lessons",
              duration: "6h30m",
              rating: 4.9,
              imageUrl: 'https://placehold.co/600x400/87CEEB/ffffff/png?text=UI+Design+Course',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.responsiveSize(16.0)),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
