import 'package:contacts/controllers/contacts_controller.dart';
import 'package:contacts/models/contact_model.dart';
import 'package:contacts/views/widgets/contact_add_dialog.dart';
import 'package:contacts/views/widgets/contact_edit_dialog.dart';
import 'package:contacts/views/widgets/contact_item.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final contactsController = ContactsController();

  void delete(int index) {
    contactsController.delete(index);
    setState(() {});
  }

  void edit(int index, ContactModel contact) async {
    Map<String, dynamic>? data = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return ContactEditDialog(
          name: contact.name,
          phoneNumber: contact.phoneNumber,
        );
      },
    );
    if (data != null) {
      contactsController.update(index, data['name'], data['phoneNumber']);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
      ),
      body: ListView.builder(
        itemCount: contactsController.list.length,
        itemBuilder: (ctx, index) {
          return ContactItem(
            contactsController.list[index],
            onDelete: () {
              delete(index);
            },
            onEdit: () {
              edit(index, contactsController.list[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic>? data = await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (ctx) {
                return const ContactAddDialog();
              });
          if (data != null) {
            contactsController.add(
              data['name'],
              data['phoneNumber'],
            );
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
