import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// This interceptor is used to show request and response logs
class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(printer: SimplePrinter(printTime: true));

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;

    logger.e('\t[ERROR]\t\t'
        'method:${options.method}\t'
        'uri:${options.uri}\t'
        'code:${err.response?.statusCode}\t'
        'message: ${err.message}\t'
        'length:${err.response?.toString().length}');

    handler.next(err); // Continue with the Error
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.d('\t[REQUEST]\t'
        'method:${options.method}\t'
        'uri:${options.uri}');

    handler.next(options); // Continue with the Request
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final options = response.requestOptions;

    logger.d('\t[RESPONSE]\t'
        'method:${options.method}\t'
        'uri:${options.uri}\t'
        'code:${response.statusCode}\t'
        'message:${response.statusMessage}\t'
        // 'headers:${response.headers}\t'
        'length:${response.toString().length}');

    handler.next(response); // Continue with the Response
  }
}
