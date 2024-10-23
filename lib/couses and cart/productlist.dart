import 'package:design_ideaz_app/couses%20and%20cart/course_detail.dart';
import 'package:design_ideaz_app/couses%20and%20cart/course_list.dart';
import 'package:design_ideaz_app/couses%20and%20cart/product_cart.dart';
import 'package:flutter/material.dart';

class Productlist extends StatefulWidget {
  const Productlist({super.key});

  @override
  State<Productlist> createState() => _ProductlistState();
}

class _ProductlistState extends State<Productlist> {
  final List<String> filter = const [
    "All",
    "Web development",
    "App development",
    "HTML"
  ];
  late String selectedfilter;

  @override
  void initState() {
    super.initState();
    selectedfilter = filter[0];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const border = OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(225, 224, 225, 1)),
        borderRadius: BorderRadius.horizontal(left: Radius.circular(50)));
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Courses",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: filter.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final filters = filter[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedfilter = filters;
                      });
                    },
                    child: Chip(
                      backgroundColor: selectedfilter == filters
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(245, 247, 249, 1),
                      side: const BorderSide(
                          color: Color.fromRGBO(245, 247, 249, 1)),
                      label: Text(filters),
                      labelStyle: const TextStyle(fontSize: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
              child: size.width > 650
                  ? GridView.builder(
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 1.5),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return CourseDetail(
                                    product: product,
                                  );
                                },
                              ),
                            );
                          },
                          child: ProductCart(
                            title: product['title'] as String,
                            price: product['price'] as double,
                            image: product['imageurl'] as String,
                            time: product['time'] as String,
                            rating: product['rating'] as String,
                            no_of_lesson: product['no_of_lesson'] as String,
                            backgrondColor: index.isEven
                                ? Color.fromRGBO(216, 240, 253, 1)
                                : Color.fromRGBO(245, 247, 249, 1),
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return CourseDetail(product: product);
                            }));
                          },
                          child: ProductCart(
                            title: product['title'] as String,
                            price: product['price'] as double,
                            image: product['imageurl'] as String,
                            time: product['time'] as String,
                            rating: product['rating'] as String,
                            no_of_lesson: product['no_of_lesson'] as String,
                            backgrondColor: index.isEven
                                ? Color.fromRGBO(216, 240, 253, 1)
                                : Color.fromRGBO(245, 247, 249, 1),
                          ),
                        );
                      },
                    ))
        ],
      ),
    );
  }
}
