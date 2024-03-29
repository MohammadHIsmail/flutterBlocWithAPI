import 'package:news/src/models/items_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc{

  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int,Future<ItemModel>>>();
  final _itemsFetcher= PublishSubject<int>();

  Stream<List<int>> get topIds => _topIds.stream;
  Stream<Map<int,Future<ItemModel>>> get items => _itemsOutput.stream;

  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc(){
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  //getting the data fro the repo and adding it to the list to be displaed in the app
  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  clearCache(){
    return _repository.clearCache();
  }

  _itemsTransformer(){
    return ScanStreamTransformer(
      (Map<int,Future<ItemModel>> cache, int id, index){
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int,Future<ItemModel>>{}
    );
  }

  dispose(){
    _topIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }
}