import 'package:git_repos_search/data/entity/git_repo_entity.dart';
import 'package:git_repos_search/domain/models/git_repo_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'git_repo_response_entity.g.dart';

@JsonSerializable()
class GitRepoResponseEntity implements GitRepoResponse {
  GitRepoResponseEntity({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  factory GitRepoResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GitRepoResponseEntityFromJson(json);

  @override
  @JsonKey(name: 'total_count')
  final int totalCount;

  @override
  @JsonKey(name: 'incomplete_results')
  final bool incompleteResults;

  @override
  @JsonKey(name: 'items')
  final List<GitRepoEntity> items;
}
