import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:git_repos_search/consts/app_colors.dart';
import 'package:git_repos_search/consts/image_assets.dart';
import 'package:git_repos_search/domain/models/history_item.dart';

class HistoryListItem extends StatelessWidget {
  const HistoryListItem({
    Key? key,
    required this.historyItem,
  }) : super(key: key);

  final HistoryItem historyItem;

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
          Text(historyItem.name),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SvgPicture.asset(
              ImageAssets.star,
              color:
              historyItem.isFavorite ? AppColors.blue : AppColors.argent,
            ),
          ),
        ],
      ),
    );
  }
}