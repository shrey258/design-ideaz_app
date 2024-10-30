import 'package:flutter/material.dart';

class Textinput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  

  const Textinput({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
       
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black45, fontSize: 18),
          prefixIcon: Icon(
            icon,
            color: Colors.black45,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: InputBorder.none,
          filled: true,
          fillColor: const Color(0xFFedf0f8),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(width: 2, color: Colors.blue)),
        ),
      ),
    );
  }
}
