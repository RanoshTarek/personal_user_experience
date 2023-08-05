import 'dart:convert';

import 'package:personal_user_experience/ui/entry_form/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/entry_form/model/task_type.dart';

abstract class Preference {
  static const userOptionsKey = 'userOptionsKey';
  static const userListOfExperienceOptionsKey =
      'userListOfExperienceOptionsKey';
  static const listOfTaskTypeOptionsKey = 'listOfTaskTypeOptionsKey';
  static const listOfActivityOptionsKey = 'listOfActivityOptionsKey';

  String? get userString;

  set userString(String? user);

  User get user;

  void clear();
}

class PreferenceImpl {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  PreferenceImpl();

  static String? get userString =>
      sharedPreferences?.getString(Preference.userOptionsKey);

  static set userString(String? options) => options == null
      ? sharedPreferences?.remove(Preference.userOptionsKey)
      : sharedPreferences?.setString(Preference.userOptionsKey, options);

  static List<String> get userListOfExperienceString =>
      sharedPreferences
          ?.getStringList(Preference.userListOfExperienceOptionsKey) ??
      [];

  static set userListOfExperienceString(List<String> options) => options == null
      ? sharedPreferences?.remove(Preference.userListOfExperienceOptionsKey)
      : sharedPreferences?.setStringList(
          Preference.userListOfExperienceOptionsKey, options);

  static List<String> get listOfTaskTypeString =>
      sharedPreferences?.getStringList(Preference.listOfTaskTypeOptionsKey) ??
      [
        jsonEncode(TaskType(id: 1, name: 'FOT', isSelected: false)).toString(),
        jsonEncode(TaskType(id: 2, name: 'SGH', isSelected: false)).toString(),
        jsonEncode(TaskType(id: 3, name: 'R/I', isSelected: false)).toString(),
        jsonEncode(TaskType(id: 4, name: 'TS', isSelected: false)).toString(),
        jsonEncode(TaskType(id: 5, name: 'MEL', isSelected: false)).toString(),
        jsonEncode(TaskType(id: 6, name: 'MOD', isSelected: false)).toString(),
        jsonEncode(TaskType(id: 7, name: 'REP', isSelected: false)).toString(),
        jsonEncode(TaskType(id: 8, name: 'OVH', isSelected: false)).toString(),
        jsonEncode(TaskType(id: 9, name: 'INSP', isSelected: false)).toString(),
      ];

  static List<TaskType> get listOfTaskType =>
      PreferenceImpl.listOfTaskTypeString
          .map((e) => TaskType.fromJson(json.decode(e)))
          .toList(growable: true);

  static set listOfTaskTypeString(List<String> options) => options == null
      ? sharedPreferences?.remove(Preference.listOfTaskTypeOptionsKey)
      : sharedPreferences?.setStringList(
          Preference.listOfTaskTypeOptionsKey, options);

  static List<String> get listOfActivityTypeString =>
      sharedPreferences?.getStringList(Preference.listOfActivityOptionsKey) ??
      [
        jsonEncode(TaskType(id: 1, name: 'TRN', isSelected: false)).toString(),
        jsonEncode(TaskType(id: 2, name: 'PER', isSelected: false)).toString(),
        jsonEncode(TaskType(id: 3, name: 'SUP', isSelected: false)).toString(),
        jsonEncode(TaskType(id: 4, name: 'CRS', isSelected: false)).toString(),
      ];

  static List<TaskType> get listOfActivityType =>
      PreferenceImpl.listOfActivityTypeString
          .map((e) => TaskType.fromJson(json.decode(e)))
          .toList(growable: true);

  static set listOfActivityTypeString(List<String> options) => options == null
      ? sharedPreferences?.remove(Preference.listOfActivityOptionsKey)
      : sharedPreferences?.setStringList(
          Preference.listOfActivityOptionsKey, options);

  static User? get user {
    if (userString != null) {
      Map<String, dynamic> valueMap = json.decode(userString ?? "");
      return User.fromJson(valueMap);
    }
    return null;
  }

  static void clear() {
    sharedPreferences?.clear();
  }
}
