import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_list/Screen_homepage/addstudentwidget.dart';
import 'package:student_list/Screen_homepage/db/db%20function/data_function.dart';
import 'package:student_list/Screen_homepage/db/db%20model/data_model.dart';
import 'package:student_list/Screen_homepage/liststudentwidget.dart';

// ignore: must_be_immutable
class EditScreen extends StatefulWidget {
  StudentModel data;
  int? index;
  EditScreen({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _namecontroller = TextEditingController();
  final _numbercontroller = TextEditingController();
  final _classcontroller = TextEditingController();
  final _emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _namecontroller.text = widget.data.name.toString();
    _classcontroller.text = widget.data.domainName.toString();
    _numbercontroller.text = widget.data.number.toString();
    _emailcontroller.text = widget.data.email.toString();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(children: [
          Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.pink,
                radius: 108,
                child: CircleAvatar(
                  backgroundImage: MemoryImage(const Base64Decoder()
                      .convert(widget.data.imgUrl.toString())),
                  radius: 100,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  pickImage();
                },
                icon: const Icon(Icons.image),
                label: const Text('Upload Image'),
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: _namecontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: _numbercontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: _classcontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: _emailcontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    onAddStudentDetails(context);
                    const AddStudentWeidget();
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Save Data')),
            ],
          ),
        ]),
      ),
    );
  }

  String _image = '';

  String imageToString = '';

  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      final imageTemporary = File(image.path).readAsBytesSync();
      imageToString = base64Encode(imageTemporary);
    }

    setState(() {
      _image = imageToString;
    });
  }

  onAddStudentDetails(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _name = _namecontroller.text;
    // ignore: no_leading_underscores_for_local_identifiers
    final _number = _numbercontroller.text;
    // ignore: no_leading_underscores_for_local_identifiers
    final _domainName = _classcontroller.text;
    // ignore: no_leading_underscores_for_local_identifiers
    final _email = _emailcontroller.text;

    // ignore: no_leading_underscores_for_local_identifiers

    if (_name.isEmpty ||
        _number.isEmpty ||
        _domainName.isEmpty ||
        _email.isEmpty) {
      return const Text('Required Field is Empty');
    } else {
      final editedstudent = StudentModel(
          name: _name,
          number: _number,
          domainName: _domainName,
          email: _email,
          imgUrl: _image);

      editStudent(data: editedstudent, index: widget.index);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Successfully Updated'),
          backgroundColor: Color.fromARGB(255, 3, 32, 4)));
      _namecontroller.clear();
      _numbercontroller.clear();
      _emailcontroller.clear();
      FocusManager.instance.primaryFocus?.unfocus();
      ListStudentWidget();
    }
  }
}
