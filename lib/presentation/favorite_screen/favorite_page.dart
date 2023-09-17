import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_repos_search/domain/repository/repository.dart';
import 'package:git_repos_search/domain/use_cases/get_favorites_use_case.dart';
import 'package:git_repos_search/domain/use_cases/remove_favorites_use_case.dart';
import 'package:git_repos_search/presentation/favorite_screen/bloc/favorite_cubit.dart';
import 'package:git_repos_search/presentation/widgets/git_repo_list_item.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteCubit>(
      create: (context) => FavoriteCubit(
        getFavoritesUseCase: GetFavoritesUseCase(
          repository: context.read<Repository>(),
        ),
        removeFavoritesUsecase: RemoveFavoritesUsecase(
          repository: context.read<Repository>(),
        ),
      )..getFavorites(),
      child: Builder(builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            final List<int> removedGitRepos =
                context.read<FavoriteCubit>().removedFavoriteIndexes;
            Navigator.of(context).pop(removedGitRepos);
            return false;
          },
          child: Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              child: BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, state) {
                  if (state is FavoriteLoaded) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                      itemCount: state.gitRepos.length,
                      itemBuilder: (context, index) => GitRepoListItem(
                        gitRepo: state.gitRepos[index],
                        onPressed: () {
                          context
                              .read<FavoriteCubit>()
                              .removeFavorite(state.gitRepos[index]);
                        },
                      ),
                    );
                  } else if (state is FavoriteEmpty) {
                    return Container(color: Colors.green,);
                  } else if (state is FavoriteLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
