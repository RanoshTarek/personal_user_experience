import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'task_type.g.dart';

@JsonSerializable()
class TaskType {
  final int id;
  final String name;
   bool isSelected = false;

  TaskType({required this.id,required this.name,required this.isSelected});

  factory TaskType.fromJson(Map<String, dynamic> json) =>
      _$TaskTypeFromJson(json);

  Map<String, dynamic> toJson() => _$TaskTypeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
