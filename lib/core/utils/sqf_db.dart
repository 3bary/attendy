import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfDb{

  static Database? _db;
  Future<Database?> get db async{
    if (_db ==null){
      _db=await initialDb();
      return _db;
    }else{
      return _db;
    }
  }

  initialDb()async{
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'attendyy.db');

    // open the database
    Database database = await openDatabase(
        path,
        version: 6,
        onCreate:_onCreate,
        onUpgrade: _onUpgrade
    );
    return database;
  }

  _onUpgrade(Database db,int oldVersion ,int newVersion){
    print('_onUpgrade==================================');

  }
  _onCreate(Database db, int version) async {
    // When creating the db, create the table

    await db.execute(
        '''CREATE TABLE students (
    student_id INTEGER   PRIMARY KEY,
    name TEXT NOT NULL,
    leve TEXT NOT NULL
          )'''
    );

    await db.execute(
        '''CREATE TABLE section (
    section_id INTEGER  PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT
);
'''
    );
    await db.execute(
        '''CREATE TABLE enrollment (
    enrollment_id INTEGER  PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER  NOT NULL,
    section_id INTEGER  NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (section_id) REFERENCES section(section_id) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (student_id, section_id) -- Prevent duplicate enrollments
);

'''
    );
    await db.execute(
        '''CREATE TABLE week (
    week_id INTEGER  PRIMARY KEY ,
    section_id INTEGER  NOT NULL,
    week_number INTEGER  NOT NULL,
    FOREIGN KEY (section_id) REFERENCES section(section_id) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (section_id, week_number) -- Prevent duplicate weeks in a section
);

'''
    );
    await db.execute(
        '''CREATE TABLE attendance (
    attendance_id INTEGER  PRIMARY KEY ,
    enrollment_id INTEGER  NOT NULL,
    week_id INTEGER  NOT NULL,
    status TEXT NOT NULL, -- E.g., "Present", "Absent", "Late"
    FOREIGN KEY (enrollment_id) REFERENCES enrollment(enrollment_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (week_id) REFERENCES week(week_id) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (enrollment_id, week_id) -- Prevent duplicate status for the same student in the same week
);
          )'''
    );

    if (db.isOpen) {
      print('Database created and opened successfully');
    }
    if(!db.isOpen) return;
    print('onCreate=================================='); // why this line not tprint

  }

// SELECT
  readData(String sql)async{
    Database? myDb= await db;
    List<Map>  response= await  myDb!.rawQuery(sql);
    return response;
  }
// INSERT
  insertData(String sql)async{
    Database? myDb= await db;
    int  response= await  myDb!.rawInsert(sql);
    return response;
  }
  // UPDATE
  updateData(String sql)async{
    Database? myDb= await db;
    int  response= await  myDb!.rawUpdate(sql);
    return response;
  }
  // DELETE
  deleteData(String sql)async{
    Database? myDb= await db;
    int  response= await  myDb!.rawDelete(sql);
    return response;
  }

}