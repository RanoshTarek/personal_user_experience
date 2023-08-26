import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:personal_user_experience/core/preference.dart';
import 'package:personal_user_experience/design%20/custom_dropdown.dart';
import 'package:personal_user_experience/ui/entry_form/model/experience_log.dart';
import 'package:personal_user_experience/ui/entry_form/model/task_type.dart';
import 'package:personal_user_experience/ui/entry_form/ui/entry_page.dart';
import 'package:personal_user_experience/ui/entry_form/ui/experience_form_page.dart';
import 'package:printing/printing.dart';

class ListOfExperiencePage extends StatefulWidget {
  const ListOfExperiencePage({
    super.key,
  });

  @override
  State<ListOfExperiencePage> createState() => _ListOfExperiencePageState();
}

class _ListOfExperiencePageState extends State<ListOfExperiencePage> {
  String? currentAcType;

  void _incrementCounter() {
    setState(() {});
  }

  final TextEditingController nameController = TextEditingController();
  var spacer = const SizedBox(
    height: 20,
  );
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

  var currentStartDate = DateFormat('dd-MM-yyyy').format(DateTime.utc(2000));

  Future<void> _selectStartDate(BuildContext context, bool startDate) async {
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
    currentStartDate = DateFormat('dd-MM-yyyy').format(picked!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    DateTime startDate = DateFormat('dd-MM-yyyy').parse(currentStartDate);
    DateTime endDate = DateFormat('dd-MM-yyyy').parse(currentDate);
    debugPrint("YEEEEs  $startDate");
    debugPrint("YEEEEs  $endDate");

    print(
        "dddd ${DateFormat('dd-MM-yyyy').parse("31-07-2023").isBetween(from: startDate, to: endDate)}");

    if (DateFormat('dd-MM-yyyy').parse("31-07-2023").isAfter(startDate) ||
        endDate.isAfter(DateFormat('dd-MM-yyyy').parse("31-07-2023"))) {
      debugPrint("YEEEEs");
    } else {
      debugPrint("NOOO");
    }
    List<ExperienceLog> experienceLogList = (currentAcType == null)
        ? PreferenceImpl.userListOfExperienceString
            .map((e) => ExperienceLog.fromJson(json.decode(e)))
            .where((element) => DateFormat('dd-MM-yyyy')
                .parse(element.date)
                .isBetween(from: startDate, to: endDate))
            .toList(growable: true)
        : PreferenceImpl.userListOfExperienceString
            .map((e) => ExperienceLog.fromJson(json.decode(e)))
            .where((element) => element.acType == currentAcType)
            .where((element) => DateFormat('dd-MM-yyyy')
                .parse(element.date)
                .isBetween(from: startDate, to: endDate))
            .toList(growable: true);
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
          title: const Text('Experience Logs'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.person,
                color: Colors.white,
                size: 26,
              ),
              onPressed: () async {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const EntryPage()));
              },
            ),
          ],
        ),
        body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                                  if (currentAcType == "Custom")
                                    currentAcType = null;
                                  setState(() {});
                                },
                                items: acTypeList
                                    .map((e) => DropdownMenuItem(
                                          value: e.id,
                                          child: Text(e.name),
                                        ))
                                    .toList(growable: true),
                                value: (currentAcType != "" ||
                                        currentAcType == null)
                                    ? currentAcType
                                    : null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Start Date",
                                style: TextStyle(color: Colors.blue),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _selectStartDate(context, false);
                                },
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                  ),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 4),
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
                                            currentStartDate,
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
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "End Date",
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
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                  ),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 4),
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
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    (experienceLogList.isEmpty)
                        ? const Center(
                            // Center is a layout widget. It takes a single child and positions it
                            // in the middle of the parent.
                            child: Text('not found'),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, columnIndex) {
                              var experienceData =
                                  experienceLogList[columnIndex];
                              return InkWell(
                                onTap: () async {
                                  Printing.layoutPdf(
                                    // [onLayout] will be called multiple times
                                    // when the user changes the printer or printer settings
                                    onLayout: (PdfPageFormat format) {
                                      // Any valid Pdf document can be returned here as a list of int

                                      return buildPdf(
                                          format, context, experienceLogList);
                                    },
                                  );
                                },
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Text(experienceData.date),
                                            const Spacer(),
                                            Text(experienceData.acType),
                                            const Spacer(),
                                            Text(experienceData.acReg),
                                            const Spacer(),
                                            Text(experienceData.tlb),
                                            const Spacer(),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4),
                                              child: Icon(
                                                Icons.print,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                experienceData.defect.trim()),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              Widget cancelButton = TextButton(
                                                child: Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              );
                                              Widget continueButton =
                                                  TextButton(
                                                child: Text("Delete"),
                                                onPressed: () {
                                                  List<String>
                                                      listOfExperience =
                                                      PreferenceImpl
                                                          .userListOfExperienceString;
                                                  listOfExperience
                                                      .removeAt(columnIndex);

                                                  PreferenceImpl
                                                          .userListOfExperienceString =
                                                      listOfExperience;
                                                  Navigator.of(context).pop();

                                                  setState(() {});
                                                },
                                              );

                                              // set up the AlertDialog
                                              AlertDialog alert = AlertDialog(
                                                title: Text("Warning"),
                                                content: Text("Are You Sure?"),
                                                actions: [
                                                  continueButton,
                                                  cancelButton,
                                                ],
                                              );

                                              // show the dialog
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return alert;
                                                },
                                              );
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                              );
                            },
                            itemCount: experienceLogList.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.all(2),
                                color: Colors.grey,
                                height: 1,
                              );
                            },
                          ),
                  ],
                ),
              ),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ExperienceFormPage()));
          },
          tooltip: 'add',
          child: const Icon(Icons.add),
        ));
  }

  /// This method takes a page format and generates the Pdf file data
  Future<Uint8List> buildPdf(PdfPageFormat format, BuildContext buildContext,
      List<ExperienceLog> experienceLog) async {
    // Create the Pdf document
    var count = 0;
    var pages = 1;

    final ByteData image = await rootBundle.load('images/ic_check.png');
    Uint8List imageData = (image).buffer.asUint8List();
    if (experienceLog.length < 6) {
      count = 6 - experienceLog.length;
      pages = 1;
    } else if ((experienceLog.length % 6) == 0) {
      count = (experienceLog.length ~/ 6) * 6 - experienceLog.length;
      print("lskdlksdkldk ${3}");
    } else {
      count = ((experienceLog.length ~/ 6) + 1) *
              (experienceLog.length / 6).toInt() *
              6 -
          experienceLog.length;
    }
    print("lskdlksdkldk ${count}");

    final pw.Document doc = pw.Document();

    doc.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation :pw.PageOrientation.landscape,
        header: (pw.Context context) {
          return pw.Column(
            children: [
              pw.SizedBox(height: 50),
              pw.Table(children: [
                pw.TableRow(
                    decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.black)),
                    children: [
                      tableCellHead('Full Name'),
                      tableCellHead('${PreferenceImpl.user?.name} Tarek Yahai'),
                      tableCellHead('Staff No.'),
                      tableCellHead('${PreferenceImpl.user?.staffNumber}'),
                      tableCellHead('Auth No.'),
                      tableCellHead('${PreferenceImpl.user?.authNo}'),
                      tableCellHead('Section.'),
                      tableCellHead('${PreferenceImpl.user?.department}')
                    ]),
              ]),
            ],
          );
        },
        footer: (pw.Context context) {
          return pw.SizedBox(height: 50);
        },
        margin: const pw.EdgeInsets.all(31),
        // This is the page margin
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Table(children: [
              pw.TableRow(
                  verticalAlignment: pw.TableCellVerticalAlignment.full,
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black)),
                  children: [
                    tableCell('1.Date LOC'),
                    tableCell('2. AIC or Comp. Type'),
                    tableCell('3.A/C Reg. or Comp. S/N'),
                    tableCell('4.Type of Maint. (rating)'),
                    tableCell('5.Privilege used'),
                    pw.Container(
                        width: 112,
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(
                          right: pw.BorderSide(color: PdfColors.black),
                        )),
                        child: pw.Column(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(
                              vertical: 2,
                            ),
                            child: pw.Text(
                              "6.Task type",
                              style: const pw.TextStyle(
                                fontSize: 6,
                                color: PdfColors.black,
                              ),
                              textAlign: pw.TextAlign.right,
                            ),
                          ),
                          pw.Container(
                              decoration: const pw.BoxDecoration(
                                  border: pw.Border(
                                      right:
                                          pw.BorderSide(color: PdfColors.black),
                                      top: pw.BorderSide(
                                          color: PdfColors.black))),
                              child: pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Row(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [
                                        pw.Row(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.center,
                                          children: List.generate(
                                            experienceLog.first.taskType.length,
                                            (index) {
                                              final taskType =
                                                  TaskType.fromJson(json.decode(
                                                      experienceLog.first
                                                          .taskType[index]));

                                              return pw.Container(
                                                  height: 28,
                                                  width: 10,
                                                  padding:
                                                      const pw.EdgeInsets.all(
                                                          1),
                                                  decoration: const pw
                                                          .BoxDecoration(
                                                      border: pw.Border(
                                                          right: pw.BorderSide(
                                                              color: PdfColors
                                                                  .black))),
                                                  child: pw.Transform.rotate(
                                                    angle: pi * 6,
                                                    child: pw.Text(
                                                        taskType.name,
                                                        style:
                                                            const pw.TextStyle(
                                                                fontSize: 6),
                                                        textAlign: pw
                                                            .TextAlign.center),
                                                  )
                                                  // pw.Text("${index + 1}")
                                                  );
                                            },
                                          ),
                                        )
                                      ])
                                ],
                              ))
                        ])),
                    pw.Container(
                        width: 48,
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(
                          right: pw.BorderSide(color: PdfColors.black),
                        )),
                        child: pw.Column(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(
                              vertical: 2,
                            ),
                            child: pw.Text(
                              '7. Type of Activity',
                              style: const pw.TextStyle(
                                fontSize: 5,
                                color: PdfColors.black,
                              ),
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                          pw.Container(
                              decoration: const pw.BoxDecoration(
                                  border: pw.Border(
                                      right:
                                          pw.BorderSide(color: PdfColors.black),
                                      top: pw.BorderSide(
                                          color: PdfColors.black))),
                              child: pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.center,
                                    children: List.generate(
                                      experienceLog.first.typeOfActivity.length,
                                      (index) {
                                        final taskActivityType =
                                            TaskType.fromJson(json.decode(
                                                experienceLog.first
                                                    .typeOfActivity[index]));
                                        return pw.Container(
                                          height: 24,
                                          width: 10,
                                          padding: const pw.EdgeInsets.all(1),
                                          decoration: const pw.BoxDecoration(
                                              border: pw.Border(
                                                  right: pw.BorderSide(
                                                      color: PdfColors.black))),
                                          child: pw.Transform.rotate(
                                              angle: pi * 6,
                                              child: pw.Text(
                                                  taskActivityType.name,
                                                  style: const pw.TextStyle(
                                                      fontSize: 6),
                                                  textAlign:
                                                      pw.TextAlign.center)),

                                          // pw.Text("${index + 1}")
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ))
                        ])),
                    tableCell('8. ATA'),
                    tableCell('9.Details of Task performed', width: 180),
                    pw.Container(
                        width: 20,
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(
                          right: pw.BorderSide(color: PdfColors.black),
                        )),
                        child: pw.Column(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(
                              vertical: 2,
                            ),
                            child: pw.Text(
                              '10. Under',
                              style: const pw.TextStyle(
                                fontSize: 5,
                                color: PdfColors.black,
                              ),
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                          pw.Container(
                              decoration: const pw.BoxDecoration(
                                  border: pw.Border(
                                      right:
                                          pw.BorderSide(color: PdfColors.black),
                                      top: pw.BorderSide(
                                          color: PdfColors.black))),
                              child: pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Row(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [
                                        pw.Container(
                                          width: 8,
                                          height: 24,
                                          padding: const pw.EdgeInsets.all(1),
                                          decoration: const pw.BoxDecoration(
                                              border: pw.Border(
                                                  right: pw.BorderSide(
                                                      color: PdfColors.black))),
                                          child: pw.Text('Q',
                                              style: const pw.TextStyle(
                                                  fontSize: 6),
                                              textAlign: pw.TextAlign.center),

                                          // pw.Text("${index + 1}")
                                        ),
                                        pw.Container(
                                          width: 8,
                                          height: 24,
                                          padding: const pw.EdgeInsets.all(1),

                                          child: pw.Text('E',
                                              style: const pw.TextStyle(
                                                  fontSize: 6),
                                              textAlign: pw.TextAlign.center),

                                          // pw.Text("${index + 1}")
                                        )
                                      ])
                                ],
                              ))
                        ])),
                    tableCell('11.Time (hrs)'),
                    tableCell('12.Maintenance record reference'),
                    tableCell('13.CS Sign & stamp(*)'),
                    tableCell('14.Approved certifier'),
                  ]),
              ...List.generate(
                experienceLog.length,
                (index) {
                  return pw.TableRow(
                      verticalAlignment: pw.TableCellVerticalAlignment.full,
                      decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.black)),
                      children: [
                        tableCellEmpty(experienceLog[index].date),
                        tableCellEmpty(experienceLog[index].acType),
                        tableCellEmpty(experienceLog[index].acReg),
                        tableCellEmpty(experienceLog[index].typeOfMaint),
                        tableCellEmpty((experienceLog[index]
                                        .taskType
                                        .where((String e) =>
                                            (TaskType.fromJson(json.decode(e))
                                                    .isSelected ==
                                                true))
                                        .map((e) => e)
                                        .cast<String>()
                                        .toList()
                                        .length +
                                    experienceLog[index]
                                        .typeOfActivity
                                        .where((String e) =>
                                            (TaskType.fromJson(json.decode(e))
                                                    .isSelected ==
                                                true))
                                        .map((e) => e)
                                        .cast<String>()
                                        .toList()
                                        .length) >
                                0
                            ? '${(experienceLog[index].taskType.where((String e) => (TaskType.fromJson(json.decode(e)).isSelected == true)).map((e) => e).cast<String>().toList().length + experienceLog[index].typeOfActivity.where((String e) => (TaskType.fromJson(json.decode(e)).isSelected == true)).map((e) => e).cast<String>().toList().length)}'
                            : ''),
                        pw.Container(
                            width: 112,
                            decoration: const pw.BoxDecoration(
                                border: pw.Border(
                              right: pw.BorderSide(color: PdfColors.black),
                            )),
                            child: pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: List.generate(
                                experienceLog.first.taskType.length,
                                (childIndex) {
                                  final taskType = TaskType.fromJson(
                                      json.decode(experienceLog[index]
                                          .taskType[childIndex]));

                                  return pw.Container(
                                      width: 10,
                                      alignment: pw.Alignment.center,
                                      padding: const pw.EdgeInsets.all(1),
                                      decoration: const pw.BoxDecoration(
                                          border: pw.Border(
                                              right: pw.BorderSide(
                                                  color: PdfColors.black))),
                                      child: (taskType.isSelected)
                                          ? pw.Image(pw.MemoryImage(imageData),
                                              height: 6, width: 6)
                                          : pw.SizedBox());
                                },
                              ),
                            )),
                        pw.Container(
                            width: 48,
                            decoration: const pw.BoxDecoration(
                                border: pw.Border(
                              right: pw.BorderSide(color: PdfColors.black),
                            )),
                            child: pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: List.generate(
                                experienceLog.first.typeOfActivity.length,
                                    (childIndex) {
                                  final taskActivityType = TaskType.fromJson(
                                      json.decode(experienceLog[index]
                                          .typeOfActivity[childIndex]));

                                  Uint8List imageData =
                                      (image).buffer.asUint8List();
                                  return pw.Container(
                                      width: 10,
                                      alignment: pw.Alignment.center,
                                      padding: const pw.EdgeInsets.all(1),
                                      decoration: const pw.BoxDecoration(
                                          border: pw.Border(
                                              right: pw.BorderSide(
                                                  color: PdfColors.black))),
                                      child: (taskActivityType.isSelected)
                                          ? pw.Image(pw.MemoryImage(imageData),
                                              height: 6, width: 6)
                                          : pw.SizedBox());
                                },
                              ),
                            )),
                        tableCellEmpty(experienceLog[index].ata),
                        tableCellEmpty(
                          experienceLog[index].defect.trim(),
                          width: 180,
                        ),
                        pw.Container(
                            width: 20,
                            decoration: const pw.BoxDecoration(
                                border: pw.Border(
                              right: pw.BorderSide(color: PdfColors.black),
                            )),
                            child: pw.Row(
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                children: [
                                  pw.Container(
                                      width: 8,
                                      alignment: pw.Alignment.center,
                                      padding: const pw.EdgeInsets.all(1),
                                      decoration: const pw.BoxDecoration(
                                          border: pw.Border(
                                              right: pw.BorderSide(
                                                  color: PdfColors.black))),
                                      child: (experienceLog[index].auth ==
                                              'QCAA')
                                          ? pw.Image(pw.MemoryImage(imageData),
                                              height: 6, width: 6)
                                          : pw.SizedBox()),
                                  pw.Container(
                                      width: 8,
                                      alignment: pw.Alignment.center,
                                      padding: const pw.EdgeInsets.all(1),
                                      decoration: const pw.BoxDecoration(
                                          border: pw.Border(
                                              right: pw.BorderSide(
                                                  color: PdfColors.black))),
                                      child: (experienceLog[index].auth ==
                                              'EASA')
                                          ? pw.Image(pw.MemoryImage(imageData),
                                              height: 6, width: 6)
                                          : pw.SizedBox())
                                ])),
                        tableCellEmpty(experienceLog[index].mh),
                        tableCellEmpty(experienceLog[index].tlb),
                        tableCellEmpty(''),
                      ]);
                },
              ),
              ...List.generate(
                count,
                (index) {
                  return pw.TableRow(
                      verticalAlignment: pw.TableCellVerticalAlignment.full,
                      decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.black)),
                      children: [
                        tableCellEmpty(''),
                        tableCellEmpty(''),
                        tableCellEmpty(''),
                        tableCellEmpty(''),
                        tableCellEmpty(''),
                        pw.Container(
                            width: 112,
                            decoration: const pw.BoxDecoration(
                                border: pw.Border(
                              right: pw.BorderSide(color: PdfColors.black),
                            )),
                            child: pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: List.generate(
                                experienceLog.first.taskType.length,
                                (childIndex) {
                                  final taskType = TaskType.fromJson(
                                      json.decode(experienceLog
                                          .first.taskType[childIndex]));

                                  return pw.Container(
                                      width: 10,
                                      alignment: pw.Alignment.center,
                                      padding: const pw.EdgeInsets.all(1),
                                      decoration: const pw.BoxDecoration(
                                          border: pw.Border(
                                              right: pw.BorderSide(
                                                  color: PdfColors.black))),
                                      child: pw.Text("",
                                          style:
                                              const pw.TextStyle(fontSize: 6)));
                                },
                              ),
                            )),
                        pw.Container(
                            width: 48,
                            decoration: const pw.BoxDecoration(
                                border: pw.Border(
                              right: pw.BorderSide(color: PdfColors.black),
                            )),
                            child: pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: List.generate(
                                experienceLog.first.typeOfActivity.length,
                                (childIndex) {
                                  final taskActivityType = TaskType.fromJson(
                                      json.decode(experienceLog
                                          .first.typeOfActivity[childIndex]));

                                  return pw.Container(
                                      width: 10,
                                      alignment: pw.Alignment.center,
                                      padding: const pw.EdgeInsets.all(1),
                                      decoration: const pw.BoxDecoration(
                                          border: pw.Border(
                                              right: pw.BorderSide(
                                                  color: PdfColors.black))),
                                      child: pw.Text("",
                                          style:
                                              const pw.TextStyle(fontSize: 6)));
                                },
                              ),
                            )),
                        tableCellEmpty(''),
                        tableCellEmpty(
                          '',
                          width: 180,
                        ),
                        pw.Container(
                            width: 20,
                            decoration: const pw.BoxDecoration(
                                border: pw.Border(
                              right: pw.BorderSide(color: PdfColors.black),
                            )),
                            child: pw.Row(
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                children: [
                                  pw.Container(
                                      width: 8,
                                      alignment: pw.Alignment.center,
                                      padding: const pw.EdgeInsets.all(1),
                                      decoration: const pw.BoxDecoration(
                                          border: pw.Border(
                                              right: pw.BorderSide(
                                                  color: PdfColors.black))),
                                      child: pw.Text("",
                                          style:
                                              const pw.TextStyle(fontSize: 6))),
                                  pw.Container(
                                      width: 8,
                                      alignment: pw.Alignment.center,
                                      padding: const pw.EdgeInsets.all(1),
                                      decoration: const pw.BoxDecoration(
                                          border: pw.Border(
                                              right: pw.BorderSide(
                                                  color: PdfColors.black))),
                                      child: pw.Text("",
                                          style:
                                              const pw.TextStyle(fontSize: 6)))
                                ])),
                        tableCellEmpty(''),
                        tableCellEmpty(''),
                        tableCellEmpty(''),
                        tableCellEmpty(''),
                      ]);
                },
              ),
            ]),
          ];
        }));

    return await doc.save();
  }
}

