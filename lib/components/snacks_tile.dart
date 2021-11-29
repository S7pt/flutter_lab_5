import 'package:flutter/material.dart';
import 'package:to_do_list/models/snacks_order.dart';

class SnacksTile extends StatelessWidget {
  final Snacks snacks;
  SnacksTile({required this.snacks});

  @override
  Widget build(BuildContext context) {
    if (snacks.snacks != '') {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Card(
          margin: const EdgeInsets.fromLTRB(5, 3, 5, 0),
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.fastfood),
            ),
            title: Text('${snacks.name} wants:'),
            subtitle: Text('${snacks.snacks}'),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
