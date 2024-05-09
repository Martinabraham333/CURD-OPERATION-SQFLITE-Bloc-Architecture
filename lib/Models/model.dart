class Student {
  final int id;
  final String name;
  final int rollNo;
  Student(
    this.id,
    this.name,
    this.rollNo, 
  );

  static Student fromMap(Map<String, dynamic> map) {
    return Student(map['id'],map['name'], map['roll_no']);
  }
}
