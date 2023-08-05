import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'ac_req.g.dart';

@JsonSerializable()
class AcReq {
  final String id;
  final String name;

  AcReq({required this.id,required this.name});

  factory AcReq.fromJson(Map<String, dynamic> json) =>
      _$AcReqFromJson(json);

  Map<String, dynamic> toJson() => _$AcReqToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
