// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extremo.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ExtremoApi implements ExtremoApi {
  _ExtremoApi(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://localhost:8888/api/public/v1/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ExtremoGetResponse> getUser(int id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ExtremoGetResponse>(Options(
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
    final value = ExtremoGetResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ExtremoListResponse> listUsers(
    int offset,
    int limit,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'offset': offset,
      r'limit': limit,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ExtremoListResponse>(Options(
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
    final value = ExtremoListResponse.fromJson(_result.data!);
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
String _$extremoApiHash() => r'ed2fc9cfc9883192ccf4960160d184f105a876ab';

/// See also [extremoApi].
@ProviderFor(extremoApi)
final extremoApiProvider = AutoDisposeProvider<ExtremoApi>.internal(
  extremoApi,
  name: r'extremoApiProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$extremoApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ExtremoApiRef = AutoDisposeProviderRef<ExtremoApi>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
