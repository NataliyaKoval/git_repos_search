import 'package:git_repos_search/domain/models/git_repo.dart';

class GitRepoResponse {
  const GitRepoResponse({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  final int totalCount;
  final bool incompleteResults;
  final List<GitRepo> items;
}
