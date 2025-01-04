// import 'package:dio/dio.dart';
// import 'package:extremo/io/store/api/extremo/extremo_request.dart';
// import 'package:extremo/io/store/api/extremo/extremo_response.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:extremo/io/entity/extremo/extremo.dart';
import 'package:extremo/io/entity/paging.dart';
import 'package:extremo/io/store/api/extremo/auth.dart';
import 'package:extremo/io/store/api/extremo/mypage.dart';
import 'package:extremo/io/store/api/extremo/public.dart';
import 'package:extremo/io/store/db/extremo/box.dart';
import 'package:extremo/io/x/extremo/extremo.dart';
import 'package:extremo/misc/exception.dart';
import 'package:extremodart/extremo/api/mypage/artifacts/v1/artifact_service.pb.dart' as artifactpb;
import 'package:extremodart/extremo/api/mypage/chats/v1/chat_service.pb.dart' as chatpb;
import 'package:extremodart/google/protobuf/timestamp.pb.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat.g.dart';

// TODO(ClassBase): Transform to Class base
// TODO(offline): DBCache to use offline or error

@riverpod
Future<PagingEntity<UserEntity>> repoListPagerChatUsers(
  RepoListPagerChatUsersRef ref,
  int page,
  int pageSize,
) async {
  final rpc = ref.read(mypageChatServiceClientProvider);

  // TODO(offline): Use DBCache when offlined or error
  final response = await rpc.listUsers(
    chatpb.ListUsersRequest(
      page: page,
      pageSize: pageSize,
    ),
  );
  final elements = await Future.wait(
    response.elements.map(
      (element) => xFormRpcChatUserEntity(ref, element),
    ),
  );

  return PagingEntity<UserEntity>(
    elements: elements.toList(),
    totalSize: response.totalSize,
  );
}

@riverpod
Future<PagingEntity<ChatEntity>> repoListPagerChats(
  RepoListPagerChatsRef ref,
  int page,
  int pageSize,
) async {
  final rpc = ref.read(mypageChatServiceClientProvider);

  // TODO(offline): Use DBCache when offlined or error
  final response = await rpc.list(
    chatpb.ListRequest(
      page: page,
      pageSize: pageSize,
    ),
  );
  final elements = await Future.wait(
    response.elements.map(
      (element) => xFormRpcChatEntity(ref, element),
    ),
  );

  return PagingEntity<ChatEntity>(
    elements: elements.toList(),
    totalSize: response.totalSize,
  );
}

@riverpod
Future<Result<ChatEntity, Exception>> repoCreateChat(
  RepoCreateChatRef ref,
  ChatEntity request,
) async {
  final rpc = ref.read(mypageChatServiceClientProvider);

  try {
    final entity = await rpc
        .create(
          chatpb.CreateRequest(
            senderFk: request.senderFk,
            recipientFk: request.recipientFk,
            // message: request.message,
          ),
        )
        .then(
          (r) => xFormRpcChatEntity(ref, r.element),
        );

    return Success(entity);
  } on GrpcError catch (ex, _) {
    if ([StatusCode.invalidArgument].contains(ex.code)) {
      return Failure(GrpcException(ex));
    }

    debugPrint(ex.message);
    rethrow;
  }
}

//
//
//
