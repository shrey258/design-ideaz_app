import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Profile provider
final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});

// Profile state class
class ProfileState {
  final File? profileImage;
  final String? name;
  final String? email;
  final String? phone;
  final String? education;
  
  ProfileState({
    this.profileImage,
    this.name = 'Pratham',
    this.email = 'Pratham1060@gmail.com',
    this.phone = '+91-6306468667',
    this.education = 'Computer Science Student',
  });
  
  ProfileState copyWith({
    File? profileImage,
    String? name,
    String? email,
    String? phone,
    String? education,
  }) {
    return ProfileState(
      profileImage: profileImage ?? this.profileImage,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      education: education ?? this.education,
    );
  }
}

// Profile notifier class
class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier() : super(ProfileState());
  
  void updateProfileImage(File image) {
    state = state.copyWith(profileImage: image);
  }

  void updateProfile({
    String? name,
    String? email,
    String? phone,
    String? education,
  }) {
    state = state.copyWith(
      name: name,
      email: email,
      phone: phone,
      education: education,
    );
  }

  void clearProfileImage() {
    state = state.copyWith(profileImage: null);
  }
} 