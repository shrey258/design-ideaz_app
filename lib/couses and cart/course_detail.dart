import 'package:design_ideaz_app/couses%20and%20cart/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseDetail extends StatefulWidget {
  final Map<String, Object> product;

  const CourseDetail({super.key, required this.product});

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  void onTap() {
    Provider.of<CartProvider>(context, listen: false).addProduct({
      'id': widget.product['id'],
      "title": widget.product["title"],
      "price": widget.product["price"],
      "imageurl": widget.product["imageurl"],
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Course Added Successfully"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: Column(
        children: [
          Text(widget.product['title'] as String,
              style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(25),
            child: Image.asset(
              widget.product['imageurl'] as String,
              height: 150,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Container(
            height: 250,
            decoration: BoxDecoration(
                color: Color.fromRGBO(245, 247, 249, 1),
                borderRadius: BorderRadius.circular(40)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('\$${widget.product['price']}',
                    style: Theme.of(context).textTheme.titleLarge),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          fixedSize: Size(350, 50)),
                      child: Text(
                        "Add To Cart",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
