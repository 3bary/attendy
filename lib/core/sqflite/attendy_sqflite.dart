import 'package:attendy/core/models/student.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../features/home/data/models/section.dart';
import '../../features/week/data/models/week.dart';

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

  Future<int> insertSection(String name, String description) async {
    Database? db = await attendySqflite;
    int response = await db!.insert(
      'section',
      {
        'name': name,
        'description': description,
      },
    );
    return response;
  }

  Future<List<Section>> getSections() async {
    Database? db = await attendySqflite;
    List<Map<String, dynamic>> rows = await db!.query('section');
    return rows.map((e) => Section.fromMap(e)).toList();
  }

  Future<int> insertWeek(int sectionId, int weekNumber) async {
    Database? db = await attendySqflite;
    int response = await db!.insert(
      'week',
      {
        'section_id': sectionId,
        'week_number': weekNumber,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore, // Prevent duplicate entries
    );
    return response;
  }

  Future<List<Week>> getWeeks(int sectionId) async {
    Database? db = await attendySqflite;
    List<Map<String, dynamic>> rows = await db!.query(
      'week',
      where: 'section_id = ?',
      whereArgs: [sectionId],
    );
    return rows.map((e) => Week.fromMap(e)).toList();

  }

  // Fetch students with their attendance status for a specific week
  Future<List<Map<String, dynamic>>> getSectionStudentsWithStatus(
      int sectionID, int weekID) async {
    Database? db = await attendySqflite;
    try {
      // Query to get students in the section along with their attendance status for the given week
      final List<Map<String, dynamic>> studentsWithStatus = await db!.rawQuery('''
    SELECT 
      s.student_id, 
      s.name, 
      s.level, 
      a.status -- Attendance status
    FROM student s
    JOIN enrollment e ON s.student_id = e.student_id
    LEFT JOIN attendance a ON e.enrollment_id = a.enrollment_id AND a.week_id = ?
    WHERE e.section_id = ?
    ''', [weekID, sectionID]); // Pass weekID and sectionID as arguments

      return studentsWithStatus;
    } catch (e) {
      // Handle any error during the database operation
      throw Exception('Failed to fetch students with attendance status for section $sectionID and week $weekID: $e');
    }
  }



  // Update a student's attendance status
  Future<void> updateAttendanceStatus(
      int weekId, int studentId, String status) async {
    Database? db = await attendySqflite;

    // Get the enrollment ID for the student
    final enrollment = await db!.query(
      'enrollment',
      where: 'student_id = ?',
      whereArgs: [studentId],
      limit: 1,
    );
    if (enrollment.isEmpty) {
      throw Exception('Student not enrolled in any section.');
    }
    final enrollmentId = enrollment.first['enrollment_id'];

    // Check if the attendance record already exists
    final existingAttendance = await db.query(
      'attendance',
      where: 'enrollment_id = ? AND week_id = ?',
      whereArgs: [enrollmentId, weekId],
      limit: 1,
    );

    if (existingAttendance.isNotEmpty) {
      // Update the existing attendance record
      await db.update(
        'attendance',
        {'status': status},
        where: 'enrollment_id = ? AND week_id = ?',
        whereArgs: [enrollmentId, weekId],
      );
    } else {
      // Insert a new attendance record
      await db.insert(
        'attendance',
        {
          'enrollment_id': enrollmentId,
          'week_id': weekId,
          'status': status,
        },
      );
    }

    // Debug: Check and print the updated status
    final updatedAttendance = await db.query(
      'attendance',
      where: 'enrollment_id = ? AND week_id = ?',
      whereArgs: [enrollmentId, weekId],
      limit: 1,
    );

    if (updatedAttendance.isNotEmpty) {
      print('Updated attendance record: $updatedAttendance');
    } else {
      print('Failed to update attendance.');
    }
  }



  Future<int> insertStudent(String name, String level) async {
    Database? db = await attendySqflite;
    try {
      // Insert student into the database
      return await db!.insert(
        'student',
        {
          'name': name,
          'level': level,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore, // Prevent duplicate records
      );
    } catch (e) {
      throw Exception('Failed to insert student: $e');
    }
  }

  Future<int> insertEnrollment(int studentId, int sectionId) async {
    Database? db = await attendySqflite;
    return await db!.insert(
      'enrollment',
      {
        'student_id': studentId,
        'section_id': sectionId,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore, // Prevent duplicates
    );
  }

  Future<List<Student>> getAllStudents() async {
    Database? db = await attendySqflite;
    final List<Map<String, dynamic>> rows = await db!.query('student');
    return rows.map((map) => Student.fromMap(map)).toList();
  }

}

