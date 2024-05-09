import 'package:curd_bloc/Bloc/Bloc/Student_bloc.dart';
import 'package:curd_bloc/Bloc/Event/Student_event.dart';
import 'package:curd_bloc/Bloc/State/Student_state.dart';
import 'package:curd_bloc/Models/model.dart';
import 'package:curd_bloc/UI/Widgets/alertBox.dart';
import 'package:curd_bloc/UI/Widgets/showUpdateDialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<StudentBloc>().add(FetchEvent());
    TextEditingController _nameController = TextEditingController();
    TextEditingController _rollNoController = TextEditingController();
    TextEditingController _updateNameController = TextEditingController();
    TextEditingController _updateollNoController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "CURD OPERATION",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: 300,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(hintText: "Name"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 300,
              child: TextField(
                controller: _rollNoController,
                decoration: InputDecoration(hintText: "Roll No"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                    onPressed: () async {
                      final rollNo = await int.tryParse(_rollNoController.text);
                      context.read<StudentBloc>().add(await InsertEvent(
                          name: _nameController.text, rollNo: rollNo));
                      context.read<StudentBloc>().add(await FetchEvent());
                      _rollNoController.clear();
                      _nameController.clear();
                    },
                    child: Text(
                      "Insert",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ))),
            SizedBox(
              height: 20,
            ),
            BlocConsumer<StudentBloc, StudentState>(
              listener: (context, state) {
                if (state is FailureState) {
                 
                  alertBox(context, state.error);
                }
              },
              builder: (context, state) {
                if (state is SuccessState) {
                  final List<Student> Data = state.StudentList;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: Data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                width: 500,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 126, 42, 235),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 200,
                                            child: Text(
                                              Data[index].name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                            child: Text(
                                              Data[index].rollNo.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () async {
                                          return showUpdateDialog(
                                              context,
                                              _updateNameController,
                                              _updateollNoController,
                                              Data[index]);
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          color:
                                              Color.fromARGB(255, 6, 185, 255),
                                          size: 30,
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                        onTap: () async {
                                          context.read<StudentBloc>().add(
                                              await DeleteEvent(
                                                  id: Data[index].id));
                                          context
                                              .read<StudentBloc>()
                                              .add(await FetchEvent());
                                        },
                                        child: Icon(
                                          Icons.delete_forever_sharp,
                                          color: Colors.red,
                                          size: 30,
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          );
                        }),
                  );
                } else if (state is LoadingState) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.red,
                  ));
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
