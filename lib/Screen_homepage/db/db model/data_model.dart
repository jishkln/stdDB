import 'package:hive_flutter/adapters.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String number;

  @HiveField(3)
  final String domainName;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String imgUrl;

  StudentModel({
    required this.name,
    required this.domainName,
    required this.number,
    required this.email,
    required this.imgUrl,
    this.id,
  });
}
