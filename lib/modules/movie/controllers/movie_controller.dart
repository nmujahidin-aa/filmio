import 'package:filmio/modules/rental/controllers/rental_controller.dart';
import 'package:get/get.dart';
import '../../../data/repositories/movie_repository.dart';
import '../../../data/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieController extends GetxController {
  final MovieRepository repository;

  MovieController(this.repository);

  var popular = <MovieModel>[].obs;
  var topRated = <MovieModel>[].obs;
  var upcoming = <MovieModel>[].obs;
  var selectedGenre = "".obs;

  var isLoading = false.obs;

  var currentPage = 1;
  var hasMore = true.obs;
  final scrollController = ScrollController();

  @override
  void onInit() {
    fetchAll();
    super.onInit();
    scrollController.addListener(() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadMore();
    }
  });
  }

  Future<void> fetchAll() async {
    try {
      isLoading.value = true;

      popular.value =
          await repository.getMovies("popular", currentPage);

      topRated.value =
          await repository.getMovies("top_rated", currentPage);

      upcoming.value =
          await repository.getMovies("upcoming", currentPage);

    } finally {
      isLoading.value = false;
    }
  }

  List<MovieModel> filterByGenre(
      List<MovieModel> movies) {
    if (selectedGenre.value.isEmpty) return movies;

    return movies
        .where((movie) =>
            movie.title
                .toLowerCase()
                .contains(selectedGenre.value))
        .toList();
  }

  Future<void> loadMore() async {
    if (!hasMore.value) return;

    currentPage++;

    final result =
        await repository.getMovies("popular", currentPage);

    if (result.isEmpty) {
      hasMore.value = false;
    } else {
      popular.addAll(result);
    }
  }

  List<MovieModel> recommend(
    List<MovieModel> movies) {

    final keyword =
        Get.find<RentalController>()
            .preferredKeyword
            .value;

    if (keyword.isEmpty) return movies.take(5).toList();

    return movies
        .where((m) =>
            m.title.toLowerCase().contains(keyword))
        .take(5)
        .toList();
  }

}

