import 'package:librarydata/studen_info.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  static late Database database;
 late StudentInfo studentInfo;

 static final String tableName = "student";

 static Future createDatabase() async{
  String dbPath = await getDatabasesPath();
  String path = join(dbPath, "expense.db");

  database = await openDatabase(path, version: 3,
  onCreate: (db, version) async {
    await db.execute(
        "create table $tableName(name text primary key,address text not null,mobileNo text,date text)");
    print("create table");
  }
  );
}
  static Future addExpense(StudentInfo info) async {
    await database.rawInsert("insert or replace into $tableName values(?,?,?,?)",
        [info.name, info.address, info.mobileNo, info.date]
        );
    print("data inserted");
  }
  static Future<List<StudentInfo>> getStudent()async{

      List<StudentInfo> studentInfoList = [];
      List<Map<String, dynamic>> listStudent = await database.rawQuery(
          "select * from $tableName");
      for (int i = 0; i < listStudent.length; i++) {
        StudentInfo studentInfo = StudentInfo.fromMap(listStudent[i]);
        studentInfoList.add(studentInfo);
      }
      return studentInfoList;

  }
   static Future delete(String? name)async{
  await database.rawDelete("delete from student where name=?",[name]);
  }

}