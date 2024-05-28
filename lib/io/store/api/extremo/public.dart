// import 'package:extremodart/extremo/api/public/users/v1/user_service.pb.dart';
// import 'package:extremodart/extremo/msg/db/v1/enum.pb.dart';
// import 'package:protobuf/protobuf.dart';
import 'package:collection/collection.dart';
import 'package:extremodart/extremo/api/public/users/v1/user_service.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../interceptors/grpc_auth.dart';
import '../interceptors/grpc_logger.dart';

part 'public.g.dart';

@riverpod
UserServiceClient publicUserServiceClient(
  PublicUserServiceClientRef ref,
) {
  final channel = ClientChannel(
    'localhost', // TODO(Environment): Change a value for each an environment.
    port: 50100,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  return UserServiceClient(
    channel,
    interceptors: [GrpcAuthInterceptor(ref), GrpcLoggerInterceptor.instance],
  );
}
