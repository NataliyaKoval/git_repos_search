import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:git_repos_search/consts/app_colors.dart';
import 'package:git_repos_search/consts/app_strings.dart';
import 'package:git_repos_search/consts/image_assets.dart';
import 'package:git_repos_search/domain/repository/repository.dart';
import 'package:git_repos_search/domain/use_cases/get_favorites_use_case.dart';
import 'package:git_repos_search/domain/use_cases/remove_favorites_use_case.dart';
import 'package:git_repos_search/presentation/favorite_screen/bloc/favorite_cubit.dart';
import 'package:git_repos_search/presentation/favorite_screen/widgets/empty_favorite_container.dart';
import 'package:git_repos_search/presentation/favorite_screen/widgets/favorite_loaded_container.dart';

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
            _navigateToSearchScreen(context);
            return false;
          },
          child: Scaffold(
            appBar: _buildAppBar(context),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              child: BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, state) {
                  if (state is FavoriteLoaded) {
                    return FavoriteLoadedContainer(gitRepos: state.gitRepos);
                  } else if (state is FavoriteEmpty) {
                    return const EmptyFavoriteContainer();
                  } else if (state is FavoriteLoading) {
                    return const Center(child: CircularProgressIndicator());
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

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 54,
      backgroundColor: AppColors.ghostWhite,
      centerTitle: true,
      title: Text(
        AppStrings.favoriteScreenTitle,
        style: const TextStyle(color: AppColors.blackChocolate),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 15, top: 7, bottom: 7),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () {
              _navigateToSearchScreen(context);
            },
            icon: SvgPicture.asset(
              ImageAssets.arrow,
              color: AppColors.ghostWhite,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToSearchScreen(BuildContext context) {
    final List<int> removedGitRepos =
        context.read<FavoriteCubit>().removedFavoriteIndexes;
    Navigator.of(context).pop(removedGitRepos);
  }
}
