import 'package:hive/hive.dart';

import 'package:git_repos_search/data/entity/git_repo_entity.dart';

class LocalDatabase {
  final Box<GitRepoEntity> favorites = Hive.box<GitRepoEntity>('favorites');
  final Box<String> queriesBox = Hive.box<String>('queries');

  void addToFavorites(GitRepoEntity gitRepo) {
    favorites.put(gitRepo.id, gitRepo);
  }

  void removeFromFavorites(int key) {
    favorites.delete(key);
  }

  List<GitRepoEntity> getFavorites() {
    return favorites.values.toList();
  }

  void saveQuery(String query) {
    queriesBox.put(query, query);
  }

  List<String> getSavedQueries() {
    return queriesBox.values.toList();
  }

  List getFavoriteKeys() {
    return favorites.keys.toList();
  }
}
