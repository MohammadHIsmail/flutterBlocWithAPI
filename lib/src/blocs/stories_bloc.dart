import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc{

  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();

  Stream<List<int>> get topIds => _topIds.stream;

  //getting the data fro the repo and adding it to the list to be displaed in the app
  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  dispose(){
    _topIds.close();
  }
}