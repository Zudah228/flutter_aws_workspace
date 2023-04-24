import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/music/music.dart';
import '../../domain/repository/aws_dynamo_db/aws_dynamo_db_repository.dart';

class AwsDynamoDbPage extends ConsumerStatefulWidget {
  const AwsDynamoDbPage({super.key});

  @override
  ConsumerState<AwsDynamoDbPage> createState() => _AwsDynamoDbPageState();
}

class _AwsDynamoDbPageState extends ConsumerState<AwsDynamoDbPage> {
  @override
  void initState() {
    ref
        .read(awsDynamoDbRepositoryProvider)
        .getItem(Music.tableName, keyName: 'id', keyValue: 'aaaaaa');
    ref.read(awsDynamoDbRepositoryProvider).query(Music.tableName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
