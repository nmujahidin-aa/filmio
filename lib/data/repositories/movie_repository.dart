import '../../core/services/api_service.dart';
import '../models/movie_model.dart';

class MovieRepository {
  final ApiService apiService;

  MovieRepository(this.apiService);

  Future<List<MovieModel>> getMovies(String category, int page) async {
    final data = await apiService.fetchMovies(category, page);
    return data
        .map<MovieModel>((e) => MovieModel.fromJson(e))
        .toList();
  }

}
