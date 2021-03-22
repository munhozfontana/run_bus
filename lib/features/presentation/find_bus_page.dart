import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:run_bus/features/presentation/find_bus_controller.dart';

class FindBusPage extends StatelessWidget {
  const FindBusPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Consumer<FindBusController>(
            builder: (context, value, child) {
              return Text('6');
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<FindBusController>(context, listen: false)..run();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
