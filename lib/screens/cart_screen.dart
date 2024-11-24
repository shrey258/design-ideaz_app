import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';
import '../main.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: context.textTheme.displayMedium,
        ),
        centerTitle: false,
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: const Color(0xFF3D8FEF).withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: const Color(0xFF37474F),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final course = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  course.imageUrl,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      course.title,
                                      style: context.textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '\$${course.price.toStringAsFixed(2)}',
                                      style: context.textTheme.titleLarge?.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  ref.read(cartProvider.notifier).removeFromCart(course);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Total Amount',
                              style: context.textTheme.titleLarge?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${cartNotifier.total.toStringAsFixed(2)}',
                              style: context.textTheme.headlineSmall?.copyWith(
                                color: const Color(0xFF3D8FEF),
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // TODO: Implement checkout process
                            },
                            child: const Text('Proceed to Checkout'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
} 