import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:git_repos_search/consts/app_colors.dart';
import 'package:git_repos_search/consts/image_assets.dart';
import 'package:git_repos_search/domain/models/git_repo.dart';

import '../search_screen/bloc/search_bloc.dart';

class GitRepoListItem extends StatelessWidget {
  const GitRepoListItem({
    Key? key,
    required this.gitRepo,
  }) : super(key: key);

  final GitRepo gitRepo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 10,
      ),
      height: 55,
      color: AppColors.antiFlashWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 200,
            child: Text(gitRepo.name, overflow: TextOverflow.ellipsis),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            icon: SvgPicture.asset(
              ImageAssets.star,
              color: gitRepo.isFavorite ? AppColors.blue : AppColors.argent,
            ),
            onPressed: () {
              context.read<SearchBloc>().add(ToggleFavoriteEvent(gitRepo));
            },
          ),
        ],
      ),
    );
  }
}
