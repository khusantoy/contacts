import 'dart:math';

import 'package:contacts/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactsController {
  final List<ContactModel> _list = [
    ContactModel(
      name: "Tom",
      phoneNumber: "+998 97 123 43 45",
      color: Colors.amber,
    ),
    ContactModel(
      name: "Jerry",
      phoneNumber: "+998 99 143 42 49",
      color: Colors.red,
    ),
    ContactModel(
      name: "Mackvin",
      phoneNumber: "+998 90 123 45 34",
      color: Colors.green,
    ),
  ];

  List<ContactModel> get list {
    return [..._list];
  }

  void add(String name, String phoneNumber) {
    int red = Random().nextInt(255);
    int green = Random().nextInt(255);
    int blue = Random().nextInt(255);

    _list.add(
      ContactModel(
        name: name,
        phoneNumber: phoneNumber,
        color: Color.fromARGB(255, red, green, blue),
      ),
    );
  }

  void update(int index, String name, String phoneNumber) {
    _list[index].name = name;
    _list[index].phoneNumber = phoneNumber;
  }

  void delete(int index) {
    _list.removeAt(index);
  }
}
