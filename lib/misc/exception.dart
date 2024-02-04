import 'package:grpc/grpc.dart';

class GrpcException implements Exception {
  GrpcException(this.error);
  final GrpcError error;

  @override
  String toString() {
    return error.message ?? '';
  }
}
