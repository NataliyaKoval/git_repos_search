import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_repos_search/domain/models/git_repo.dart';
import 'package:git_repos_search/domain/models/git_repo_response.dart';
import 'package:git_repos_search/domain/models/history_item.dart';
import 'package:git_repos_search/domain/use_cases/fetch_git_repos_use_case.dart';
import 'package:git_repos_search/domain/use_cases/get_favorite_keys_use_case.dart';
import 'package:git_repos_search/domain/use_cases/get_favorites_use_case.dart';
import 'package:git_repos_search/domain/use_cases/get_saved_queries_use_case.dart';
import 'package:git_repos_search/domain/use_cases/save_query_use_case.dart';
import 'package:git_repos_search/domain/use_cases/toggle_favorite_use_case.dart';
import 'package:git_repos_search/utils/debouncer.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required this.fetchGitReposUseCase,
    required this.toggleFavoritesUsecase,
    required this.saveQueryUseCase,
    required this.getSavedQueriesUseCase,
    required this.getFavoritesUseCase,
    required this.getFavoriteKeysUseCase,
  }) : super(SearchInitial()) {
    on<SearchGitReposEvent>(_searchGitRepos, transformer: Debouncer.debounce());
    on<ToggleFavoriteEvent>(_toggleFavorite);
    on<UpdateListEvent>(_updateListAfterRemovingFavorites);
    on<PageLoadedEvent>(_getQueriesHistory);
  }

  final FetchGitReposUseCase fetchGitReposUseCase;
  final ToggleFavoritesUsecase toggleFavoritesUsecase;
  final SaveQueryUseCase saveQueryUseCase;
  final GetSavedQueriesUseCase getSavedQueriesUseCase;
  final GetFavoritesUseCase getFavoritesUseCase;
  final GetFavoriteKeysUseCase getFavoriteKeysUseCase;

  static const int _itemsCount = 15;
  bool isFutureRunning = false;
  List<GitRepo> checkedGitRepos = [];

  Future<void> _searchGitRepos(
      SearchGitReposEvent event, Emitter<SearchState> emit) async {
    if (isFutureRunning) {
      return;
    }
    isFutureRunning = true;
    emit(SearchLoading());

    try {
      await saveQueryUseCase(event.query);
      GitRepoResponse response = await fetchGitReposUseCase.call(GitRepoParams(
        query: event.query,
        itemsCount: _itemsCount,
      ));
      List<GitRepo> allGitRepos = response.items;
      if (allGitRepos.isEmpty) {
        emit(SearchEmpty());
      } else {
        List keys = await getFavoriteKeysUseCase();
        checkedGitRepos = allGitRepos.map((gitRepo) {
          if (keys.contains(gitRepo.id)) {
            return gitRepo.copyWith(isFavorite: true);
          } else {
            return gitRepo;
          }
        }).toList();
        emit(SearchLoaded(gitRepos: checkedGitRepos));
      }
    } catch (e) {
      print(e);
    } finally {
      isFutureRunning = false;
    }
  }

  Future<void> _toggleFavorite(
      ToggleFavoriteEvent event, Emitter<SearchState> emit) async {
    try {
      GitRepo changedGitRepo = await toggleFavoritesUsecase(event.gitRepo);

      final index =
      checkedGitRepos.indexWhere((element) => element.id == event.gitRepo.id);
      checkedGitRepos[index] = changedGitRepo;
      emit(
        SearchLoaded(gitRepos: checkedGitRepos),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> _updateListAfterRemovingFavorites(
      UpdateListEvent event, Emitter<SearchState> emit) async {
    List<GitRepo> newList = checkedGitRepos.map((e) {
      if (event.removedFavorites.contains(e.id)) {
        return e.copyWith(isFavorite: false);
      } else {
        return e;
      }
    }).toList();
    checkedGitRepos = newList;
    emit(
      SearchLoaded(gitRepos: checkedGitRepos),
    );
  }

  Future<void> _getQueriesHistory(
      PageLoadedEvent event, Emitter<SearchState> emit) async {
    try {
      List<String> queries = await getSavedQueriesUseCase();

      if (queries.isEmpty) {
        emit(HistoryEmpty());
      } else {
        List<GitRepo> favorites = await getFavoritesUseCase();
        List<String> favoriteNames =
            favorites.map((favorite) => favorite.name).toList();
        List<HistoryItem> historyItems = queries.map((query) {
          if (favoriteNames.contains(query)) {
            return HistoryItem(name: query, isFavorite: true);
          } else {
            return HistoryItem(name: query, isFavorite: false);
          }
        }).toList();
        emit(HistoryLoaded(historyItems: historyItems));
      }
    } catch (e) {
      print(e);
    }
  }
}
