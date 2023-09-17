import 'package:hive/hive.dart';

import 'package:git_repos_search/data/entity/git_repo_entity.dart';

class LocalDatabase {
  final Box<GitRepoEntity> favorites = Hive.box<GitRepoEntity>('favorites');

  void addToFavorites(GitRepoEntity gitRepo) {
    favorites.put(gitRepo.id, gitRepo);
  }

  void removeFromFavorites(int key) {
    favorites.delete(key);
  }
}
