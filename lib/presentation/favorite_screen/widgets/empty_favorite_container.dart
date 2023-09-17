import 'package:flutter/material.dart';
import 'package:git_repos_search/consts/app_strings.dart';
import 'package:git_repos_search/presentation/widgets/empty_list_text.dart';

class EmptyFavoriteContainer extends StatelessWidget {
  const EmptyFavoriteContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: EmptyListText(
        text: AppStrings.noFavorites,
      ),
    );
  }
}
