import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_bloc.dart';
import 'package:provider/provider.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<StoriesBloc>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if(!snapshot.hasData){
          return const Center(
            child: CircularProgressIndicator()
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, int index) {
            return Text('${snapshot.data![index]}');
          }
        );
      }
    );
  }

  getFuture(){
    return Future.delayed(
      const Duration(seconds: 2),
      ()=>'hi',
    );
  }
}