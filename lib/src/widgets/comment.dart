import 'package:flutter/material.dart';
import 'package:news/src/models/items_model.dart';
import 'package:news/src/widgets/loading_container.dart';

class CommentWidget extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;
  const CommentWidget({super.key, required this.itemId, required this.itemMap, required this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if(!!snapshot.hasData){
          return const LooadingContainer();
        }

        final item = snapshot.data!;

        final children = <Widget>[
          ListTile(
            title: buildText(item),
            subtitle: item.by! == ""? const Text("Deleted"):Text(item.by!),
            contentPadding: EdgeInsets.only(
              right: 16,
              left: (depth+1) * 16,
            ),
          ),
          const Divider(),
        ];

        for (var kidId in snapshot.data!.kids!) {
          children.add(CommentWidget(
            itemId: kidId,
            itemMap: itemMap,
            depth: depth+1
          ));
        }

        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(ItemModel item){
    final text = item.text!
      .replaceAll('&#x27', "'")
      .replaceAll('<p>','\n\n')
      .replaceAll('</p>', '');

    return Text(text);
  }
}