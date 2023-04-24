import 'package:flutter/material.dart';

import 'amplify_dynamo_db/amplify_dynamo_db_page.dart';
import 'aws_dynamo_db/aws_dynamo_db_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AmplifyDynamoDbPage(),
                  ),
                );
              },
              child: const Text('Amplify'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AwsDynamoDbPage(),
                  ),
                );
              },
              child: const Text('AWS'),
            )
          ],
        ),
      ),
    );
  }
}
