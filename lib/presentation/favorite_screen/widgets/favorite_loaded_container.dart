import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_repos_search/domain/models/git_repo.dart';
import 'package:git_repos_search/presentation/favorite_screen/bloc/favorite_cubit.dart';
import 'package:git_repos_search/presentation/widgets/git_repo_list_item.dart';

class FavoriteLoadedContainer extends StatelessWidget {
  const FavoriteLoadedContainer({
    super.key,
    required this.gitRepos,
  });

  final List<GitRepo> gitRepos;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 8,
      ),
      itemCount: gitRepos.length,
      itemBuilder: (context, index) => GitRepoListItem(
        gitRepo: gitRepos[index],
        onPressed: () {
          context.read<FavoriteCubit>().removeFavorite(gitRepos[index]);
        },
      ),
    );
  }
}
