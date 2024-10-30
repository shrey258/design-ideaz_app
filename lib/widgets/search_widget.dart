import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final Function(String) onSearch;

  const SearchWidget({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search now...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onSubmitted: onSearch,
            ),
          ),
          IconButton(
            icon:
                const Icon(Icons.settings_input_component, color: Colors.blue),
            onPressed: () {
              // Add functionality for the blue button here
            },
          ),
        ],
      ),
    );
  }
}
