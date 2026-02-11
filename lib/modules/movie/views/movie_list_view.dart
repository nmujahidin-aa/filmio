import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/movie_controller.dart';
import '../../../core/routes/app_pages.dart';
import '../../../modules/auth/controllers/auth_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MovieController>();
    final authController = Get.find<AuthController>();
    final imageBaseUrl = dotenv.env['IMAGE_BASE_URL'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppPages.rentals),
            icon: const Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: authController.logout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: controller.category.value,
            items: const [
              DropdownMenuItem(value: "popular", child: Text("Popular")),
              DropdownMenuItem(value: "top_rated", child: Text("Top Rated")),
              DropdownMenuItem(value: "upcoming", child: Text("Upcoming")),
            ],
            onChanged: (value) {
              if (value != null) controller.changeCategory(value);
            },
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                itemCount: controller.movies.length,
                itemBuilder: (context, index) {
                  final movie = controller.movies[index];
                  return ListTile(
                    leading: Image.network(
                      "$imageBaseUrl${movie.posterPath}",
                      width: 50,
                    ),
                    title: Text(movie.title),
                    subtitle: Text("Rating: ${movie.rating}"),
                    onTap: () {
                      Get.toNamed(AppPages.movieDetail,
                          arguments: movie);
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
