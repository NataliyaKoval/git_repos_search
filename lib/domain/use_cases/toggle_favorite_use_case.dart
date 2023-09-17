import 'package:git_repos_search/domain/models/git_repo.dart';
import 'package:git_repos_search/domain/repository/repository.dart';
import 'package:git_repos_search/domain/use_cases/use_case.dart';

class ToggleFavoritesUsecase extends UseCase<GitRepo, GitRepo> {
  ToggleFavoritesUsecase({
    required this.repository,
  });

  final Repository repository;

  @override
  Future<GitRepo> call(GitRepo params) async {
    if(!params.isFavorite) {
      //repository.addToFavorites(params);
      return params.copyWith(isFavorite: true);
    } else {
      //repository.removeFromFavorites(params);
      return params.copyWith(isFavorite: false);
    }
  }
}