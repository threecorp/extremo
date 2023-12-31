import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// This interceptor is used to show request and response logs
class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(printer: SimplePrinter(printTime: true));

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';

    logger.e('[ERROR]\t'
        'method:${options.method}\t'
        'path:$requestPath\t'
        'error:${err.error}\t'
        'message: ${err.message}');

    handler.next(err); // Continue with the Error
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';

    logger.d('[REQUEST]\tmethod:${options.method}\tpath:$requestPath');

    handler.next(options); // Continue with the Request
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final options = response.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';

    logger.d('[RESPONSE]\t'
        'method:${options.method}\t'
        'path:$requestPath\t'
        'code:${response.statusCode}\t'
        'message:${response.statusMessage}\t'
        // 'headers:${response.headers}\t'
        'length:${response.toString().length}');

    handler.next(response); // Continue with the Response
  }
}
