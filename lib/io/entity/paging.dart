import 'package:collection/collection.dart';

class PagingEntity<T> {
  PagingEntity({required this.elements, required this.totalSize});

  final List<T> elements;
  final int totalSize;
}
