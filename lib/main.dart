import 'package:flutter/material.dart';
import 'package:git_repos_search/data/entity/git_repo_entity.dart';
import 'package:git_repos_search/di/providers.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'presentation/splash_screen/splash_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<GitRepoEntity>(GitRepoEntityAdapter());
  await Hive.openBox<String>('queries');
  await Hive.openBox<GitRepoEntity>('favorites');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
