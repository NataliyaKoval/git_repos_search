import 'package:git_repos_search/data/datasources/local_database.dart';
import 'package:git_repos_search/data/datasources/rest_api_client.dart';
import 'package:git_repos_search/data/entity/git_repo_entity.dart';
import 'package:git_repos_search/data/entity/git_repo_response_entity.dart';
import 'package:git_repos_search/domain/models/git_repo.dart';
import 'package:git_repos_search/domain/models/git_repo_response.dart';
import 'package:git_repos_search/domain/repository/repository.dart';
import 'package:git_repos_search/utils/app_error.dart';

class RepositoryImpl implements Repository {
  const RepositoryImpl({
    required this.restApiClient,
    required this.localDatabase,
  });

  final RestApiClient restApiClient;
  final LocalDatabase localDatabase;

  @override
  Future<GitRepoResponse> fetchGitRepos(String query, int itemsCount) async {
    GitRepoResponseEntity response =
        await execute(() => restApiClient.fetchGitRepos(
              query,
              itemsCount,
            ));
    return response;
  }

  @override
  void addToFavorites(GitRepo gitRepo) {
    localDatabase.addToFavorites(GitRepoEntity.fromGitRepo(gitRepo));
  }

  @override
  void removeFromFavorites(GitRepo gitRepo) {
    localDatabase.removeFromFavorites(gitRepo.id);
  }

  @override
  List<GitRepo> getFavorites() {
    return localDatabase.getFavorites();
  }

  @override
  Future<void> saveQuery(String query) async {
    localDatabase.saveQuery(query);
  }

  @override
  Future<List<String>> getSavedQueries() async {
    return localDatabase.getSavedQueries();
  }

  @override
  Future<List> getFavoriteKeys() async {
    return localDatabase.getFavoriteKeys();
  }
}
