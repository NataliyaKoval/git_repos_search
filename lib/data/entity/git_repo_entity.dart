import 'package:git_repos_search/domain/models/git_repo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'git_repo_entity.g.dart';

@JsonSerializable()
class GitRepoEntity implements GitRepo {
  const GitRepoEntity({
    required this.id,
    required this.nodeId,
    required this.name,
    required this.fullName,
    required this.private,
    this.homepage,
    this.isFavorite = false,
  });

  factory GitRepoEntity.fromJson(Map<String, dynamic> json) =>
      _$GitRepoEntityFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;

  @override
  @JsonKey(name: 'node_id')
  final String nodeId;

  @override
  @JsonKey(name: 'name')
  final String name;

  @override
  @JsonKey(name: 'full_name')
  final String fullName;

  @override
  @JsonKey(name: 'private')
  final bool private;

  @override
  @JsonKey(name: 'homepage')
  final String? homepage;

  @override
  @JsonKey(includeFromJson: false)
  final bool isFavorite;
}
