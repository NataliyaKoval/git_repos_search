import 'package:git_repos_search/domain/models/git_repo_response.dart';
import 'package:git_repos_search/domain/repository/repository.dart';
import 'package:git_repos_search/domain/use_cases/use_case.dart';

class FetchGitReposUseCase extends UseCase<GitRepoResponse, GitRepoParams> {
  FetchGitReposUseCase({
    required this.repository,
  });

  final Repository repository;

  @override
  Future<GitRepoResponse> call(GitRepoParams params) async {
    return await repository.fetchGitRepos(
      params.query,
      params.itemsCount,
    );
  }
}

class GitRepoParams {
  const GitRepoParams({
    required this.query,
    required this.itemsCount,
  });

  final String query;
  final int itemsCount;
}
