import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_list/Screen_homepage/db/db%20model/data_model.dart';
import 'package:student_list/Screen_homepage/edit_screen.dart';

// ignore: must_be_immutable
class ShowScreen extends StatelessWidget {
  StudentModel data;
  int? index;
  ShowScreen({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            data.name.toUpperCase(),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        EditScreen(data: data, index: index)));
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: Column(children: [
        const SizedBox(
          height: 40,
        ),
        Center(
          child: Card(
            elevation: 50,
            shadowColor: Colors.black,
            color: Colors.blue[100],
            child: SizedBox(
              width: 300,
              height: 450,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.pink,
                      radius: 108,
                      child: CircleAvatar(
                        backgroundImage: MemoryImage(
                            const Base64Decoder().convert(data.imgUrl)),
                        radius: 100,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // ignore: prefer_interpolation_to_compose_strings
                    Text(
                      ' ${data.name}',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.green[900],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.green[900],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // ignore: prefer_interpolation_to_compose_strings
                    Text(
                      'Domain:${data.domainName}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.green[900],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // ignore: prefer_interpolation_to_compose_strings
                    Text(
                      'Contact:${data.number}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.green[900],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // ignore: prefer_interpolation_to_compose_strings
                    Text(
                      'Email:${data.email}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.green[900],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
