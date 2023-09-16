// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_repo_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitRepoEntity _$GitRepoEntityFromJson(Map<String, dynamic> json) =>
    GitRepoEntity(
      id: json['id'] as int,
      nodeId: json['node_id'] as String,
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      private: json['private'] as bool,
      homepage: json['homepage'] as String?,
    );

Map<String, dynamic> _$GitRepoEntityToJson(GitRepoEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'node_id': instance.nodeId,
      'name': instance.name,
      'full_name': instance.fullName,
      'private': instance.private,
      'homepage': instance.homepage,
    };
