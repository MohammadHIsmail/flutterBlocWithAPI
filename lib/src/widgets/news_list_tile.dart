import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_bloc.dart';
import 'package:news/src/models/items_model.dart';
import 'package:news/src/widgets/loading_container.dart';
import 'package:provider/provider.dart';

class NewsListTile extends StatelessWidget {
  final int? itemId;
  const NewsListTile({super.key, this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<StoriesBloc>(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if(!snapshot.hasData){
          return const LooadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data![itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if(!itemSnapshot.hasData){
              return const LooadingContainer();
            }
            return buildTile(context, itemSnapshot.data!);
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context,ItemModel item){
    return Column(
      children: [
        ListTile(
          title: Text(item.title!),
          subtitle: Text('${item.score} points'),
          trailing: Column(
            children: [
              const Icon(Icons.comment),
              Text('${item.descendants}')
            ],
          ),
          onTap: (){
              Navigator.pushNamed(
                context, 
                '/${item.id}'
              );
          },
        ),
        const Divider()
      ],
    );
  }
}