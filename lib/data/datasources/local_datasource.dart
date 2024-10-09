import 'package:hive/hive.dart';

class LocalDataSource<T> {
  final Box<T> _hiveBox;

  LocalDataSource(this._hiveBox);

  Future<void> saveData(String key, T value) async {
    await _hiveBox.put(key, value);
  }

  Future<T?> findOne(String key) async {
    return _hiveBox.get(key);
  }

  Future<void> removeData(String key) async {
    await _hiveBox.delete(key);
  }

  Future<List<T>> findMany() async {
    return _hiveBox.values.toList();
  }
}
