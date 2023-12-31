import 'package:git_repos_search/domain/models/git_repo.dart';
import 'package:git_repos_search/domain/models/git_repo_response.dart';

abstract class Repository {
  Future<GitRepoResponse> fetchGitRepos(String query, int itemsCount);

  void addToFavorites(GitRepo gitRepo);

  void removeFromFavorites(GitRepo gitRepo);

  List<GitRepo> getFavorites();

  Future<void> saveQuery(String query);

  Future<List<String>> getSavedQueries();

  Future<List> getFavoriteKeys();
}
