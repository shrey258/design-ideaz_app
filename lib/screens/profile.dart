import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  File? pickedimage;
  showImagePicker() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Pick Image From"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera_alt),
                  title: Text("Camera"),
                ),
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.photo),
                  title: Text("Gallery"),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "My Profile",
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(),
            color: Colors.red,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Color.fromRGBO(255, 255, 255, 0.78),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    showImagePicker();
                  },
                  child: pickedimage != null
                      ? CircleAvatar(
                          radius: 80,
                          backgroundImage: FileImage(pickedimage!),
                        )
                      : CircleAvatar(
                          radius: 80,
                          child: Icon(
                            Icons.person_add_alt,
                            size: 70,
                          ),
                        )),
              SizedBox(
                height: 40,
              ),
              Text(
                "Hi  Pratham !",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Details",
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(
                    Icons.edit,
                    color: Colors.grey,
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Pratham")
                ],
              ),
              Row(
                children: [
                  Icon(Icons.email),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Pratham1060@gmail.com")
                ],
              ),
              Row(
                children: [
                  Icon(Icons.call),
                  SizedBox(
                    width: 10,
                  ),
                  Text("+91-6306468667")
                ],
              ),
              Text(
                "Other details",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Area of Interests:"),
                      Text("Web Development "),
                      Text("app development")
                    ],
                  ),
                  Text("City: Noida"),
                  Text("State: Uttar Pradesh"),
                  Text("Country : India"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Settings",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Additional Setting",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  pickImage(ImageSource imagesource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imagesource);
      if (photo == null) return;
      final tempImaege = File(photo.path);
      setState(() {
        pickedimage = tempImaege;
      });
    } catch (ex) {
      Text(ex.toString());
    }
  }

  void _showLogoutDialog() {
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
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
