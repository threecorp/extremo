// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extremo.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ExtremoMypageApi implements ExtremoMypageApi {
  _ExtremoMypageApi(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://localhost:8888/api/mypage/v1/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ExtremoGetResponse<ExtremoArtifact>> getArtifact(int id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ExtremoGetResponse<ExtremoArtifact>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/artifacts/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ExtremoGetResponse<ExtremoArtifact>.fromJson(
      _result.data!,
      (json) => ExtremoArtifact.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ExtremoListResponse<ExtremoArtifact>> listArtifacts(
    int page,
    int pageSize,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'page_size': pageSize,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ExtremoListResponse<ExtremoArtifact>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/artifacts',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ExtremoListResponse<ExtremoArtifact>.fromJson(
      _result.data!,
      (json) => ExtremoArtifact.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ExtremoPublicApi implements ExtremoPublicApi {
  _ExtremoPublicApi(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://localhost:8888/api/public/v1/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ExtremoGetResponse<ExtremoUser>> getUser(int id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ExtremoGetResponse<ExtremoUser>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/users/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ExtremoGetResponse<ExtremoUser>.fromJson(
      _result.data!,
      (json) => ExtremoUser.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ExtremoListResponse<ExtremoUser>> listUsers(
    int page,
    int pageSize,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'page_size': pageSize,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ExtremoListResponse<ExtremoUser>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/users',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ExtremoListResponse<ExtremoUser>.fromJson(
      _result.data!,
      (json) => ExtremoUser.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$extremoApiClientHash() => r'f023071cd97c90d18bf3eee4449600ee73fa56a4';

/// See also [extremoApiClient].
@ProviderFor(extremoApiClient)
final extremoApiClientProvider = AutoDisposeProvider<Dio>.internal(
  extremoApiClient,
  name: r'extremoApiClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$extremoApiClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ExtremoApiClientRef = AutoDisposeProviderRef<Dio>;
String _$extremoMypageApiHash() => r'8b831fa80a100cc5e7bd8b1633714ec57e8ba401';

/// See also [extremoMypageApi].
@ProviderFor(extremoMypageApi)
final extremoMypageApiProvider = AutoDisposeProvider<ExtremoMypageApi>.internal(
  extremoMypageApi,
  name: r'extremoMypageApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$extremoMypageApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ExtremoMypageApiRef = AutoDisposeProviderRef<ExtremoMypageApi>;
String _$extremoPublicApiHash() => r'13133a4d8fba483157853b764eee163cc9064837';

/// See also [extremoPublicApi].
@ProviderFor(extremoPublicApi)
final extremoPublicApiProvider = AutoDisposeProvider<ExtremoPublicApi>.internal(
  extremoPublicApi,
  name: r'extremoPublicApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$extremoPublicApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ExtremoPublicApiRef = AutoDisposeProviderRef<ExtremoPublicApi>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
