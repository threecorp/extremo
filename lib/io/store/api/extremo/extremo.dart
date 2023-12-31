import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../interceptor.dart';
import 'extremo_response.dart';

part 'extremo.g.dart';

@riverpod
Dio extremoApiClient(_) {
  final dio = Dio();
  dio.interceptors.add(LoggerInterceptor());
  return dio;
}

// curl 'localhost:8888/api/public/v1/users?page=1&page_size=29'
@RestApi(baseUrl: 'http://localhost:8888/api/public/v1/')
abstract class ExtremoApi {
  factory ExtremoApi(Dio dio, {String baseUrl}) = _ExtremoApi;

  @GET('/users/{id}')
  Future<ExtremoGetResponse> getUser(@Path('id') int id);

  @GET('/users')
  Future<ExtremoListResponse> listUsers(
    @Query('offset') int offset,
    @Query('limit') int limit,
  );

  // @GET("/extremo-species/{id}")
  // Future<ExtremoSpeciesResponse> getExtremoSpecies(@Path("id") int id);
}

@riverpod
ExtremoApi extremoApi(ExtremoApiRef ref) =>
    ExtremoApi(ref.read(extremoApiClientProvider));
// Same above
// final extremoApi = Provider<ExtremoApi>((ref) =>
//  ExtremoApi(ref.read(extremoApiClientProvider)));
