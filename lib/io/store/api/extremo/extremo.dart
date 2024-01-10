import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../interceptor.dart';
import 'extremo_response.dart';

part 'extremo.g.dart';

@riverpod
Dio extremoApiClient(ExtremoApiClientRef ref) {
  final dio = Dio();
  dio.interceptors.add(LoggerInterceptor());
  return dio;
}

@RestApi(baseUrl: 'http://localhost:8888/api/mypage/v1')
abstract class ExtremoMypageApi {
  factory ExtremoMypageApi(Dio dio, {String baseUrl}) = _ExtremoMypageApi;

  @GET('/artifacts/{id}')
  Future<ExtremoGetResponse<ExtremoArtifact>> getArtifact(@Path('id') int id);

  @GET('/artifacts')
  Future<ExtremoListResponse<ExtremoArtifact>> listArtifacts(
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  // @GET("/extremo-species/{id}")
  // Future<ExtremoSpeciesResponse> getExtremoSpecies(@Path("id") int id);
}

@RestApi(baseUrl: 'http://localhost:8888/api/public/v1')
abstract class ExtremoPublicApi {
  factory ExtremoPublicApi(Dio dio, {String baseUrl}) = _ExtremoPublicApi;

  @GET('/users/{id}')
  Future<ExtremoGetResponse<ExtremoUser>> getUser(@Path('id') int id);

  @GET('/users')
  Future<ExtremoListResponse<ExtremoUser>> listUsers(
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  // @GET("/extremo-species/{id}")
  // Future<ExtremoSpeciesResponse> getExtremoSpecies(@Path("id") int id);
}

@riverpod
ExtremoMypageApi extremoMypageApi(ExtremoMypageApiRef ref) =>
    ExtremoMypageApi(ref.read(extremoApiClientProvider));

@riverpod
ExtremoPublicApi extremoPublicApi(ExtremoPublicApiRef ref) =>
    ExtremoPublicApi(ref.read(extremoApiClientProvider));
// Same above
// final extremoApi = Provider<ExtremoApi>((ref) =>
//  ExtremoApi(ref.read(extremoApiClientProvider)));
