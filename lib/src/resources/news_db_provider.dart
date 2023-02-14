import 'dart:io';
import 'package:news/src/models/items_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NewsDbProvider implements Source, Cache{
  Database? db;

  NewsDbProvider(){
    init();
  }

  @override
  Future<List<int>> fetchTopIds() {
    throw UnimplementedError();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path  = join(documentsDirectory.path, 'items.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version){
        newDb.execute("""
          CREATE TABLE Items(
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            parent INTEGER,
            kids BLOB,
            dead INTEGER,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          )
        """);
      }
    );
  }

  @override
  Future<ItemModel?> fetchItem(int id) async {
    final maps = await db!.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if(maps.isNotEmpty){
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  @override
  Future<int> addItem(ItemModel item){
    return db!.insert(
      'Items', 
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore
    );
  }

  @override
  clear(){
    return db!.delete("Items");
  }
}

final newsDbProvider = NewsDbProvider();