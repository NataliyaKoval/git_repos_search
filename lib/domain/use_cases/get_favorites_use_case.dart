import 'package:git_repos_search/domain/models/git_repo.dart';
import 'package:git_repos_search/domain/repository/repository.dart';
import 'package:git_repos_search/domain/use_cases/use_case.dart';

class GetFavoritesUseCase extends NoParamsUseCase<List<GitRepo>> {
  GetFavoritesUseCase({
    required this.repository,
  });

  final Repository repository;

  @override
  Future<List<GitRepo>> call() async {
    return repository.getFavorites();
  }
}
