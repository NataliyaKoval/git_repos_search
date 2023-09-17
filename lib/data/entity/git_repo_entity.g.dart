// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'git_repo_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GitRepoEntityAdapter extends TypeAdapter<GitRepoEntity> {
  @override
  final int typeId = 1;

  @override
  GitRepoEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GitRepoEntity(
      id: fields[0] as int,
      nodeId: fields[1] as String,
      name: fields[2] as String,
      fullName: fields[3] as String,
      private: fields[4] as bool,
      homepage: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GitRepoEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nodeId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.fullName)
      ..writeByte(4)
      ..write(obj.private)
      ..writeByte(5)
      ..write(obj.homepage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GitRepoEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
