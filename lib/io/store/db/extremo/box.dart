import 'package:extremo/io/entity/extremo/extremo.dart';

import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'box.g.dart';

@riverpod
Future<Box<ArtifactEntity>> artifactBox(
  ArtifactBoxRef ref,
) async =>
    Hive.openBox<ArtifactEntity>('extremoArtifactBox');

@riverpod
Future<Box<UserEntity>> userBox(
  UserBoxRef ref,
) async =>
    Hive.openBox<UserEntity>('extremoUserBox');

@riverpod
Future<Box<MessageEntity>> messageBox(
  MessageBoxRef ref,
) async =>
    Hive.openBox<MessageEntity>('extremoMessageBox');
