import 'package:get/get.dart';
import '../../../data/repositories/movie_repository.dart';
import '../../../data/models/movie_model.dart';

class MovieController extends GetxController {
  final MovieRepository repository;

  MovieController(this.repository);

  var movies = <MovieModel>[].obs;
  var isLoading = false.obs;
  var category = "popular".obs;

  @override
  void onInit() {
    fetchMovies();
    super.onInit();
  }

  Future<void> fetchMovies() async {
    try {
      isLoading.value = true;
      final result = await repository.getMovies(category.value);
      movies.value = result;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void changeCategory(String newCategory) {
    category.value = newCategory;
    fetchMovies();
  }
}
