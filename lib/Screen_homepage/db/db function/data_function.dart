import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_list/Screen_homepage/db/db%20model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  final id = await studentDB.add(value);
  value.id = id;

  studentDB.put(value.id, value);
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int id) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.deleteAt(id);

  getAllStudents();
}

editStudent({required data, required index}) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentDB.putAt(index, data);
  getAllStudents();
}

// void getSearchResult(String value) {
//   searchData.clear();

//   for (var intex in studentListNotifier.value) {
//     if (intex.name.toString().toLowerCase().contains(
//           value.toLowerCase(),
//         )) {
//       StudentModel data = StudentModel(
//           name: intex.name,
//           number: intex.number,
//           classname: intex.classname,
//           email: intex.email,);
//       searchData.add(data);
//     }
//   }
// }

String imgstring = '';

imageadd(XFile? pickImage) async {
  if (pickImage == null) {
    return;
  } else {
    final bayts = File(pickImage.path).readAsBytesSync();
    imgstring = base64Encode(bayts);
  }
}
