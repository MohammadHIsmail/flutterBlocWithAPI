import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_bloc.dart';
import 'package:provider/provider.dart';

class Refresh extends StatelessWidget {
    final Widget child;

  const Refresh({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<StoriesBloc>(context);

    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
    );
  }
}