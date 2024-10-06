import 'package:flutter/material.dart';

class FigmaMasterClassScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Overview'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Image.asset('assets/figma_master_class_image.png'),

            // Course Details
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Figma master class for beginners',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Icon(Icons.timer),
                      Text('6h 39min'),
                      SizedBox(width: 16),
                      Icon(Icons.star),
                      Text('4.9'),
                    ],
                  ),
                ],
              ),
            ),

            // Lessons List
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: lessons.length,
            //   itemBuilder: (context, index) {
            //     final lesson = lessons[index];
            //     return ListTile(
            //       leading: Icon(Icons.play_arrow),
            //       title: Text(lesson.title),
            //       subtitle: Text(lesson.duration),
            //       trailing: Icon(Icons.arrow_forward),
            //     );
            //   },
            // ),

            // Enroll Button
            ElevatedButton(
              onPressed: () {
                // Handle enrollment logic
              },
              child: Text('Enroll Now'),
            ),
          ],
        ),
      ),
    );
  }
}
