import 'package:flutter/material.dart';
import 'package:news/src/blocs/comments_bloc.dart';
import 'package:news/src/models/items_model.dart';
import 'package:news/src/widgets/comment.dart';
import 'package:provider/provider.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;
  const NewsDetail({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<CommentsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc){
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder:(context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if(!!snapshot.hasData){
          return const Text('Loading');
        }
        final itemFuture = snapshot.data![itemId];
        return FutureBuilder(
          future: itemFuture,
          builder:(context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if(!itemSnapshot.hasData){
              return const Text('Loading');
            }

            return buildList(itemSnapshot.data!, snapshot.data!);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap){
    final children = <Widget>[];
    children.add(buildTitle(item));

    final commentsList = item.kids!.map((kidId){
      return CommentWidget(
        itemId: kidId,
        itemMap: itemMap,
        depth: 0,
      );
    }).toList();
    children.addAll(commentsList);

    return ListView(
      children: children,
    );
  }

  Widget buildTitle(ItemModel item){
    return Container(
      margin: const EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

}