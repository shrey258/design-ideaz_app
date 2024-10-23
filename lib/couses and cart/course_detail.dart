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
      "time": widget.product["time"],
      "no_of_lesson": widget.product["no_of_lesson"],
      "rating": widget.product["rating"],
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
          SizedBox(
            height: 30,
          ),
          Text(widget.product['title'] as String,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(25),
            child: Image.asset(
              widget.product['imageurl'] as String,
              height: 250,
            ),
          ),
          SizedBox(
            height: 10,
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
                  widget.product["time"] as String,
                  style: TextStyle(fontSize: 20),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[100],
                  ),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Text(
                        "No of Lessons:",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        widget.product["no_of_lesson"] as String,
                        style: TextStyle(fontSize: 20),
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
                        widget.product["rating"] as String,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Container(
            height: 250,
            decoration: BoxDecoration(
                color: Color.fromRGBO(219, 234, 239, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
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
                          backgroundColor: Colors.amber,
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
