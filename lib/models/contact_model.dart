import 'package:flutter/material.dart';

class ContactModel {
  String name;
  String phoneNumber;
  final Color color;

  ContactModel({
    required this.name,
    required this.phoneNumber,
    this.color = Colors.teal,
  });
}
