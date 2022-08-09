import 'package:flutter/material.dart';
import 'package:student_list/Screen_homepage/addstudentwidget.dart';
import 'package:student_list/Screen_homepage/db/db%20function/data_function.dart';
import 'package:student_list/Screen_homepage/liststudentwidget.dart';
import 'package:student_list/Screen_homepage/search_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentSelectedIndex = 0;
  final _pages = [
    const AddStudentWeidget(),
    ScreenSearch(),
    ListStudentWidget(),
  ];
  static List<String> appBarTitle = ['Home', 'Search', 'Details'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            appBarTitle[_currentSelectedIndex],
            style: const TextStyle(
                fontSize: 30, fontStyle: FontStyle.italic, letterSpacing: 5),
          ),
        ),
      ),
      body: _pages[_currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentSelectedIndex,
          onTap: (newindex) {
            setState(() {
              _currentSelectedIndex = newindex;
              getAllStudents();
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List')
          ]),
    );
  }
}
