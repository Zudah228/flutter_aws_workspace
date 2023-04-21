import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aws_workspace/amplifyconfiguration.dart';
import 'package:flutter_aws_workspace/amplify_gen/models/ModelProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Amplify
  try {
    final amplifyAPI = AmplifyAPI(modelProvider: ModelProvider.instance);
    final amplifyDataStore =
        AmplifyDataStore(modelProvider: ModelProvider.instance);
    await Amplify.addPlugins([amplifyAPI, amplifyDataStore]);
    await Amplify.configure(amplifyconfig);
  } catch (e) {
    debugPrint(e.toString());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AWS Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormFieldState> _formFieldKey = GlobalKey<FormFieldState>();
  List<Todo> _todos = [];

  Future<void> _fetch() async {
    final items = await Amplify.DataStore.query(Todo.classType);
    if (items.any((e) => e.createdAt == null)) {
      _fetch();
    } else {
      setState(() {
        _todos = [...items];
      });
    }
  }

  Future<void> _save() async {
    try {
      if (!_formFieldKey.currentState!.validate()) return;
      final name = _formFieldKey.currentState!.value;

      await Amplify.DataStore.save<Todo>(Todo(name: name, isComplete: false));
      _formFieldKey.currentState!.reset();
      _fetch();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    key: _formFieldKey,
                    validator: (value) => value!.isEmpty ? 'required' : null,
                  )),
                  const SizedBox(width: 8),
                  ElevatedButton(onPressed: _save, child: const Icon(Icons.add))
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final todo = _todos[index];
              return ListTile(
                title: Text(todo.name ?? ''),
                subtitle: Text(todo.createdAt?.format() ?? ''),
              );
            }, childCount: _todos.length),
          )
        ]
            .map((e) => SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12), sliver: e))
            .toList(),
      ),
    );
  }
}
