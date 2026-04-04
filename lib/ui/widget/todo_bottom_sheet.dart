import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:less6_month3/cubit/todo_cubit.dart';
import 'package:less6_month3/data/local/app_database.dart';

class TodoBottomSheet {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  TodoBottomSheet(context, {TodoModelData? todo}) {
    if (todo != null) {
      titleController.text = todo.title;
      descController.text = todo.description;
    }
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 24),
              Text(
                todo == null ? 'Добавить задачу' : 'Редактировать',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              SizedBox(height: 48),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Название",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 18),
              TextField(
                controller: descController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Описания",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (todo == null) {
                      context.read<TodoCubit>().addTodo(
                        titleController.text,
                        descController.text,
                      );
                    } else {
                      context.read<TodoCubit>().editTodo(
                        TodoModelData(
                          id: todo.id,
                          title: titleController.text,
                          description: descController.text,
                          done: todo.done,
                        ),
                      );
                    }
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Color(0xFF5566FF)),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  child: Text(
                    todo == null ? 'Добавить задачу' : 'Редактировать',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
