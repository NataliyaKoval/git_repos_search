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
}
