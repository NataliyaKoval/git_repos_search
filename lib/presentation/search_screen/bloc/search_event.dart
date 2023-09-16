part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchGitRepos extends SearchEvent {
  SearchGitRepos(this.query);

  final String query;
}
