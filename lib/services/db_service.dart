import 'package:isar/isar.dart';
import 'package:notes/dao/note/note_dao.dart';
import 'package:path_provider/path_provider.dart';

abstract class DBService {
  static late final Isar _db;

  static Future<void> setup() async {
    final dir = await getApplicationDocumentsDirectory();
    _db = await Isar.open([NoteDaoSchema], directory: dir.path);
  }

  static Future<List<NoteDao>> getNotes(int start, int count) {
    return _db.noteDaos
        .where()
        .sortByTimeDesc()
        .offset(start)
        .limit(count)
        .findAll();
  }

  static Future<void> deleteNote(int id) {
    return _db.writeTxn(() async => await _db.noteDaos.delete(id));
  }

  static Stream<void> notesStream() => _db.noteDaos.watchLazy();

  static Future<NoteDao?> getNote(int id) => _db.noteDaos.get(id);

  static Future<void> saveNote(NoteDao note) {
    return _db.writeTxn(() async => await _db.noteDaos.put(note));
  }
}
