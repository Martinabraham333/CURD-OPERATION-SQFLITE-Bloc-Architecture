import 'package:curd_bloc/Bloc/Event/Student_event.dart';
import 'package:curd_bloc/Bloc/State/Student_state.dart';
import 'package:curd_bloc/Models/model.dart';
import 'package:curd_bloc/Repository/Repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository studentRepository;
  StudentBloc(this.studentRepository) : super(StudentInitial()) {
    on<FetchEvent>(_fetchingStudent);

    on<InsertEvent>(_insertStudent);

    on<DeleteEvent>(_deleteStudent);

    on<UpdateEvent>(_updateStudent);
  }
  _fetchingStudent(FetchEvent event, Emitter<StudentState> emit) async {
    emit(LoadingState());
    try {
      print("Bloc _fetchingStudent");
      final List<Student> fetchingData = await studentRepository.fetchStudent();
      return emit(SuccessState(StudentList: fetchingData));
    } catch (e) {
      return emit(FailureState("Error while fetching Data : $e"));
    }
  }

  _insertStudent(InsertEvent event, Emitter<StudentState> emit) async {
    print("Roll Number= ${event.rollNo}");
    emit(LoadingState());
    try {
      if (event.name == null || event.name.isEmpty) {
        return emit(FailureState("Enter User Name"));
      } else if (event.rollNo == "" ||event.rollNo == null) {
        return emit(FailureState("Invalide Roll Number.Enter Integer Value"));
      } else {
        await studentRepository.addStudent(event.name, event.rollNo);
      }
    } catch (e) {
      return emit(FailureState("Error while Inserting Data : $e"));
    }
  }

  _deleteStudent(DeleteEvent event, Emitter<StudentState> emit) async {
    emit(LoadingState());
    try {
      await studentRepository.deleteStudent(event.id);
    } catch (e) {
      return emit(FailureState("Error while deleting Data : $e"));
    }
  }

  _updateStudent(UpdateEvent event, Emitter<StudentState> emit) async {
    emit(LoadingState());
    try {
      // if (event.name == null || event.name.isEmpty) {
      //   return emit(FailureState("Enter User Name"));
      // } else if (event.rollNo == null || event.rollNo == "") {
      //   return emit(FailureState("Enter roll no"));
      // } else {
      //   final int roll = await int.parse(event.rollNo);

      //   await studentRepository.updateStudent(event.id, event.name, roll);
      // }
      print(event.id);
      print(event.name);
      print(event.rollNo);
      final int roll = await int.parse(event.rollNo);
      await studentRepository.updateStudent(event.id, event.name, roll);
    } catch (e) {
      print("Error while updating Data : $e");
      return emit(FailureState("Error while updating Data : $e"));
    }
  }
}
