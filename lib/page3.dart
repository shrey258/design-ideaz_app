import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search now...',
                prefixIcon: Icon(Icons.search),
              ),
            ),

            // Chip with selected search term
            Chip(
              label: Text('ui design'),
              onDeleted: () {
                // Handle chip deletion
              },
            ),

            // List of search results
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: searchResults.length,
            //     itemBuilder: (context, index) {
            //       final result = searchResults[index];
            //       return ListTile(
            //         leading: Image.network(result.imageUrl),
            //         title: Text(result.title),
            //         subtitle: Text('${result.level} • ${result.duration}'),
            //         trailing: Row(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Icon(Icons.star, color: Colors.yellow),
            //             Text(result.rating.toString()),
            //             SizedBox(width: 8),
            //             IconButton(
            //               icon: Icon(Icons.favorite_border),
            //               onPressed: () {
            //                 // Handle favorite action
            //               },
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   // ... your bottom navigation bar items
      // ),
    );
  }
}
