import 'dart:async';
import 'package:to_do_list/services/database.dart';

class UserUpdateBloc {
  final _eventController = StreamController<List<String>>();
  Stream<List<String>> get eventStream => _eventController.stream;
  Sink<List<String>> get eventSink => _eventController.sink;

  UserUpdateBloc() {
    eventStream.listen((List<String> event) {
      DatabaseService(uid: event[0]).updatePersonData(event[1], event[2]);
    });
  }
  void dispose() {
    _eventController.close();
  }
}
