import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:news/src/models/items_model.dart';
import 'package:news/src/resources/repository.dart';

const _root= 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source{
  Client client = Client();

  @override
  Future<List<int>> fetchTopIds() async {
    final response = await client.get(Uri.parse('$_root/topstories.json'));
    final ids= jsonDecode(response.body);
    return ids.cast<int>();
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get(Uri.parse('$_root/item/$id.json'));
    final parsedJson= jsonDecode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}

