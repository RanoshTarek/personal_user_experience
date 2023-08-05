import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:personal_user_experience/ui/entry_form/model/ac_req.dart';

part 'ac_type.g.dart';

@JsonSerializable()
class AcType {
  final String id;
  final String name;
  final List<AcReq> acReq  ;

  AcType({required this.id,required this.name,required this.acReq});

  factory AcType.fromJson(Map<String, dynamic> json) => _$AcTypeFromJson(json);

  Map<String, dynamic> toJson() => _$AcTypeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
