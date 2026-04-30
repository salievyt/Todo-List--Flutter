abstract class TodoEvent {}

class TodoAddEvent extends TodoEvent {
  final String title;
  final String description;
  TodoAddEvent(this.title, this.description);
}

class TodoRemoveEvent extends TodoEvent {
  final int id;
  TodoRemoveEvent(this.id);
}

class TodoUpdateEvent extends TodoEvent {
  final String title;
  final String description;
  final int id;
  TodoUpdateEvent(this.title, this.description, this.id);
}

class TodoDoneEvent extends TodoEvent {}