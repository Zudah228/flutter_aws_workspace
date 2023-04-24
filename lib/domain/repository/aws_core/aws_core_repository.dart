import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_aws_api/shared.dart' as aws_shared;

final awsCoreRepository = Provider<AwsCore>(
  (ref) => AwsCore(
    endpointUrl: 'http://localhost:8000',
    region: 'ap-northeast-1',
    credentials: aws_shared.AwsClientCredentials(
      accessKey: 'AKIA52VJWOTZ2CPRTSYU',
      secretKey: 'DUMMY',
    ),
    client: aws_shared.Client()
  ),
);

@immutable
class AwsCore {
  const AwsCore({
    required this.region,
    required this.endpointUrl,
    required this.credentials,
    required this.client,
  });

  final String region;
  final String endpointUrl;
  final aws_shared.AwsClientCredentials credentials;
  final aws_shared.Client client;
}
