import 'package:dio/dio.dart' as dio;
import 'package:extremo/misc/logger.dart';
import 'package:grpc/grpc.dart';
import 'package:logger/logger.dart';

class GrpcLoggerInterceptor extends ClientInterceptor {
  GrpcLoggerInterceptor._();

  static final GrpcLoggerInterceptor _instance = GrpcLoggerInterceptor._();
  static GrpcLoggerInterceptor get instance => _instance;

  final maskptn1 = RegExp(r'password: \s*\S+');
  final maskptn2 = RegExp(r'token: \s*\S+');
  String sanitize(String log) {
    final s = log.replaceAll(maskptn1, 'password: ********').replaceAll('\n', ', ');
    return s.replaceAll(maskptn2, 'token: ********').replaceAll('\n', ', ');
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    final s = sanitize(request.toString());
    logger.d('gRPC Request. method: ${method.path}. $s');

    final response = super.interceptUnary(
      method,
      request,
      options,
      invoker,
    );

    // ignore: cascade_invocations
    // response.then((r) {
    //   final s = r.toString().substring(0, 200);
    //   logger.d('gRPC Response. method: ${method.path}. $s');
    // });

    return response;
  }
}
