import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_list/Screen_homepage/db/db%20function/data_function.dart';
import 'package:student_list/Screen_homepage/db/db%20model/data_model.dart';

class AddStudentWeidget extends StatefulWidget {
  const AddStudentWeidget({Key? key}) : super(key: key);

  @override
  State<AddStudentWeidget> createState() => _AddStudentWeidgetState();
}

class _AddStudentWeidgetState extends State<AddStudentWeidget> {
  static final List<String> _domain = [
    'Flutter',
    'Python',
    'MERN',
    'MEAN',
    'Game Devoloping',
    'Go',
    'Android'
  ];

  final _formkey = GlobalKey<FormState>();
  final _namecontroller = TextEditingController();

  final _numbercontroller = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  var _dropdownValue;

  bool vadlidD = false;
  final _emailcontroller = TextEditingController();

  File? imagefile;
  String imagestring = '';
  String newimage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Container(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.pink,
                    backgroundImage:
                        MemoryImage(const Base64Decoder().convert(newimage)),
                    radius: 45,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      showBottomSheet(context);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text('Upload Image'),
                  ),
                  TextFormField(
                    controller: _namecontroller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name Is Empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _numbercontroller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Phone Number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone Number Is Empty';
                      } else if (value.length != 10) {
                        return 'Enter a valid phone Number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    value: _dropdownValue,
                    decoration: const InputDecoration(
                      hintText: "Select Domain",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (ctgry) =>
                        setState(() => _dropdownValue = ctgry),
                    validator: (value) =>
                        value == null ? 'domain is required' : null,
                    items:
                        _domain.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                  // TextFormField(
                  //   textAlign: TextAlign.center,
                  //   controller: _classcontroller,
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     hintText: 'Domain',
                  //   ),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Domain Is Empty';
                  //   } else {
                  //     return null;
                  //   }
                  // },),

                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    controller: _emailcontroller,
                    decoration: const InputDecoration(
                        focusColor: Colors.red,
                        border: OutlineInputBorder(),
                        label: Text('Email Id')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email Id Is Empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          onAddStudentDetails(context);
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Students')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (ctx1) {
        return SizedBox(
          height: 100,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              const Text(
                'choose your profile photo',
                style: TextStyle(color: Colors.purple),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      takePic(ImageSource.camera);
                    },
                    icon: const Icon(
                      Icons.camera,
                      color: Colors.purple,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      takePic(ImageSource.gallery);
                    },
                    icon: const Icon(
                      Icons.image_rounded,
                      color: Colors.purple,
                    ),
                  )
                ],
              )
            ]),
          ),
        );
      },
    );
  }

  // Widget imageprofile(BuildContext context) {
  //   return Stack(
  //     children: [
  //       imagefile != null
  //           ? Image.file(
  //               imagefile!,
  //               width: 250,
  //               height: 250,
  //               fit: BoxFit.cover,
  //             )
  //           : Image.asset('assets/avathar.png', width: 250, height: 250),
  //       Padding(
  //         padding: const EdgeInsets.only(top: 150, left: 150),
  //         child: IconButton(
  //           onPressed: () {
  //             showBottomSheet(context);
  //           },
  //           icon: const Icon(
  //             Icons.camera_alt,
  //             color: Colors.pink,
  //             size: 80,
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  takePic(ImageSource imageSource) async {
    final image = await ImagePicker().pickImage(source: imageSource);
    final bytes = File(image!.path).readAsBytesSync();
    imagestring = base64Encode(bytes);
    setState(() {
      newimage = imagestring;
      Navigator.of(context).pop();
    });
  }

  Future<void> onAddStudentDetails(BuildContext context) async {
    final name = _namecontroller.text.trim();
    final number = _numbercontroller.text.trim();
    final domainName = _dropdownValue;
    final email = _emailcontroller.text.trim();

    if (name.isEmpty || number.isEmpty || domainName.isEmpty || email.isEmpty) {
      const Text('Required Field is Empty');
    } else {
      final StudentModel studentDb = StudentModel(
          name: name,
          domainName: domainName,
          number: number,
          email: email,
          imgUrl: newimage);
      addStudent(studentDb);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Successfully Added'),
          backgroundColor: Color.fromARGB(255, 3, 141, 8)));
      _namecontroller.clear();
      _numbercontroller.clear();
      _emailcontroller.clear();
    }
  }
}
