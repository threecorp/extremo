// import 'package:extremodart/extremo/api/public/users/v1/user_service.pb.dart';
// import 'package:extremodart/extremo/msg/db/v1/enum.pb.dart';
// import 'package:protobuf/protobuf.dart';
import 'package:collection/collection.dart';
import 'package:extremodart/extremo/api/mypage/artifacts/v1/artifact_service.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mypage.g.dart';

@riverpod
ArtifactServiceClient mypageArtifactServiceClient(
  MypageArtifactServiceClientRef ref,
) {
  final channel = ClientChannel(
    'localhost',
    port: 50100,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  return ArtifactServiceClient(channel);
}