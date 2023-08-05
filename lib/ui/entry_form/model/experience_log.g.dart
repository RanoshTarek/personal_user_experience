// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExperienceLog _$ExperienceLogFromJson(Map<String, dynamic> json) =>
    ExperienceLog(
      date: json['date'] as String,
      time: json['time'] as String,
      acType: json['acType'] as String,
      acReg: json['acReg'] as String,
      typeOfMaint: json['typeOfMaint'] as String,
      skill: json['skill'] as String,
      auth: json['auth'] as String,
      ata: json['ata'] as String,
      mh: json['mh'] as String,
      tlb: json['tlb'] as String,
      taskType:
          (json['taskType'] as List<dynamic>).map((e) => e as String).toList(),
      typeOfActivity: (json['typeOfActivity'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      defect: json['defect'] as String,
    );

Map<String, dynamic> _$ExperienceLogToJson(ExperienceLog instance) =>
    <String, dynamic>{
      'date': instance.date,
      'time': instance.time,
      'acType': instance.acType,
      'acReg': instance.acReg,
      'typeOfMaint': instance.typeOfMaint,
      'skill': instance.skill,
      'auth': instance.auth,
      'ata': instance.ata,
      'mh': instance.mh,
      'tlb': instance.tlb,
      'taskType': instance.taskType,
      'typeOfActivity': instance.typeOfActivity,
      'defect': instance.defect,
    };
