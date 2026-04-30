import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:less6_month3/viewmodel/todo_event.dart';
import 'package:less6_month3/viewmodel/todo_state.dart';
import 'package:less6_month3/data/local/app_database.dart';
import 'package:less6_month3/data/source/todo_local_datasource.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc()
    : super(TodoState([])) {
    appDatabase = AppDatabase();
    datasource = TodoLocalDatasource(appDatabase);
    on<TodoAddEvent>(_todoAdd);
    on<TodoUpdateEvent>(_todoUpdate);
    on<TodoDoneEvent>(_todoDone);
    on<TodoRemoveEvent>(_todoARemove);
  }

  late AppDatabase appDatabase;
  late TodoLocalDatasource datasource;

  Future<void> _emitTodos(Emitter<TodoState> emit) async {
    try {
      final todos = await datasource.getAll();
      if (todos.isEmpty) {
        print("error: Пусто");
      } else {
        emit(TodoState(todos));
      }
    } catch (e) {
      print("error: $e");
    }
  }

  void _todoDone(TodoDoneEvent event, Emitter<TodoState> emit) async {
    await _emitTodos(emit);
  }

  void _todoAdd(TodoAddEvent event, Emitter<TodoState> emit) async {
    try {
      await datasource.addTodo(event.title, event.description);
      await _emitTodos(emit);
    } catch (e) {
      print("error: $e");
    }
  }

  void _todoUpdate(TodoUpdateEvent event, Emitter<TodoState> emit) async {
    try {
      await datasource.editTodo(event.title, event.description, event.id);
      await _emitTodos(emit);
    } catch (e) {
      print("error: $e");
    }
  }

  void _todoARemove(TodoRemoveEvent event, Emitter<TodoState> emit) async {
    try {
      await datasource.delete(event.id);
      await _emitTodos(emit);
    } catch (e) {
      print("error: $e");
    }
  }
}
