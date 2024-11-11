import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String profileImage;
  final int lessonsLearned;
  final double overallProgress;
  final List<CourseProgress> coursesProgress;
  final List<PurchasedCourse> purchasedCourses;
  final List<Achievement> achievements;

  const UserProfile({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.profileImage,
    required this.lessonsLearned,
    required this.overallProgress,
    required this.coursesProgress,
    required this.purchasedCourses,
    required this.achievements,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            _buildStatisticsSection(),
            _buildCoursesProgress(),
            _buildPurchasedCourses(),
            _buildAchievements(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.blue.shade50,
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(profileImage),
          ),
          SizedBox(height: 16),
          Text(
            userName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            userEmail,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Learning Statistics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCard(
                'Lessons\nLearned',
                '$lessonsLearned',
                Icons.book,
              ),
              _buildStatCard(
                'Overall\nProgress',
                '${(overallProgress * 100).toStringAsFixed(1)}%',
                Icons.show_chart,
              ),
              _buildStatCard(
                'Active\nCourses',
                '${coursesProgress.length}',
                Icons.school,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.blue),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoursesProgress() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Courses',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: coursesProgress.length,
            itemBuilder: (context, index) {
              return _buildCourseProgressCard(coursesProgress[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCourseProgressCard(CourseProgress course) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.courseName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: course.progress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 4),
            Text(
              '${(course.progress * 100).toStringAsFixed(1)}% Complete',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchasedCourses() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Purchased Courses',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: purchasedCourses.length,
            itemBuilder: (context, index) {
              return _buildPurchasedCourseCard(purchasedCourses[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPurchasedCourseCard(PurchasedCourse course) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(Icons.local_library),
        title: Text(course.courseName),
        subtitle: Text('Purchased on: ${course.purchaseDate}'),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to course details
        },
      ),
    );
  }

  Widget _buildAchievements() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Achievements',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: achievements.map((achievement) {
              return _buildAchievementCard(achievement);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(Achievement achievement) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Icon(
            achievement.icon,
            size: 40,
            color: achievement.unlocked ? Colors.amber : Colors.grey,
          ),
          SizedBox(height: 4),
          Text(
            achievement.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: achievement.unlocked ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class CourseProgress {
  final String courseName;
  final double progress;

  CourseProgress({
    required this.courseName,
    required this.progress,
  });
}

class PurchasedCourse {
  final String courseName;
  final String purchaseDate;

  PurchasedCourse({
    required this.courseName,
    required this.purchaseDate,
  });
}

class Achievement {
  final String name;
  final IconData icon;
  final bool unlocked;

  Achievement({
    required this.name,
    required this.icon,
    required this.unlocked,
  });
}

// to use this pass this

// UserProfile(
//         userName: "John Doe",
//         userEmail: "john@example.com",
//         profileImage: "https://example.com/profile.jpg",
//         lessonsLearned: 42,
//         overallProgress: 0.75,
//         coursesProgress: [
//           CourseProgress(
//             courseName: "Flutter Development",
//             progress: 0.8,
//           ),
//           // Add more courses...
//         ],
//         purchasedCourses: [
//           PurchasedCourse(
//             courseName: "Mobile App Development",
//             purchaseDate: "2024-03-15",
//           ),
//           // Add more purchased courses...
//         ],
//         achievements: [
//           Achievement(
//             name: "Fast Learner",
//             icon: Icons.speed,
//             unlocked: true,
//           ),
//           // Add more achievements...
//         ],
//       ),
