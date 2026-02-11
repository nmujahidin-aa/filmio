import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';

import 'package:filmio/modules/movie/controllers/movie_controller.dart';
import 'package:filmio/data/repositories/movie_repository.dart';
import 'package:filmio/data/models/movie_model.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MovieController controller;
  late MockMovieRepository mockRepository;

  setUp(() {
    Get.testMode = true;
    mockRepository = MockMovieRepository();
    controller = MovieController(mockRepository);
  });

  test("Fetch movies should update list", () async {
    when(mockRepository.getMovies("popular")).thenAnswer(
      (_) async => [
        MovieModel(
          id: 1,
          title: "Test Movie",
          overview: "Overview",
          posterPath: "",
          rating: 8.0,
        )
      ],
    );

    await controller.fetchMovies();

    expect(controller.movies.length, 1);
    expect(controller.movies.first.title, "Test Movie");
  });
}
