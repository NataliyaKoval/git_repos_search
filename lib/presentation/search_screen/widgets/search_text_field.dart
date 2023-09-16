import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:git_repos_search/consts/app_colors.dart';
import 'package:git_repos_search/consts/image_assets.dart';
import 'package:git_repos_search/presentation/search_screen/bloc/search_bloc.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late FocusNode _textFieldFocusNode;
  late TextEditingController _inputController;
  bool _isFilled = false;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
    _textFieldFocusNode = FocusNode()..addListener(() => _changeInputFilling());
  }

  void _changeInputFilling() {
    setState(() {
      _isFilled = _textFieldFocusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _inputController,
      focusNode: _textFieldFocusNode,
      decoration: InputDecoration(
        filled: _isFilled,
        fillColor: AppColors.lavender,
        contentPadding: const EdgeInsets.all(18),
        prefixIconConstraints: const BoxConstraints(
          minHeight: 24,
          minWidth: 24,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 18,
            right: 14,
          ),
          child: SvgPicture.asset(
            ImageAssets.search,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.blue,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 20,
          minWidth: 20,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 18),
          child: IconButton(
            onPressed: () => _inputController.clear(),
            icon: SvgPicture.asset(
              ImageAssets.close,
            ),
          ),
        ),
        hintText: 'Search',
        hintStyle: const TextStyle(color: AppColors.argent),
      ),
      onChanged: (value) => _onInputChanged(context, value),
    );
  }

  void _onInputChanged(BuildContext context, String value) {
    context.read<SearchBloc>().add(SearchGitRepos(value));
  }
}