pw.Widget tableCell(String name, {double? width}) {
  return pw.Container(
      width: width,
      decoration: const pw.BoxDecoration(
          border: pw.Border(right: pw.BorderSide(color: PdfColors.black))),
      child:
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(
            name,
            style: const pw.TextStyle(
              fontSize: 6,
              color: PdfColors.black,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ),
      ]));
}

pw.Widget tableCellEmpty(
  String name, {
  double? width,
}) {
  return pw.Container(
      width: width,
      alignment: pw.Alignment.center,
      constraints: const pw.BoxConstraints(minHeight: 50, maxHeight: 50),
      decoration: const pw.BoxDecoration(
          border: pw.Border(right: pw.BorderSide(color: PdfColors.black))),
      child: pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Expanded(
            child: pw.Text(name,
                style: const pw.TextStyle(
                  fontSize: 6,
                  color: PdfColors.black,
                ),
                maxLines: 10,
                textAlign: pw.TextAlign.center,
                overflow: pw.TextOverflow.visible),
          )));
}

pw.Widget tableCellHead(String name) {
  return pw.Container(
      decoration: const pw.BoxDecoration(
          border: pw.Border(right: pw.BorderSide(color: PdfColors.black))),
      child:
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(
            name,
            style: const pw.TextStyle(
              fontSize: 6,
              color: PdfColors.black,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ),
      ]));
}

/*
 decoration: pw.BoxDecoration(
                      color: PdfColors.pink,
                      border: pw.Border.all(color: PdfColors.red))
                  ,
 */
extension DateTimeExtension on DateTime {
  bool isAfterOrEqual(DateTime other) {
    return isAtSameMomentAs(other) || isAfter(other);
  }

  bool isBeforeOrEqual(DateTime other) {
    return isAtSameMomentAs(other) || isBefore(other);
  }

  bool isBetween({required DateTime from, required DateTime to}) {
    return isAfterOrEqual(from) && isBeforeOrEqual(to);
  }

  bool isBetweenExclusive({required DateTime from, required DateTime to}) {
    return isAfter(from) && isBefore(to);
  }
}
