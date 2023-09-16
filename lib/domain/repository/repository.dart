import 'package:git_repos_search/domain/models/git_repo_response.dart';

abstract class Repository {
  Future<GitRepoResponse> fetchGitRepos(String query, int itemsCount);
}
