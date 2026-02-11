import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:filmio/modules/movie/views/movie_list_view.dart';
import 'package:filmio/modules/movie/controllers/movie_controller.dart';
import 'package:filmio/data/repositories/movie_repository.dart';
import 'package:filmio/core/services/api_service.dart';

void main() {
  testWidgets("Movie list view loads", (tester) async {
    Get.put(MovieController(
      MovieRepository(ApiService()),
    ));

    await tester.pumpWidget(
      const GetMaterialApp(
        home: MovieListView(),
      ),
    );

    expect(find.text("Movies"), findsOneWidget);
  });
}
