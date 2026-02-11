import 'package:filmio/core/routes/app_pages.dart';
import 'package:filmio/data/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/movie_controller.dart';
import 'package:shimmer/shimmer.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MovieController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Filmio",
            style: TextStyle(color: Colors.red)),   
        actions: [
        IconButton(
          onPressed: () => Get.toNamed(AppPages.rentals),
          icon: const Icon(Icons.history, color: Colors.white),
        ),
      ], 
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return shimmerSection();
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              _section("Recommended", controller.recommend(controller.popular), controller,),
              _section("Popular", controller.popular, controller),
              _section("Top Rated",
                  controller.topRated, controller),
              _section("Upcoming",
                  controller.upcoming, controller),
            ],
          ),
        );
      }),
    );
  }

  Widget _section(
      String title, List<MovieModel> movies, dynamic controller) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18)),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            controller: controller.scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (_, index) {
              final movie = movies[index];
              return GestureDetector(
              onTap: () {
                Get.toNamed(
                  AppPages.movieDetail,
                  arguments: movie,
                );
              },
              child: Hero(
                tag: "movie_${movie.id}",
                child: Container(
                  width: 120,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
            },
          ),
        )
      ],
    );
  }

  Widget shimmerSection() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (_, __) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[700]!,
            child: Container(
              width: 120,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }

}
