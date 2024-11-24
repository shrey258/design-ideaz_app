import 'package:flutter/material.dart';
import '../main.dart';

class SearchWidget extends StatelessWidget {
  final Function(String) onSearch;

  const SearchWidget({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.responsiveSize(50),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        onChanged: onSearch,
        style: context.textTheme.bodyLarge,
        decoration: InputDecoration(
          hintText: 'Search courses...',
          hintStyle: context.textTheme.bodyLarge?.copyWith(color: Colors.grey),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
            size: context.responsiveSize(24),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.responsiveSize(16),
            vertical: context.responsiveSize(12),
          ),
        ),
      ),
    );
  }
}
