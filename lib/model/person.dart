import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'person.g.dart';

@immutable
@HiveType(typeId : 1)
class Person {
  @HiveField(0)
  final String name;

  @HiveField(2)
  final int age;

  Person(this.name, this.age);

  Person copyWith({
    final String name,
    final int age,
  }) {
    return Person(
      name ?? this.name,
      age ?? this.age,
    );
  }
}