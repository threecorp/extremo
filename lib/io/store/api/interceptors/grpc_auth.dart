// import 'package:extremo/misc/logger.dart';
import 'package:extremo/io/auth/account.dart';
import 'package:grpc/grpc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GrpcAuthInterceptor extends ClientInterceptor {
  GrpcAuthInterceptor(this.ref);
  final Ref ref;

  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    final token = ref.read(accountProvider.notifier).token() ?? '';
    final newOptions = options.mergedWith(
      CallOptions(
        metadata: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    return invoker(method, request, newOptions);
  }

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    final token = ref.read(accountProvider.notifier).token() ?? '';
    final newOptions = options.mergedWith(
      CallOptions(
        metadata: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    return invoker(method, requests, newOptions);
  }
}
