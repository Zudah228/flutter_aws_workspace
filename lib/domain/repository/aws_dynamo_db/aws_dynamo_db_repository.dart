import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart' as dynamo_db;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../aws_core/aws_core_repository.dart';

final awsDynamoDbRepositoryProvider =
    Provider((ref) => AwsDynamoDbRepository(ref.watch(awsCoreRepository)));

class AwsDynamoDbRepository {
  AwsDynamoDbRepository(AwsCore core)
      : _db = dynamo_db.DynamoDB(
          region: core.region,
          credentials: core.credentials,
          endpointUrl: core.endpointUrl,
          client: core.client,
        );

  final dynamo_db.DynamoDB _db;

  Future<dynamic> getItem<T extends Object?>(
    String tableName, {
    required String keyName,
    required String keyValue,
  }) async {
    try {
      final output = await _db.getItem(
        key: {keyName: dynamo_db.AttributeValue(s: keyValue)},
        tableName: tableName,
      );

      return output;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamo_db.QueryOutput> query<T extends Object>(
    String tableName,
  ) async {
    try {
      final output = await _db.query(
        tableName: tableName,
        keyConditions: {
          'id': dynamo_db.Condition(
            comparisonOperator: dynamo_db.ComparisonOperator.eq,
            attributeValueList: [dynamo_db.AttributeValue(s: 'aaaaaa')],
          )
        },
      );

      print(output.items);
      return output;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
