// import 'package:extremodart/extremo/api/public/users/v1/user_service.pb.dart';
// import 'package:extremodart/extremo/msg/db/v1/enum.pb.dart';
// import 'package:protobuf/protobuf.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:extremodart/extremo/api/mypage/artifacts/v1/artifact_service.pbgrpc.dart'
    as pbartifact;
import 'package:extremodart/extremo/api/public/users/v1/user_service.pbgrpc.dart'
    as pbuser;
import 'package:grpc/grpc.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../interceptor.dart';

import 'extremo_request.dart';
import 'extremo_response.dart';

part 'extremo.g.dart';

@riverpod
Dio apiClient(ApiClientRef ref) {
  final dio = Dio();
  dio.interceptors.add(LoggerInterceptor());
  return dio;
}

@RestApi(baseUrl: 'http://localhost:8888/api/mypage/v1')
abstract class MypageApi {
  factory MypageApi(Dio dio, {String baseUrl}) = _MypageApi;

  @GET('/artifacts/{id}')
  Future<GetResponse<ArtifactResponse>> getArtifact(@Path('id') int id);

  @GET('/artifacts')
  Future<ListResponse<ArtifactResponse>> listArtifacts(
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  @POST('/artifacts')
  @Headers({'Content-Type': 'application/json'})
  Future<GetResponse<ArtifactResponse>> createArtifact(
    @Body() ArtifactRequest request,
  );
}

@RestApi(baseUrl: 'http://localhost:8888/api/public/v1')
abstract class PublicApi {
  factory PublicApi(Dio dio, {String baseUrl}) = _PublicApi;

  @GET('/users/{id}')
  Future<GetResponse<UserResponse>> getUser(@Path('id') int id);

  @GET('/users')
  Future<ListResponse<UserResponse>> listUsers(
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  // @GET("/-species/{id}")
  // Future<SpeciesResponse> getSpecies(@Path("id") int id);
}

@riverpod
MypageApi mypageApi(MypageApiRef ref) => MypageApi(ref.read(apiClientProvider));

@riverpod
PublicApi publicApi(PublicApiRef ref) => PublicApi(ref.read(apiClientProvider));

@riverpod
pbuser.UserServiceClient publicUserServiceClient(
  PublicUserServiceClientRef ref,
) {
  final channel = ClientChannel(
    'localhost',
    port: 50100,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  return pbuser.UserServiceClient(channel);
}

@riverpod
pbartifact.ArtifactServiceClient mypageArtifactServiceClient(
  MypageArtifactServiceClientRef ref,
) {
  final channel = ClientChannel(
    'localhost',
    port: 50100,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  return pbartifact.ArtifactServiceClient(channel);
}
