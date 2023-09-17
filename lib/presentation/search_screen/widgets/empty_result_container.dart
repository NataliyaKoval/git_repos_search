import 'package:flutter/material.dart';
import 'package:git_repos_search/consts/app_colors.dart';
import 'package:git_repos_search/presentation/widgets/empty_list_text.dart';

class EmptyResultContainer extends StatelessWidget {
  const EmptyResultContainer({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.blue,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Center(
            child: EmptyListText(
              text: description,
            ),
          ),
        ),
      ],
    );
  }
}
