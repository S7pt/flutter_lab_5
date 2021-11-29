import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/components/snacks_tile.dart';
import 'package:to_do_list/models/snacks_order.dart';
import 'package:to_do_list/services/auth.dart';

class SnacksList extends StatefulWidget {
  const SnacksList({Key? key}) : super(key: key);

  @override
  _SnacksListState createState() => _SnacksListState();
}

class _SnacksListState extends State<SnacksList> {
  @override
  Widget build(BuildContext context) {
    final snacks = Provider.of<List<Snacks>?>(context);

    return ListView.builder(
        itemCount: snacks?.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SnacksTile(snacks: snacks![index]);
        });
  }
}
