import 'package:flutter/material.dart';

class ProductCart extends StatelessWidget {
  final String title;
  final double price;
  final String image;
  final Color backgrondColor;
  final String time;
  final String rating;
  final String no_of_lesson;

  const ProductCart(
      {super.key,
      required this.title,
      required this.price,
      required this.image,
      required this.backgrondColor,
      required this.time,
      required this.rating,
      required this.no_of_lesson});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgrondColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          Center(
            child: Image.asset(
              image,
              height: 250,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.timer),
                Text(
                  time,
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.1, left: 15.0, right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Text(
                        "No of Lessons: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        no_of_lesson,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[100],
                  ),
                  padding: EdgeInsets.only(left: 2.0, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Text(
                        textAlign: TextAlign.right,
                        rating,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Text(
          //   "\$$price",
          //   style: TextStyle(fontSize: 20),
          // ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
