import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/movie_model.dart';
import '../../rental/controllers/rental_controller.dart';
import '../../../core/utils/price_calculator.dart';
import '../../../data/models/rental_model.dart';

class MovieDetailView extends StatelessWidget {
  const MovieDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = Get.arguments as MovieModel;
    final rentalController = Get.find<RentalController>();
    final daysController = TextEditingController(text: "1");

    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Hero(
              tag: "movie_${movie.id}",
              child: Image.network(
                "https://image.tmdb.org/t/p/w500${movie.backdropPath}",
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Text(movie.overview),
            const SizedBox(height: 12),
            Text("Rating: ${movie.rating}"),
            const SizedBox(height: 20),
            TextField(
              controller: daysController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: "Days to Rent"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final days = int.parse(daysController.text);
                final total =
                    PriceCalculator.calculate(days);

                final rental = RentalModel(
                  movieId: movie.id,
                  title: movie.title,
                  days: days,
                  totalPrice: total,
                  createdAt: DateTime.now(),
                );

                await rentalController.rentMovie(rental);
                rentalController.updatePreference(movie.title);
                Get.snackbar("Success", "Movie rented!");
              },
              child: const Text("Rent Movie"),
            )
          ],
        ),
      ),
    );
  }
}
