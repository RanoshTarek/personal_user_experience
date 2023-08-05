import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:personal_user_experience/core/preference.dart';
import 'package:personal_user_experience/design%20/default_from_field_text.dart';
import 'package:personal_user_experience/ui/entry_form/model/user.dart';
import 'package:personal_user_experience/ui/entry_form/ui/list_of_experience.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({
    super.key,
  });

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController staffNumberController = TextEditingController();
  final TextEditingController authNoController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  var spacer = const SizedBox(
    height: 20,
  );

  @override
  void initState() {
    super.initState();
    nameController.text = PreferenceImpl.user?.name ?? "";
    staffNumberController.text = PreferenceImpl.user?.staffNumber ?? "";
    departmentController.text = PreferenceImpl.user?.department ?? "";
    authNoController.text = PreferenceImpl.user?.authNo ?? "";
  }

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
        title: const Text('Entry Page'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'PERSONAL TECH LOG REGISTRY',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  spacer,
                  spacer,
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        DefaultTextFormField(
                            nameController, TextInputType.visiblePassword,
                            textAlign: TextAlign.start, validate: (text) {
                          if (text?.isEmpty == true) {
                            return 'Please Enter Your Name';
                          }
                          return null;
                        },
                            hintText: 'Name',
                            textInputAction: TextInputAction.go,
                            onFieldSubmitted: (_) {}),
                        spacer,
                        DefaultTextFormField(staffNumberController,
                            TextInputType.number,

                            textAlign: TextAlign.start, validate: (text) {
                          if (text?.isEmpty == true) {
                            return 'Please Enter Your Staff number';
                          }
                          return null;
                        },
                            hintText: 'Staff number',
                            textInputAction: TextInputAction.go,
                            onFieldSubmitted: (_) {}),
                        spacer,
                        DefaultTextFormField(
                            authNoController, TextInputType.visiblePassword,
                            textAlign: TextAlign.start, validate: (text) {
                          if (text?.isEmpty == true) {
                            return 'Please Enter Your Auth no';
                          }
                          return null;
                        },
                            hintText: 'Auth no',
                            textInputAction: TextInputAction.go,
                            onFieldSubmitted: (_) {}),
                        spacer,
                        DefaultTextFormField(
                            departmentController, TextInputType.visiblePassword,
                            textAlign: TextAlign.start, validate: (text) {
                          if (text?.isEmpty == true) {
                            return 'Please Enter Your Department';
                          }
                          return null;
                        },
                            hintText: 'Department',
                            textInputAction: TextInputAction.go,
                            onFieldSubmitted: (_) {}),
                        spacer,
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              PreferenceImpl.userString = (jsonEncode(User(
                                      name: nameController.text,
                                      staffNumber: staffNumberController.text,
                                      department: departmentController.text,
                                      authNo: authNoController.text))
                                  .toString());
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ListOfExperiencePage()));
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
        ),
      ),
    );
  }
}
