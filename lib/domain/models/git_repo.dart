class GitRepo {
  const GitRepo({
    required this.id,
    required this.nodeId,
    required this.name,
    required this.fullName,
    required this.private,
    this.homepage,
    this.isFavorite = false,
  });

  final int id;
  final String nodeId;
  final String name;
  final String fullName;
  final bool private;
  final String? homepage;
  final bool isFavorite;

  GitRepo copyWith({
    int? id,
    String? nodeId,
    String? name,
    String? fullName,
    bool? private,
    String? homepage,
    bool? isFavorite,
  }) {
    return GitRepo(
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
