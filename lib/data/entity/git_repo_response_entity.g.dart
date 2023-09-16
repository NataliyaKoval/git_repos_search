// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_repo_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitRepoResponseEntity _$GitRepoResponseEntityFromJson(
        Map<String, dynamic> json) =>
    GitRepoResponseEntity(
      totalCount: json['total_count'] as int,
      incompleteResults: json['incomplete_results'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((e) => GitRepoEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GitRepoResponseEntityToJson(
        GitRepoResponseEntity instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'incomplete_results': instance.incompleteResults,
      'items': instance.items,
    };
