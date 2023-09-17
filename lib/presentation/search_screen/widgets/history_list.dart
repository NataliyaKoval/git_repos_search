import 'package:flutter/material.dart';
import 'package:git_repos_search/domain/models/history_item.dart';
import 'package:git_repos_search/presentation/search_screen/widgets/history_list_item.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({
    Key? key,
    required this.historyItems,
  }) : super(key: key);

  final List<HistoryItem> historyItems;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 8,
      ),
      itemCount: historyItems.length,
      itemBuilder: (context, index) => HistoryListItem(
        historyItem: historyItems[index],
      ),
    );
  }
}
