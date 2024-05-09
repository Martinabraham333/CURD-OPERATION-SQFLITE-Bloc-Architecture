

import 'package:curd_bloc/Models/model.dart';

abstract class StudentState {}

class StudentInitial extends StudentState {}

class SuccessState extends StudentState {

  final List<Student> StudentList;

  SuccessState({required this.StudentList});
}

class FailureState extends StudentState {
  final String error;
  FailureState(this.error);
}

class LoadingState extends StudentState {}
