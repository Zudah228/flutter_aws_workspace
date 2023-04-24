import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'amplify_gen/models/ModelProvider.dart';
import 'amplifyconfiguration.dart';
import 'pages/home_page.dart';

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

  runApp(const ProviderScope(child: MyApp()));
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
      home: const HomePage(),
    );
  }
}
