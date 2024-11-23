class XContext {
  final Map<String, dynamic> _context = {};

  String _generateKey(Type type, int id) {
    return '$type:$id';
  }

  T? getE<T>(int id) {
    return _context[_generateKey(T, id)] as T?;
  }

  void putE<T>(int id, T entity) {
    _context[_generateKey(T, id)] = entity;
  }

  static XContext of() {
    return XContext();
  }

  @override
  String toString() {
    return _context.entries.map((entry) => '${entry.key}: ${entry.value}').join(', ');
  }
}
