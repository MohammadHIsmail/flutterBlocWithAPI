import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_bloc.dart';
import 'package:news/src/screens/news_list.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<StoriesBloc>(
      create: (context) => StoriesBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      child: const MaterialApp(
        title: 'News!',
        home: NewsList(),
      ),
    );
  }
}