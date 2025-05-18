import 'package:isar/isar.dart';
import 'package:notes/dto/note/note_dto.dart';
import 'package:path_provider/path_provider.dart';

abstract class DBService {
  static late final Isar db;

  static Future<void> setup() async {
    final dir = await getApplicationDocumentsDirectory();
    db = await Isar.open([NoteDtoSchema], directory: dir.path);
  }
}
