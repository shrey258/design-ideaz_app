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
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Image.asset(
              image,
              height: 250,
            ),
          ),
          Text(
            "\$$price",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
