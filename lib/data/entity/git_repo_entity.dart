import 'package:git_repos_search/domain/models/git_repo.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'git_repo_entity.g.dart';

@HiveType(typeId: 1)
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

  factory GitRepoEntity.fromGitRepo(GitRepo gitRepo) => GitRepoEntity(
        id: gitRepo.id,
        nodeId: gitRepo.nodeId,
        name: gitRepo.name,
        fullName: gitRepo.fullName,
        private: gitRepo.private,
      );

  @HiveField(0)
  @override
  @JsonKey(name: 'id')
  final int id;

  @HiveField(1)
  @override
  @JsonKey(name: 'node_id')
  final String nodeId;

  @HiveField(2)
  @override
  @JsonKey(name: 'name')
  final String name;

  @HiveField(3)
  @override
  @JsonKey(name: 'full_name')
  final String fullName;

  @HiveField(4)
  @override
  @JsonKey(name: 'private')
  final bool private;

  @HiveField(5)
  @override
  @JsonKey(name: 'homepage')
  final String? homepage;

  @override
  @JsonKey(includeFromJson: false)
  final bool isFavorite;

  @override
  GitRepoEntity copyWith({
    int? id,
    String? nodeId,
    String? name,
    String? fullName,
    bool? private,
    String? homepage,
    bool? isFavorite,
  }) {
    return GitRepoEntity(
      id: id ?? this.id,
      nodeId: nodeId ?? this.nodeId,
      name: name ?? this.name,
      fullName: fullName ?? this.fullName,
      private: private ?? this.private,
      homepage: homepage ?? this.homepage,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
