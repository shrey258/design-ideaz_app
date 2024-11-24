import 'package:flutter/material.dart';

import 'package:design_ideaz_app/screens/course_overview_screen.dart';
import 'package:design_ideaz_app/main.dart'; // Import for responsive extensions

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CourseOverviewScreen(course: course),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Image
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    course.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(context.responsiveSize(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course Title
                    SizedBox(
                      height: context.responsiveSize(44),
                      child: Text(
                        course.title,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: context.responsiveSize(16),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: context.responsiveSize(8)),
                    // Course Stats
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: context.responsiveSize(14),
                          color: Colors.grey,
                        ),
                        SizedBox(width: context.responsiveSize(4)),
                        Expanded(
                          child: Text(
                            course.duration,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                              fontSize: context.responsiveSize(12),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '${course.lessonCount} less',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                            fontSize: context.responsiveSize(12),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(height: context.responsiveSize(8)),
                    // Rating and Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: context.responsiveSize(16),
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(width: context.responsiveSize(4)),
                            Text(
                              course.rating.toString(),
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: context.responsiveSize(14),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '\$${course.price.toStringAsFixed(2)}',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: context.responsiveSize(16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
