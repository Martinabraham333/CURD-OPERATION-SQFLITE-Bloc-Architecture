
import 'package:curd_bloc/Bloc/Bloc/Student_bloc.dart';
import 'package:curd_bloc/Bloc/Event/Student_event.dart';
import 'package:curd_bloc/Models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showUpdateDialog(
    BuildContext context,
    TextEditingController _updateNameController,
    TextEditingController _updateollNoController,
    Student Data) {
  print(Data.id.toString());
  _updateNameController.text = Data.name;
  _updateollNoController.text = Data.rollNo.toString();
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update"),
          content: SingleChildScrollView(
            child: Container(
              height: 150,
              child: Column(
                children: [
                  TextField(
                    controller: _updateNameController,
                    decoration: InputDecoration(hintText: "Enter Name"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _updateollNoController,
                    decoration: InputDecoration(hintText: "Enter Roll No"),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () async {
                      print("Screen roll ${_updateollNoController.text}");
                      context.read<StudentBloc>().add(await UpdateEvent(
                          name: _updateNameController.text,
                          rollNo: _updateollNoController.text,
                          id: Data.id));
                      context.read<StudentBloc>().add(await FetchEvent());
                      Navigator.pop(context);
                    },
                    child: Text("Update")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"))
              ],
            )
          ],
        );
      });
}
