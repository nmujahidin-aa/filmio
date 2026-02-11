import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/rental_controller.dart';

class RentalListView extends StatelessWidget {
  const RentalListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RentalController>();

    return Scaffold(
      appBar: AppBar(title: const Text("My Rentals")),
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.rentals.length,
                itemBuilder: (context, index) {
                  final rental = controller.rentals[index];
                  return ListTile(
                    title: Text(rental.title),
                    subtitle: Text(
                        "${rental.days} days - Rp ${rental.totalPrice}"),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Total: Rp ${controller.totalCost.value}",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      }),
    );
  }
}
