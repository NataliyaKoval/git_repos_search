import 'package:git_repos_search/domain/models/git_repo.dart';
import 'package:git_repos_search/domain/repository/repository.dart';
import 'package:git_repos_search/domain/use_cases/use_case.dart';

class RemoveFavoritesUsecase extends UseCase<void, GitRepo> {
  RemoveFavoritesUsecase({
    required this.repository,
  });

  final Repository repository;

  @override
  Future<void> call(GitRepo params) async {
    repository.removeFromFavorites(params);
  }
}