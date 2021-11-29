import 'dart:async';

import 'package:to_do_list/services/auth.dart';
import 'package:tuple/tuple.dart';

enum AuthType { login, register, signOut }

class UserAuthBloc {
  final _eventSignOutController = StreamController<AuthType>();
  Stream<AuthType> get eventStream => _eventSignOutController.stream;
  Sink<AuthType> get eventSink => _eventSignOutController.sink;

  UserAuthBloc() {
    eventStream.listen((AuthType event) {
      if (event == AuthType.signOut) {
        AuthService().signOut();
      }
    });
  }

  void dispose() {
    _eventSignOutController.close();
  }
}
