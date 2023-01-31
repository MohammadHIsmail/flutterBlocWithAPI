import 'package:news/src/models/items_model.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'package:news/src/resources/news_db_provider.dart';

class Repository{
  List<Source> sources= <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];
  List<Cache> caches= <Cache>[
    newsDbProvider,
  ];

  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds(){
    // return apiProvider.fetchTopIds();
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel? item;
    Source source;
    for(source in sources){
      item = await source.fetchItem(id);
      if(item != null){
        break;
      }
    }

    for(var cache in caches){
      cache.addItem(item!);
    }
    // var item = await dbProvider.fetchItem(id);
    // if(item != null){
    //   return item;
    // }
    // item = await apiProvider.fetchItem(id);
    // dbProvider.addItem(item);
    // return item;
    return item!;
  }
}

abstract class Source{
  Future<List<int>> fetchTopIds();
  Future<ItemModel?> fetchItem(int id);
}

abstract class Cache{
  Future<int> addItem(ItemModel item);
}