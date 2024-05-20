// import 'package:extremodart/extremo/api/public/users/v1/user_service.pb.dart';
// import 'package:extremodart/extremo/msg/db/v1/enum.pb.dart';
// import 'package:protobuf/protobuf.dart';
import 'package:collection/collection.dart';
import 'package:extremodart/extremo/api/mypage/artifacts/v1/artifact_service.pbgrpc.dart';
import 'package:extremodart/extremo/api/mypage/messages/v1/message_service.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:extremo/io/store/api/interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mypage.g.dart';

@riverpod
ArtifactServiceClient mypageArtifactServiceClient(
  MypageArtifactServiceClientRef ref,
) {
  final channel = ClientChannel(
    'localhost', // TODO(Environment): Change a value for each an environment.
    port: 50100,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  return ArtifactServiceClient(
    channel,
    interceptors: [GrpcLoggerInterceptor.instance],
  );
}

@riverpod
MessageServiceClient mypageMessageServiceClient(
  MypageMessageServiceClientRef ref,
) {
  final channel = ClientChannel(
    'localhost', // TODO(Environment): Change a value for each an environment.
    port: 50100,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  return MessageServiceClient(
    channel,
    interceptors: [GrpcLoggerInterceptor.instance],
  );
}
