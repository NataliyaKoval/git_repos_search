part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchGitReposEvent extends SearchEvent {
  SearchGitReposEvent(this.query);

  final String query;
}

class ToggleFavoriteEvent extends SearchEvent {
  ToggleFavoriteEvent(this.gitRepo);

  final GitRepo gitRepo;
}

class UpdateListEvent extends SearchEvent {
  UpdateListEvent(this.removedFavorites);

  final List<int> removedFavorites;
}

class PageLoadedEvent extends SearchEvent {}