import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_repos_search/consts/app_colors.dart';
import 'package:git_repos_search/consts/app_strings.dart';
import 'package:git_repos_search/presentation/search_screen/search_page.dart';
import 'package:git_repos_search/presentation/splash_screen/bloc/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (BuildContext context) => SplashCubit()..loadFakeData(),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashFakeDataLoaded) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              color: AppColors.blue,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.splashText,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.antiFlashWhite),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const CircularProgressIndicator(
                      color: AppColors.antiFlashWhite),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
