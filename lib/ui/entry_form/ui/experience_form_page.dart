import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:personal_user_experience/core/preference.dart';
import 'package:personal_user_experience/design%20/default_from_field_text.dart';
import 'package:personal_user_experience/ui/entry_form/model/ac_req.dart';
import 'package:personal_user_experience/ui/entry_form/model/ac_type.dart';
import 'package:personal_user_experience/ui/entry_form/model/experience_log.dart';
import 'package:personal_user_experience/ui/entry_form/model/task_type.dart';
import 'package:personal_user_experience/ui/entry_form/ui/list_of_experience.dart';

import '../../../design /custom_dropdown.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({
    super.key,
  });

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}
var acTypeList = [
  AcType(id: 'A320', name: 'A320', acReq: [
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-AH${String.fromCharCode(index + 65)}",
            name: "A7-AH${String.fromCharCode(index + 65)}")),
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-LA${String.fromCharCode(index + 65)}",
            name: "A7-LA${String.fromCharCode(index + 65)}")),
    AcReq(id: 'Custom', name: 'Custom')
  ]),
  AcType(id: 'A330', name: 'A330', acReq: [
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-AC${String.fromCharCode(index + 65)}",
            name: "A7-AC${String.fromCharCode(index + 65)}")),
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-AE${String.fromCharCode(index + 65)}",
            name: "A7-AE${String.fromCharCode(index + 65)}")),
    AcReq(id: 'Custom', name: 'Custom')
  ]),
  AcType(id: 'A340', name: 'A340', acReq: [
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-AP${String.fromCharCode(index + 65)}",
            name: "A7-AP${String.fromCharCode(index + 65)}")),
    AcReq(id: 'Custom', name: 'Custom')
  ]),
  AcType(id: 'A350', name: 'A350', acReq: [
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-AL${String.fromCharCode(index + 65)}",
            name: "A7-AL${String.fromCharCode(index + 65)}")),
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-AM${String.fromCharCode(index + 65)}",
            name: "A7-AM${String.fromCharCode(index + 65)}")),
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-AN${String.fromCharCode(index + 65)}",
            name: "A7-AN${String.fromCharCode(index + 65)}")),
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-AO${String.fromCharCode(index + 65)}",
            name: "A7-AO${String.fromCharCode(index + 65)}")),
    AcReq(id: 'Custom', name: 'Custom')
  ]),
  AcType(id: 'B737', name: 'B737', acReq: [
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-BS${String.fromCharCode(index + 65)}",
            name: "A7-BS${String.fromCharCode(index + 65)}")),
    AcReq(id: 'Custom', name: 'Custom')
  ]),
  AcType(id: 'B787', name: 'B787', acReq: [
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-BC${String.fromCharCode(index + 65)}",
            name: "A7-BC${String.fromCharCode(index + 65)}")),
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-BD${String.fromCharCode(index + 65)}",
            name: "A7-BD${String.fromCharCode(index + 65)}")),
    ...List.generate(
      26,
          (index) => AcReq(
          id: "A7-BH${String.fromCharCode(index + 65)}",
          name: "A7-BH${String.fromCharCode(index + 65)}"),
    ),
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-BK${String.fromCharCode(index + 65)}",
            name: "A7-BK${String.fromCharCode(index + 65)}")),
    AcReq(id: 'Custom', name: 'Custom')
  ]),
  AcType(id: 'B777', name: 'B777', acReq: [
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-BA${String.fromCharCode(index + 65)}",
            name: "A7-BA${String.fromCharCode(index + 65)}")),
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-BF${String.fromCharCode(index + 65)}",
            name: "A7-BF${String.fromCharCode(index + 65)}")),
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-BB${String.fromCharCode(index + 65)}",
            name: "A7-BB${String.fromCharCode(index + 65)}")),
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-BE${String.fromCharCode(index + 65)}",
            name: "A7-BE${String.fromCharCode(index + 65)}")),
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-B0${String.fromCharCode(index + 65)}",
            name: "A7-B0${String.fromCharCode(index + 65)}")),
    AcReq(id: 'Custom', name: 'Custom')
  ]),
  AcType(id: 'B747', name: 'B747', acReq: [
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-BG${String.fromCharCode(index + 65)}",
            name: "A7-BG${String.fromCharCode(index + 65)}")),
    ...List.generate(
        26,
            (index) => AcReq(
            id: "A7-BO${String.fromCharCode(index + 65)}",
            name: "A7-BO${String.fromCharCode(index + 65)}")),
    AcReq(id: 'Custom', name: 'Custom')
  ]),
  AcType(
      id: 'Custom',
      name: 'Custom',
      acReq: [AcReq(id: 'Custom', name: 'Custom')]),
];
class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final TextEditingController customAcController = TextEditingController();
  final TextEditingController customReqController = TextEditingController();
  final TextEditingController ataController = TextEditingController();
  final TextEditingController mhController = TextEditingController();
  final TextEditingController tlbController = TextEditingController();
  final TextEditingController defectController = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  var spacer = const SizedBox(
    height: 20,
  );

  @override
  void initState() {
    super.initState();
    dateController.text = "mon 24 july 2023";
    timeController.text = "02:00 pm";
  }

  var currentAcType = "";
  var currentReqType = "";

  var typeOfMainT = "LM";
  var skill = "B1";
  var auth = "QCAA";

  var currentCustomType = "Custom";


  var currentTime = DateFormat('hh:mm').format(DateTime.now());
  var currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  Future<void> _selectDate(BuildContext context, bool startDate) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.blue),
          ),
          child: child!),
    );
    currentDate = DateFormat('dd-MM-yyyy').format(picked!);
    setState(() {});
  }

  Future<void> _selectTime(BuildContext context, bool startDate) async {
    final pickedTime = await showTimePicker(
      context: context,
      builder: (context, child) => Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.blue),
          ),
          child: child!),
      initialTime: TimeOfDay.now(),
    );

    currentTime = pickedTime?.format(context) ?? "";
    //'${pickedTime?.hour.toString().padLeft(2, '0')}:${pickedTime?.minute.toString().padLeft(2, '0')}';
    setState(() {});
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Form Page'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Date",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _selectDate(context, false);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4),
                                          child: Icon(
                                            Icons.calendar_month,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: Text(
                                              currentDate,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Time",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _selectTime(context, false);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4),
                                          child: Icon(
                                            Icons.watch_later_outlined,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: Text(
                                              currentTime,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      spacer,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("AC TYPE"),
                                const SizedBox(
                                  height: 8,
                                ),
                                DefaultDropDown(
                                  onChanged: (value) {
                                    currentAcType = value.toString() ?? "";
                                    currentReqType = (currentAcType != "")
                                        ? acTypeList
                                            .where((e) => e.id == currentAcType)
                                            .first
                                            .acReq
                                            .first
                                            .id
                                        : "";

                                    setState(() {});
                                  },
                                  items: acTypeList
                                      .map((e) => DropdownMenuItem(
                                            value: e.id,
                                            child: Text(e.name),
                                          ))
                                      .toList(growable: true),
                                  value: (currentAcType != "")
                                      ? currentAcType
                                      : null,
                                ),
                                if (currentAcType == 'Custom')
                                  Column(
                                    children: [
                                      spacer,
                                      DefaultTextFormField(customAcController,
                                          TextInputType.text,
                                          textAlign: TextAlign.start,
                                          validate: (text) {
                                        if (text?.isEmpty == true) {
                                          return 'Enter Custom Ac';
                                        }
                                        return null;
                                      },
                                          hintText: 'Custom AC Type',
                                          textInputAction: TextInputAction.go,
                                          onFieldSubmitted: (_) {}),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("AC REG"),
                                const SizedBox(
                                  height: 8,
                                ),
                                DefaultDropDown(
                                  onChanged: (value) {
                                    print("valurrr $value");
                                    currentReqType = value.toString() ?? "";
                                    setState(() {});
                                  },
                                  items: (currentAcType == "")
                                      ? []
                                      : acTypeList
                                          .where((e) => e.id == currentAcType)
                                          .first
                                          .acReq
                                          .map((e) => DropdownMenuItem(
                                                value: e.id,
                                                child: Text(e.name),
                                              ))
                                          .toList(growable: true),
                                  value: currentReqType,
                                ),
                                if (currentReqType == "Custom")
                                  Column(
                                    children: [
                                      spacer,
                                      DefaultTextFormField(customReqController,
                                          TextInputType.text,
                                          textAlign: TextAlign.start,
                                          validate: (text) {
                                        if (text?.isEmpty == true) {
                                          return 'Enter Custom Ac REG';
                                        }
                                        return null;
                                      },
                                          hintText: 'Custom AC REG',
                                          textInputAction: TextInputAction.go,
                                          onFieldSubmitted: (_) {}),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      spacer,
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Type of maint"),
                                const SizedBox(
                                  height: 8,
                                ),
                                DefaultDropDown(
                                  onChanged: (value) {
                                    typeOfMainT = value.toString() ?? "";
                                  },
                                  items: const [
                                    DropdownMenuItem(
                                      value: "LM",
                                      child: Text("LM"),
                                    ),
                                    DropdownMenuItem(
                                      value: "BM",
                                      child: Text("BM"),
                                    ),
                                  ],
                                  value: typeOfMainT,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Skill"),
                                const SizedBox(
                                  height: 8,
                                ),
                                DefaultDropDown(
                                  onChanged: (value) {
                                    skill = value.toString() ?? "";
                                  },
                                  items: const [
                                    DropdownMenuItem(
                                      value: "B1",
                                      child: Text("B1"),
                                    ),
                                    DropdownMenuItem(
                                      value: "B2",
                                      child: Text("B2"),
                                    ),
                                  ],
                                  value: skill,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("AUTH"),
                                const SizedBox(
                                  height: 8,
                                ),
                                DefaultDropDown(
                                  onChanged: (value) {
                                    auth = value.toString() ?? "";
                                  },
                                  items: const [
                                    DropdownMenuItem(
                                      value: "QCAA",
                                      child: Text("QCAA"),
                                    ),
                                    DropdownMenuItem(
                                      value: "EASA",
                                      child: Text("EASA"),
                                    ),
                                  ],
                                  value: auth,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      spacer,
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: DefaultTextFormField(
                                  ataController, TextInputType.visiblePassword,
                                  textAlign: TextAlign.start, validate: (text) {
                                if (text?.isEmpty == true) {
                                  return 'Enter ATA';
                                }
                                return null;
                              },
                                  hintText: 'ATA',
                                  textInputAction: TextInputAction.go,
                                  onFieldSubmitted: (_) {})),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            flex: 2,
                            child: DefaultTextFormField(
                                mhController, TextInputType.visiblePassword,
                                textAlign: TextAlign.start, validate: (text) {
                              if (text?.isEmpty == true) {
                                return 'Enter MH';
                              }
                              return null;
                            },
                                hintText: 'MH',
                                textInputAction: TextInputAction.go,
                                onFieldSubmitted: (_) {}),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            flex: 2,
                            child: DefaultTextFormField(
                                tlbController, TextInputType.visiblePassword,
                                textAlign: TextAlign.start, validate: (text) {
                              if (text?.isEmpty == true) {
                                return 'Enter TLB/WO NUM';
                              }
                              return null;
                            },
                                hintText: 'TLB/WO NUM',
                                textInputAction: TextInputAction.go,
                                onFieldSubmitted: (_) {}),
                          )
                        ],
                      ),
                      spacer,
                      const Text("Task Type"),
                      const SizedBox(
                        height: 8,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 3,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                value: PreferenceImpl
                                    .listOfTaskType[index].isSelected,
                                onChanged: (bool? value) {
                                  setState(() {
                                    List<String> listOfTask =
                                        PreferenceImpl.listOfTaskTypeString;
                                    var task = TaskType.fromJson(
                                        json.decode(listOfTask[index]));
                                    task.isSelected = value!;

                                    listOfTask[index] =
                                        jsonEncode(task).toString();
                                    PreferenceImpl.listOfTaskTypeString =
                                        listOfTask;
                                  });
                                },
                              ),
                              Text(PreferenceImpl.listOfTaskType[index].name ??
                                  "")
                            ],
                          );
                        },
                        itemCount: PreferenceImpl.listOfTaskType.length,
                      ),
                      spacer,
                      const Text("Type Of Activity"),
                      const SizedBox(
                        height: 8,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 3,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                value: PreferenceImpl
                                    .listOfActivityType[index].isSelected,
                                onChanged: (bool? value) {
                                  setState(() {
                                    List<String> listOfTask =
                                        PreferenceImpl.listOfActivityTypeString;
                                    var task = TaskType.fromJson(
                                        json.decode(listOfTask[index]));
                                    task.isSelected = value!;

                                    listOfTask[index] =
                                        jsonEncode(task).toString();
                                    PreferenceImpl.listOfActivityTypeString =
                                        listOfTask;
                                  });
                                },
                              ),
                              Text(PreferenceImpl
                                      .listOfActivityType[index].name ??
                                  "")
                            ],
                          );
                        },
                        itemCount: PreferenceImpl.listOfActivityType.length,
                      ),
                      spacer,
                      DefaultTextFormField(
                          defectController, TextInputType.visiblePassword,
                          padding: 4,
                          textAlign: TextAlign.start, validate: (text) {
                        if (text?.isEmpty == true) {
                          return 'Enter Defect';
                        }
                        return null;
                      },
                          minLines: 5,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100),
                          ],
                          hintText: 'Defect',
                          textInputAction: TextInputAction.go,
                          onFieldSubmitted: (_) {}),
                      spacer,
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            jsonEncode(ExperienceLog(
                              date: currentDate,
                              time: currentTime,
                              acType: (currentAcType == 'Custom')
                                  ? customAcController.text
                                  : currentAcType,
                              acReg: (currentReqType == 'Custom')
                                  ? customReqController.text
                                  : currentReqType,
                              typeOfMaint: typeOfMainT,
                              defect: defectController.text,
                              skill: skill,
                              auth: auth,
                              ata: ataController.text,
                              mh: mhController.text,
                              tlb: tlbController.text,
                              taskType: PreferenceImpl.listOfTaskType
                                  .map((e) => jsonEncode(e).toString())
                                  .cast<String>()
                                  .toList(),
                              typeOfActivity: PreferenceImpl.listOfActivityType
                                  .map((e) => jsonEncode(e).toString())
                                  .cast<String>()
                                  .toList(),
                            )).toString();

                            List<String> listOfExperience =
                                PreferenceImpl.userListOfExperienceString;
                            var dd = jsonEncode(ExperienceLog(
                              date: currentDate,
                              time: currentTime,
                              acType: (currentAcType == 'Custom')
                                  ? customAcController.text
                                  : currentAcType,
                              acReg: (currentReqType == 'Custom')
                                  ? customReqController.text
                                  : currentReqType,
                              typeOfMaint: typeOfMainT,
                              defect: defectController.text,
                              skill: skill,
                              auth: auth,
                              ata: ataController.text,
                              mh: mhController.text,
                              tlb: tlbController.text,
                              taskType:PreferenceImpl.listOfTaskType
                                  .map((e) => jsonEncode(e).toString())
                                  .cast<String>()
                                  .toList(),
                              typeOfActivity:  PreferenceImpl.listOfActivityType
                                  .map((e) => jsonEncode(e).toString())
                                  .cast<String>()
                                  .toList(),
                            )).toString();
                            listOfExperience.insert(0, dd);

                            PreferenceImpl.userListOfExperienceString =
                                listOfExperience;

                            await Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ListOfExperiencePage(),
                                ),
                                (Route<dynamic> route) => false);
                            /*PreferenceImpl.userString = (jsonEncode(User(
                                name: nameController.text,
                                staffNumber: staffNumberController.text,
                                department: departmentController.text,
                                authNo: authNoController.text))
                                .toString()); */
                          }
                        },
                        child: const SizedBox(
                            width: double.infinity,
                            child: Center(child: Text('Next'))),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
