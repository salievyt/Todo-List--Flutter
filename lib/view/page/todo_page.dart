import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:less6_month3/viewmodel/todo_bloc.dart';
import 'package:less6_month3/viewmodel/todo_state.dart';
import 'package:less6_month3/view/widget/todo_bottom_sheet.dart';
import 'package:less6_month3/view/widget/todo_card.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos'), centerTitle: false),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    return TodoCard(todoModel: state.todos[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TodoBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
