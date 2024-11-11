import 'dart:io';
import '../main.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/profile_provider.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: context.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: context.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final profileImage = profileState.profileImage;
    
    Future<void> pickImage(ImageSource imageSource) async {
      try {
        final photo = await ImagePicker().pickImage(source: imageSource);
        if (photo == null) return;
        final tempImage = File(photo.path);
        ref.read(profileProvider.notifier).updateProfileImage(tempImage);
      } catch (ex) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: ${ex.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    void showImagePicker() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Pick Image From",
              style: context.textTheme.titleLarge,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.camera_alt,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    "Camera",
                    style: context.textTheme.bodyLarge,
                  ),
                ),
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.photo,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    "Gallery",
                    style: context.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(context.responsiveSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with Profile Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Profile',
                  style: context.textTheme.headlineSmall,
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => _showLogoutDialog(context, ref),
                  color: Theme.of(context).colorScheme.error,
                ),
              ],
            ),
            SizedBox(height: context.responsiveSize(24)),

            // Profile Image and Quick Stats
            Row(
              children: [
                // Profile Image Section
                Stack(
                  children: [
                    GestureDetector(
                      onTap: showImagePicker,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        child: profileImage != null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: FileImage(profileImage),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey[100],
                                child: Icon(
                                  Icons.person_add_alt,
                                  size: 40,
                                  color: Colors.grey[400],
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: context.responsiveSize(16)),
                
                // Quick Stats
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildQuickStat(context, 'Courses\nEnrolled', '4'),
                      _buildQuickStat(context, 'Courses\nCompleted', '2'),
                      _buildQuickStat(context, 'Certificates\nEarned', '2'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: context.responsiveSize(24)),

            // Personal Information Card
            Card(
              child: Padding(
                padding: EdgeInsets.all(context.responsiveSize(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Personal Information',
                          style: context.textTheme.titleLarge,
                        ),
                        Icon(Icons.edit, 
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                      ],
                    ),
                    const Divider(),
                    _buildInfoRow(context, Icons.person, profileState.name ?? ''),
                    _buildInfoRow(context, Icons.email, profileState.email ?? ''),
                    _buildInfoRow(context, Icons.call, profileState.phone ?? ''),
                    _buildInfoRow(context, Icons.school, profileState.education ?? ''),
                  ],
                ),
              ),
            ),
            SizedBox(height: context.responsiveSize(16)),

            // Learning Progress Card
            Card(
              child: Padding(
                padding: EdgeInsets.all(context.responsiveSize(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Learning Progress',
                      style: context.textTheme.titleLarge,
                    ),
                    const Divider(),
                    _buildProgressRow(context, 'Web Development Basics', 0.8),
                    _buildProgressRow(context, 'Flutter Development', 0.6),
                    _buildProgressRow(context, 'UI/UX Design', 0.4),
                  ],
                ),
              ),
            ),
            SizedBox(height: context.responsiveSize(16)),

            // Interests & Goals Card
            Card(
              child: Padding(
                padding: EdgeInsets.all(context.responsiveSize(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Interests & Goals',
                      style: context.textTheme.titleLarge,
                    ),
                    const Divider(),
                    _buildDetailRow(context, 'Learning Interests', 'Web Development, Mobile App Development, UI/UX Design'),
                    _buildDetailRow(context, 'Career Goals', 'Full Stack Developer'),
                    _buildDetailRow(context, 'Location', 'Noida, Uttar Pradesh, India'),
                  ],
                ),
              ),
            ),
            SizedBox(height: context.responsiveSize(16)),

            // Settings Card
            Card(
              child: Column(
                children: [
                  _buildSettingsTile(context, 'My Certificates', Icons.card_membership, onTap: () {}),
                  const Divider(height: 1),
                  _buildSettingsTile(context, 'Learning Reminders', Icons.alarm, onTap: () {}),
                  const Divider(height: 1),
                  _buildSettingsTile(context, 'Additional Settings', Icons.settings, onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStat(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: context.textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressRow(BuildContext context, String courseName, double progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            courseName,
            style: context.textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${(progress * 100).toInt()}% Complete',
            style: context.textTheme.bodySmall?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(BuildContext context, String title, IconData icon, {required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).primaryColor,
        size: 22,
      ),
      title: Text(
        title,
        style: context.textTheme.titleMedium,
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ref.read(authProvider.notifier).logout();
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
