import 'package:git_repos_search/domain/repository/repository.dart';
import 'package:git_repos_search/domain/use_cases/use_case.dart';

class GetFavoriteKeysUseCase extends NoParamsUseCase<List> {
  GetFavoriteKeysUseCase({
    required this.repository,
  });

  final Repository repository;

  @override
  Future<List> call() {
    return repository.getFavoriteKeys();
  }
}
