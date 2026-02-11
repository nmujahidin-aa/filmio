import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import 'package:filmio/modules/movie/controllers/movie_controller.dart';
import 'package:filmio/data/repositories/movie_repository.dart';
import 'package:filmio/data/models/movie_model.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MovieController controller;
  late MockMovieRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(<MovieModel>[]);
  });

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;

    mockRepository = MockMovieRepository();
    controller = MovieController(mockRepository);
  });

  test("fetchAll should populate popular list", () async {
    when(() => mockRepository.getMovies("popular", 1))
        .thenAnswer((_) async => [
              MovieModel(
                id: 1,
                title: "Popular Movie",
                overview: "Overview",
                posterPath: "",
                rating: 8.5,
              )
            ]);

    when(() => mockRepository.getMovies("top_rated", 1))
        .thenAnswer((_) async => []);

    when(() => mockRepository.getMovies("upcoming", 1))
        .thenAnswer((_) async => []);

    await controller.fetchAll();

    expect(controller.popular.length, 1);
    expect(controller.popular.first.title, "Popular Movie");
  });

  test("loadMore should append new movies", () async {
    when(() => mockRepository.getMovies("popular", 1))
        .thenAnswer((_) async => [
              MovieModel(
                id: 1,
                title: "Page 1 Movie",
                overview: "",
                posterPath: "",
                rating: 8.0,
              )
            ]);

    when(() => mockRepository.getMovies("popular", 2))
        .thenAnswer((_) async => [
              MovieModel(
                id: 2,
                title: "Page 2 Movie",
                overview: "",
                posterPath: "",
                rating: 7.5,
              )
            ]);

    when(() => mockRepository.getMovies("top_rated", 1))
        .thenAnswer((_) async => []);

    when(() => mockRepository.getMovies("upcoming", 1))
        .thenAnswer((_) async => []);

    await controller.fetchAll();
    await controller.loadMore();

    expect(controller.popular.length, 2);
    expect(controller.popular.last.title, "Page 2 Movie");
  });
}
