import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_repos_search/domain/models/git_repo.dart';
import 'package:git_repos_search/domain/models/git_repo_response.dart';
import 'package:git_repos_search/domain/use_cases/fetch_git_repos_use_case.dart';
import 'package:git_repos_search/domain/use_cases/toggle_favorite_use_case.dart';
import 'package:git_repos_search/utils/debouncer.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required this.fetchGitReposUseCase,
    required this.toggleFavoritesUsecase,
  }) : super(SearchInitial()) {
    on<SearchGitReposEvent>(_searchGitRepos, transformer: Debouncer.debounce());
    on<ToggleFavoriteEvent>(_toggleFavorite);
  }

  final FetchGitReposUseCase fetchGitReposUseCase;
  final ToggleFavoritesUsecase toggleFavoritesUsecase;

  static const int _itemsCount = 15;
  bool isFutureRunning = false;
  List<GitRepo> allGitRepos = [];

  Future<void> _searchGitRepos(
      SearchGitReposEvent event, Emitter<SearchState> emit) async {
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
      allGitRepos = response.items;
      emit(
        SearchLoaded(gitRepos: allGitRepos),
      );
    } catch (e) {
      print(e);
    } finally {
      isFutureRunning = false;
    }
  }

  Future<void> _toggleFavorite(ToggleFavoriteEvent event, Emitter<SearchState> emit) async {
    try {
      GitRepo changedGitRepo =
      await toggleFavoritesUsecase(event.gitRepo);

      final index =
      allGitRepos.indexWhere((element) => element.id == event.gitRepo.id);
      allGitRepos[index] = changedGitRepo;
      emit(
        SearchLoaded(gitRepos: allGitRepos),
      );
    } catch (e) {
      print(e);
    }
  }
}
