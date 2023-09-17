import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_repos_search/domain/models/git_repo.dart';
import 'package:git_repos_search/domain/use_cases/get_favorites_use_case.dart';
import 'package:git_repos_search/domain/use_cases/remove_favorites_use_case.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit({
    required this.getFavoritesUseCase,
    required this.removeFavoritesUsecase,
  }) : super(FavoriteInitial());

  final GetFavoritesUseCase getFavoritesUseCase;
  final RemoveFavoritesUsecase removeFavoritesUsecase;

  List<GitRepo> mappedFavorites = [];
  List<int> removedFavoriteIndexes = [];

  Future<void> getFavorites() async {
    emit(FavoriteLoading());
    try {
      List<GitRepo> favorites = await getFavoritesUseCase();
      if (favorites.isNotEmpty) {
        mappedFavorites = favorites
            .map((gitRepo) => gitRepo.copyWith(isFavorite: true))
            .toList();
        emit(FavoriteLoaded(gitRepos: mappedFavorites));
      } else {
        emit(FavoriteEmpty());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeFavorite(GitRepo gitRepo) async {
    removedFavoriteIndexes.add(gitRepo.id);
    try {
      removeFavoritesUsecase(gitRepo);
      mappedFavorites.removeWhere((element) => element.id == gitRepo.id);
      if (mappedFavorites.isNotEmpty) {
        emit(FavoriteLoaded(gitRepos: mappedFavorites));
      } else {
        emit(FavoriteEmpty());
      }
    } catch (e) {
      print(e);
    }
  }
}
