import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_repos_search/domain/models/git_repo.dart';
import 'package:git_repos_search/domain/models/git_repo_response.dart';
import 'package:git_repos_search/domain/use_cases/fetch_git_repos_use_case.dart';
import 'package:git_repos_search/utils/debouncer.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.fetchGitReposUseCase}) : super(SearchInitial()) {
    on<SearchGitRepos>(_searchGitRepos, transformer: Debouncer.debounce());
  }

  final FetchGitReposUseCase fetchGitReposUseCase;

  static const int _itemsCount = 15;
  bool isFutureRunning = false;

  Future<void> _searchGitRepos(
      SearchGitRepos event, Emitter<SearchState> emit) async {
    if (isFutureRunning) {
      return;
    }
    isFutureRunning = true;
    emit(SearchLoading());

    try {
      GitRepoResponse response = await fetchGitReposUseCase.call(GitRepoParams(
        query: event.query,
        itemsCount: _itemsCount,
      ));
      emit(
        SearchLoaded(gitRepos: response.items),
      );
    } catch (e) {
      print(e);
    } finally {
      isFutureRunning = false;
    }
  }
}
