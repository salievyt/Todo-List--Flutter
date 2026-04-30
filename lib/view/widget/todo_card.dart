import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:less6_month3/viewmodel/todo_bloc.dart';
import 'package:less6_month3/data/local/app_database.dart';
import 'package:less6_month3/view/widget/todo_bottom_sheet.dart';
import 'package:less6_month3/viewmodel/todo_event.dart';

class TodoCard extends StatefulWidget {
  const TodoCard({super.key, required this.todoModel});
  final TodoModelData todoModel;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool done = false;

  @override
  void initState() {
    super.initState();
    done = widget.todoModel.done;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: done ? Colors.grey : Color(0xFF5566FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.todoModel.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    decoration: done ? TextDecoration.lineThrough : null,
                  ),
                ),
                Spacer(),
                Checkbox(
                  value: done,
                  onChanged: (value) {
                    setState(() => done = value!);
                    context.read<TodoBloc>().add(TodoDoneEvent());
                  },
                ),
                IconButton(
                  onPressed: (){
                    TodoBottomSheet(context, todo: widget.todoModel);
                  },
                  icon: Icon(Icons.edit, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Внимание"),
                          content: Text("Вы действительно хотите удалить?"),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.redAccent),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              child: Text(
                                "Отменить",
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context.read<TodoBloc>().add(TodoRemoveEvent(widget.todoModel.id));
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  Color(0xFF5566FF),
                                ),
                                foregroundColor: WidgetStateProperty.all(
                                  Colors.white,
                                ),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              child: Text("Удалить"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.delete, color: Colors.white),
                ),
              ],
            ),
            Text(
              widget.todoModel.description,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
