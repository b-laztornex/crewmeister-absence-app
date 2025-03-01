import 'package:flutter/material.dart';

class AbsencesListPage extends StatelessWidget {
  const AbsencesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Absence List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('DEMO TODOS')],
        ),
      ),
    );
  }
}
