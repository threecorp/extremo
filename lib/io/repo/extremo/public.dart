// TODO(ClassBase): Transform to Class base
// TODO(offline): DBCache to use offline or error

// @riverpod
// Future<List<UserEntity>> dbListUsersByIds(
//   DbListUsersByIdsRef ref,
//   List<int> ids,
// ) async {
//   final userBox = await ref.read(userBoxProvider.future);
//   final publicApi = ref.read(publicApiProvider);
//
//   Future<UserEntity?> getter(int id) async {
//     final entity = userBox.get(id);
//     if (entity != null) {
//       return entity;
//     }
//
//     final response = await publicApi.getUser(id);
//     final result = UserEntity.fromResponse(element: response.element);
//
//     await userBox.put(id, result);
//     return result;
//   }
//
//   return Future.wait(ids.map((id) => getter(id).onNotFoundErrorToNull()))
//       .then((list) => list.whereType<UserEntity>().toList());
// }
