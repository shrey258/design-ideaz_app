import 'package:flutter/material.dart';

import 'package:design_ideaz_app/screens/course_overview_screen.dart';
import 'package:design_ideaz_app/main.dart'; // Import for responsive extensions

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseOverviewScreen(course: course),
          ),
        );
      },
      child: SizedBox(
        width: context.responsiveSize(200), // Set a specific width
        height: context.responsiveSize(260), // Set a specific height
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(context.responsiveSize(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(context.responsiveSize(15)),
                    ),
                    child: Image.network(
                      course.imageUrl,
                      height: context.responsiveSize(120),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: context.responsiveSize(10),
                    right: context.responsiveSize(10),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: context.responsiveSize(24),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(context.responsiveSize(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: context.responsiveSize(4)),
                    Text(
                      '${course.lessonCount} lessons',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: context.responsiveSize(8)),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: context.responsiveSize(16),
                          color: Colors.blue[300],
                        ),
                        SizedBox(width: context.responsiveSize(4)),
                        Text(
                          course.duration,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Spacer(),
                        Icon(
                          Icons.star,
                          size: context.responsiveSize(16),
                          color: Colors.amber,
                        ),
                        SizedBox(width: context.responsiveSize(4)),
                        Text(
                          course.rating.toString(),
                          style: Theme.of(context).textTheme.titleLarge,
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
