import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';


void main(){
  test('Fetch top IDs', () async {
    //setup of test case
    final newsApi=NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(jsonEncode([1,2,3,4]),200);
    });

    final ids = await newsApi.fetchTopIds();
    //expectation
    expect(ids, [1,2,3,4]);
  });

  test('fetxhItem', () async {
    final newsApi=NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id':123};
      return Response(jsonEncode(jsonMap),200);
    });

    final item = await newsApi.fetchItem(999);

    expect(item.id, 123);
  });
}