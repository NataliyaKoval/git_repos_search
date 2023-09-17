import 'package:flutter/material.dart';
import 'package:git_repos_search/consts/app_colors.dart';

class EmptyListText extends StatelessWidget {
  const EmptyListText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: AppColors.argent,
      ),
    );
  }
}
