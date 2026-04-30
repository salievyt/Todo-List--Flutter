import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:less6_month3/viewmodel/todo_bloc.dart';
import 'package:less6_month3/view/page/todo_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(),
      child: const MaterialApp(home: TodoPage(), ),
    );
  }
}
