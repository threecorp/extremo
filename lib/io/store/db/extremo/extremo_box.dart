import 'package:extremo/io/entity/extremo.dart';

import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'extremo_box.g.dart';

@riverpod
Future<Box<ExtremoArtifactEntity>> extremoArtifactBox(_) async =>
    Hive.openBox<ExtremoArtifactEntity>('extremoArtifactBox');

@riverpod
Future<Box<ExtremoUserEntity>> extremoUserBox(_) async =>
    Hive.openBox<ExtremoUserEntity>('extremoUserBox');
