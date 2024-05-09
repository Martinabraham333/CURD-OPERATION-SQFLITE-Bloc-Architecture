
import 'package:curd_bloc/Bloc/Bloc/Student_bloc.dart';
import 'package:curd_bloc/Database/database.dart';
import 'package:curd_bloc/Repository/Repository.dart';
import 'package:curd_bloc/UI/Screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => StudentRepository(),
      child: BlocProvider(
        create: (context) => StudentBloc(context.read<StudentRepository>()),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: HomePage()),
      ),
    );
  }
}
