import 'dart:ffi';

abstract class StudentEvent {}

class InsertEvent extends StudentEvent {
  final String name;
  final int? rollNo;

  InsertEvent({required this.name, required this.rollNo});
}

class FetchEvent extends StudentEvent {}

class DeleteEvent extends StudentEvent {
  final int id;
  DeleteEvent({required this.id});
}

class UpdateEvent extends StudentEvent {
  final String name;
  final String rollNo;
  final int id;

  UpdateEvent({required this.name, required this.rollNo, required this.id});
}
