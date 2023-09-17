import 'package:flutter/material.dart';
import 'package:git_repos_search/consts/app_colors.dart';
import 'package:git_repos_search/consts/app_strings.dart';
import 'package:git_repos_search/domain/models/git_repo.dart';
import 'package:git_repos_search/presentation/search_screen/widgets/search_results_list.dart';

class SearchLoadedContainer extends StatelessWidget {
  const SearchLoadedContainer({
    super.key,
    required this.gitRepos,
  });

  final List<GitRepo> gitRepos;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.whatHaveFound,
          style: const TextStyle(
            color: AppColors.blue,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: SearchResultList(
            gitRepos: gitRepos,
          ),
        ),
      ],
    );
  }
}
