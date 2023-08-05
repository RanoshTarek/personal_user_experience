import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'experience_log.g.dart';

@JsonSerializable()
class ExperienceLog {
  final String date;
  final String time;
  final String acType;
  final String acReg;
  final String typeOfMaint;
  final String skill;
  final String auth;
  final String ata;
  final String mh;
  final String tlb;
  final List<String> taskType;
  final List<String> typeOfActivity;
  final String defect;

  ExperienceLog(
      {required this.date,
      required this.time,
      required this.acType,
      required this.acReg,
      required this.typeOfMaint,
      required this.skill,
      required this.auth,
      required this.ata,
      required this.mh,
      required this.tlb,
      required this.taskType,
      required this.typeOfActivity,
      required this.defect});

  factory ExperienceLog.fromJson(Map<String, dynamic> json) =>
      _$ExperienceLogFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceLogToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
