import 'package:flutter/material.dart';

void main() => runApp(const RepoViewer());

class RepoViewer extends StatelessWidget {
  const RepoViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RepoViewer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('Repo Viewer')),
        body: const Center(
          child: Text('Hello GitHub'),
        ),
      ),
    );
  }
}
