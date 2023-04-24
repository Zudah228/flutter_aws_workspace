import 'package:aws_dynamodb_api/dynamodb-2011-12-05.dart';
import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart' as dynamo_db;

typedef DynamoDbAttributes = Map<String, dynamo_db.AttributeValue>;

class AwsDynamoDbOutput<T extends Object?> {
  AwsDynamoDbOutput({required this.items});

  final List<T> items;

  int get count => items.length;

  // factory AwsDynamoDbOutput.fromOutput(dynamo_db.QueryOutput output) => AwsDynamoDbOutput(items: output.items)
}

class AwsDynamoDbQueryOutput {}
