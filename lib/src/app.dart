import 'package:flutter/material.dart';
import 'package:news/src/blocs/comments_bloc.dart';
import 'package:news/src/blocs/stories_bloc.dart';
import 'package:news/src/screens/news_detail.dart';
import 'package:news/src/screens/news_list.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<CommentsBloc>(
      create: (context)=> CommentsBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      child: Provider<StoriesBloc>(
        create: (context) => StoriesBloc(),
        dispose: (context, bloc) => bloc.dispose(),
        child: MaterialApp(
          title: 'News!',
          // home: NewsList(),
          onGenerateRoute: routes,
        ),
      ),
    );
    
  }

  Route routes(RouteSettings settings){
    if(settings.name == '/'){
      return MaterialPageRoute(
        builder: (context) {
          final bloc = Provider.of<StoriesBloc>(context);
          bloc.fetchTopIds();
          return const NewsList();
        },
      );
    }else{
      return MaterialPageRoute(
        builder: (context) {
          final commentsBloc = Provider.of<CommentsBloc>(context);
          final itemId = int.parse(settings.name!.replaceFirst('/', ''));

          commentsBloc.fetchItemWithComments(itemId);

          return NewsDetail(
            itemId: itemId,
          );
        },
      );
    }
    
}
}