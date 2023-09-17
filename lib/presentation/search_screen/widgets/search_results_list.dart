import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_repos_search/domain/models/git_repo.dart';
import 'package:git_repos_search/presentation/search_screen/bloc/search_bloc.dart';
import 'package:git_repos_search/presentation/widgets/git_repo_list_item.dart';

class SearchResultList extends StatelessWidget {
  const SearchResultList({
    Key? key,
    required this.gitRepos,
  }) : super(key: key);

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
          context.read<SearchBloc>().add(ToggleFavoriteEvent(gitRepos[index]));
        },
      ),
    );
  }
}
