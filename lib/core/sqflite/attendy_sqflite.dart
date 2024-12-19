import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AttendySqflite {
  static Database? _attendySqflite;

  Future<Database?> get attendySqflite async =>
      _attendySqflite ??= await initSqflite();

  initSqflite() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'attendy.db');
    Database attendyDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
      onDowngrade: _onUpgrade,
    );
    return attendyDatabase;
  }

  _onUpgrade(Database database, int oldVersion, int newVersion) async {}

  _onConfigure(Database database) async {
    await database.execute('PRAGMA foreign_keys = ON');
  }

  _onCreate(Database database, int version) async {
    await database.execute('''
    CREATE TABLE student (
    student_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    level TEXT NOT NULL
);
    ''');

    await database.execute('''
    CREATE TABLE section (
    section_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT
);
    ''');

    await database.execute('''
    CREATE TABLE enrollment (
    enrollment_id INTEGER PRIMARY KEY ,
    student_id INT NOT NULL,
    section_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (section_id) REFERENCES section(section_id) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (student_id, section_id) -- Prevent duplicate enrollments
);
    ''');
    await database.execute('''
CREATE TABLE week (
    week_id INTEGER PRIMARY KEY ,
    section_id INT NOT NULL,
    week_number INT NOT NULL,
    FOREIGN KEY (section_id) REFERENCES section(section_id) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (section_id, week_number) -- Prevent duplicate weeks in a section
);
    ''');


    await database.execute('''
      CREATE TABLE attendance (
          attendance_id INTEGER PRIMARY KEY,
          enrollment_id INT NOT NULL,
          week_id INT NOT NULL,
          status TEXT NOT NULL, -- E.g., "Present", "Absent", "Late"
          FOREIGN KEY (enrollment_id) REFERENCES enrollment(enrollment_id),
          FOREIGN KEY (week_id) REFERENCES week(week_id),
          UNIQUE (enrollment_id, week_id) -- Prevent duplicate status for the same student in the same week
      );
    ''');
    print("Database Created With Tables");
  }

  readData(String sql) async {
    Database? db = await attendySqflite;
    List<Map> response = await db!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? db = await attendySqflite;
    int response = await db!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? db = await attendySqflite;
    int response = await db!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? db = await attendySqflite;
    int response = await db!.rawDelete(sql);
    return response;
  }
}
