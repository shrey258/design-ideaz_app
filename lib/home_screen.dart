import 'package:design_ideaz_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.responsiveSize(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: context.responsiveSize(16.0)),
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
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.responsiveSize(16.0)),
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
            SizedBox(height: context.responsiveSize(16.0)),
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
            SizedBox(height: context.responsiveSize(8.0)),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                mainAxisSpacing: context.responsiveSize(16.0),
                crossAxisSpacing: context.responsiveSize(16.0),
              ),
              itemCount: 2, // Replace with actual number of lessons
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        '../assets/images/course_image.png', // Replace with actual image asset
                        height: context.responsiveSize(150),
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.all(context.responsiveSize(8.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Figma master class',
                              style: context.textMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'UI Design (28 lessons)',
                              style: context.textTheme.bodyMedium,
                            ),
                            SizedBox(height: context.responsiveSize(4.0)),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: context.responsiveSize(16.0),
                                ),
                                SizedBox(width: context.responsiveSize(4.0)),
                                Text(
                                  '6h 30min',
                                  style: context.textTheme.bodyMedium,
                                ),
                                const Spacer(),
                                RatingBar.builder(
                                  initialRating: 4.9,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemSize: context.responsiveSize(18.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    // Handle rating update if needed
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: context.responsiveSize(16.0)),
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
