import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_cart_getx/controllers/cart_controller.dart';
import 'package:shopping_cart_getx/controllers/shopping_controller.dart';

class ShoppingPage extends StatelessWidget {
  ShoppingPage({super.key});

  final shoppingController = Get.put(ShoppingController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Expanded(
                child: GetX<ShoppingController>(
                  builder: (controller) {
                    return ListView.builder(
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${controller.products[index].productName}',
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                        Text(
                                            '${controller.products[index].productDescription}'),
                         
                         
                                      ],
                                    ),
                                    Text(
                                        '\$${controller.products[index].price}',
                                        style: const TextStyle(fontSize: 24)),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    cartController
                                        .addToCart(controller.products[index]);
                                  },
                                  child: const Text('Add to Cart'),
                                ),
                                Obx(() => IconButton(
                                      icon: controller
                                              .products[index].isFavorite.value
                                          ? const Icon(Icons.favorite)
                                          : const Icon(Icons.favorite_border),
                                      onPressed: () {
                                        controller.products[index].isFavorite
                                            .toggle();
                                      },
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
              Obx(
                () => Text(
                  'Total amount :${cartController.totalPrice}',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add_shopping_cart_rounded),
        label: Obx(
          () => Text('${cartController.count}',
              style: const TextStyle(fontSize: 22)),
        ),
      ),
    );
  }
}
