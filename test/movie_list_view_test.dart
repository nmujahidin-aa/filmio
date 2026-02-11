import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

import 'package:filmio/modules/movie/views/movie_list_view.dart';
import 'package:filmio/modules/movie/controllers/movie_controller.dart';
import 'package:filmio/data/repositories/movie_repository.dart';
import 'package:filmio/data/models/movie_model.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MovieController controller;
  late MockMovieRepository mockRepository;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;

    mockRepository = MockMovieRepository();

    controller = MovieController(mockRepository);

    when(() => mockRepository.getMovies(any(), any()))
        .thenAnswer((_) async => []);

    Get.put<MovieController>(controller);
  });

  testWidgets("Movie list view loads", (tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: MovieListView(),
      ),
    );

    await tester.pump();

    expect(find.byType(MovieListView), findsOneWidget);
  });
}
