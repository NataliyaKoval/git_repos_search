import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:git_repos_search/consts/app_colors.dart';
import 'package:git_repos_search/consts/app_strings.dart';
import 'package:git_repos_search/consts/image_assets.dart';
import 'package:git_repos_search/domain/repository/repository.dart';
import 'package:git_repos_search/domain/use_cases/fetch_git_repos_use_case.dart';
import 'package:git_repos_search/domain/use_cases/get_favorites_use_case.dart';
import 'package:git_repos_search/domain/use_cases/get_saved_queries_use_case.dart';
import 'package:git_repos_search/domain/use_cases/save_query_use_case.dart';
import 'package:git_repos_search/domain/use_cases/toggle_favorite_use_case.dart';
import 'package:git_repos_search/presentation/favorite_screen/favorite_page.dart';
import 'package:git_repos_search/presentation/search_screen/widgets/empty_result_container.dart';
import 'package:git_repos_search/presentation/search_screen/widgets/history_loaded_container.dart';
import 'package:git_repos_search/presentation/search_screen/widgets/search_loaded_container.dart';
import 'package:git_repos_search/presentation/search_screen/widgets/search_text_field.dart';

import 'bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final inputController = TextEditingController();

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (BuildContext context) => SearchBloc(
        fetchGitReposUseCase: FetchGitReposUseCase(
          repository: context.read<Repository>(),
        ),
        toggleFavoritesUsecase: ToggleFavoritesUsecase(
          repository: context.read<Repository>(),
        ),
        saveQueryUseCase: SaveQueryUseCase(
          repository: context.read<Repository>(),
        ),
        getSavedQueriesUseCase: GetSavedQueriesUseCase(
          repository: context.read<Repository>(),
        ),
        getFavoritesUseCase: GetFavoritesUseCase(
          repository: context.read<Repository>(),
        ),
      )..add(PageLoadedEvent()),
      child: Builder(builder: (context) {
        return BlocListener<SearchBloc, SearchState>(
          listener: (context, state) {
            if (state is SearchError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: Scaffold(
            appBar: _buildAppBar(context),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SearchTextField(),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) =>
                          _buildScreenBody(context, state),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 44,
      backgroundColor: AppColors.ghostWhite,
      centerTitle: true,
      title: Text(
        AppStrings.searchScreenTitle,
        style: const TextStyle(color: AppColors.blackChocolate),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 11),
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => _awaitReturnValueFromFavoriteScreen(context),
              icon: SvgPicture.asset(
                ImageAssets.star,
                color: AppColors.ghostWhite,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildScreenBody(BuildContext context, SearchState state) {
    if (state is HistoryLoaded) {
      return HistoryLoadedContainer(
        historyItems: state.historyItems,
      );
    } else if (state is HistoryEmpty) {
      return EmptyResultContainer(
        title: AppStrings.searchHistory,
        description: AppStrings.noHistory,
      );
    } else if (state is SearchEmpty) {
      return EmptyResultContainer(
        title: AppStrings.whatFound,
        description: AppStrings.noSearch,
      );
    } else if (state is SearchLoaded) {
      return SearchLoadedContainer(
        gitRepos: state.gitRepos,
      );
    } else if (state is SearchLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Container();
    }
  }

  void _awaitReturnValueFromFavoriteScreen(BuildContext context) async {
    if (!context.mounted) return;
    final List<int> result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FavoritePage(),
        ));
    if (result.isNotEmpty) {
      context.read<SearchBloc>().add(UpdateListEvent(result));
    }
  }
}
