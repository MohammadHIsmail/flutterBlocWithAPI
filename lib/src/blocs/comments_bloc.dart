import 'package:news/src/models/items_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CommentsBloc{
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _repository = Repository();

  Stream<Map<int, Future<ItemModel>>> get itemWithComments => _commentsOutput.stream;

  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc(){
    _commentsFetcher.stream
      .transform(_commentsTransformer())
      .pipe(_commentsOutput);
  }

  _commentsTransformer(){
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (cache, int id, index){
        cache[id] = _repository.fetchItem(id);
        //recursive data fetching
        cache[id]!.then((ItemModel item) {
          for (var kidId in item.kids!) {
            fetchItemWithComments(kidId);
          }
        });
        return cache;
      },
      <int, Future<ItemModel>>{

      }
    );
  }

  dispose(){
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}