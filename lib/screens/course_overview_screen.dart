import 'package:flutter/material.dart';

import 'package:design_ideaz_app/main.dart';

class Course {
  final String title;
  final String duration;
  final int lessonCount;
  final double rating;
  final String imageUrl;
  final List<Lesson> lessons;
  final double price;

  Course({
    required this.title,
    required this.duration,
    required this.lessonCount,
    required this.rating,
    required this.imageUrl,
    required this.lessons,
    required this.price,
  });
}

class Lesson {
  final String title;
  final String duration;

  Lesson({required this.title, required this.duration});
}

class CourseOverviewScreen extends StatelessWidget {
  final Course course;

  const CourseOverviewScreen({Key? key, required this.course})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).appBarTheme.iconTheme?.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Course Overview',
            style: Theme.of(context).textTheme.displayMedium),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border,
                color: Theme.of(context).appBarTheme.iconTheme?.color),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(context.responsiveSize(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCourseImage(context),
              Padding(
                padding: EdgeInsets.all(context.responsiveSize(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(course.title,
                        style: Theme.of(context).textTheme.displaySmall),
                    SizedBox(height: context.responsiveSize(8)),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                            '${course.duration} • ${course.lessonCount} lessons',
                            style: context.textSmall),
                        Spacer(),
                        Icon(Icons.star, size: 16, color: Colors.amber),
                        SizedBox(width: 4),
                        Text(course.rating.toString(),
                            style: context.textSmall),
                      ],
                    ),
                    SizedBox(height: context.responsiveSize(16)),
                    _buildTabButtons(context),
                    SizedBox(height: context.responsiveSize(16)),
                    _buildLessonsList(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildEnrollButton(context),
    );
  }

  Widget _buildCourseImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
      child: Container(
        height: context.screenHeight * 0.25,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(course.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.5),
              ],
            ),
          ),
          child: Center(
            child:
                Icon(Icons.play_circle_filled, size: 64, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildTabButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Lessons'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        SizedBox(width: context.responsiveSize(16)),
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            child: Text('Description'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLessonsList(BuildContext context) {
    return Column(
      children: course.lessons
          .map((lesson) => _buildLessonItem(context, lesson))
          .toList(),
    );
  }

  Widget _buildLessonItem(BuildContext context, Lesson lesson) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.responsiveSize(8)),
      child: Row(
        children: [
          Icon(Icons.play_circle_outline,
              color: Theme.of(context).primaryColor),
          SizedBox(width: context.responsiveSize(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lesson.title, style: context.textSmall),
                Text(lesson.duration, style: context.textTheme.bodyMedium),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildEnrollButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.responsiveSize(16)),
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Enroll Now - \$${course.price.toStringAsFixed(2)}'),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, context.responsiveSize(50)),
        ),
      ),
    );
  }
}
