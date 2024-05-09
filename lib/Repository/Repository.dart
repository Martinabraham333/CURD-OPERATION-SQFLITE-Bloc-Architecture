
import 'package:curd_bloc/Database/database.dart';
import 'package:curd_bloc/Models/model.dart';

class StudentRepository {
   Future addStudent(name,rollno) async {
    final resp = await db.rawInsert(
        'INSERT INTO STUDENT(name,roll_no) VALUES (?,?)',
        [name, rollno]);
    print(resp);
    
  }

   Future fetchStudent() async {
    final resp = await db.rawQuery('SELECT * FROM STUDENT');
    print(resp);
    final List<Student> data = resp.map((item) {
      return Student.fromMap(item);
    }).toList();
    return data;
  }

  Future deleteStudent(id) async {
    final resp = await db.rawDelete(
        'DELETE FROM STUDENT WHERE id = ?', [id]);
    print(resp);
    
  }

Future updateStudent(id,name,rollno) async {
    final resp = await db.rawUpdate(
        'UPDATE STUDENT SET name = ?,roll_no = ? where id = ?',
        [name, rollno,id]);
    print(resp);
    
  }
}
