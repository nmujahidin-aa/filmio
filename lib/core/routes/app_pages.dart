import 'package:get/get.dart';

import '../../modules/auth/views/login_view.dart';
import '../../modules/auth/views/register_view.dart';
import '../../modules/movie/views/movie_list_view.dart';
import '../../modules/movie/views/movie_detail_view.dart';
import '../../modules/rental/views/rental_list_view.dart';

class AppPages {
  static const login = '/login';
  static const register = '/register';
  static const movies = '/movies';
  static const movieDetail = '/movie-detail';
  static const rentals = '/rentals';

  static final pages = [
    GetPage(name: login, page: () => const LoginView()),
    GetPage(name: register, page: () => const RegisterView()),
    GetPage(name: movies, page: () => const MovieListView()),
    GetPage(name: movieDetail, page: () => const MovieDetailView()),
    GetPage(name: rentals, page: () => const RentalListView()),
  ];
}
