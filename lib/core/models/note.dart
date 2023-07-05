import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note extends HiveObject {
  Note({
    required this.docId,
    required this.title,
    required this.content,
    required this.colorCode,
  });
  @HiveField(0)
  final int docId;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final int colorCode;
}
