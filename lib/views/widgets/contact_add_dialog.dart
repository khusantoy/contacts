import 'package:flutter/material.dart';

class ContactAddDialog extends StatefulWidget {
  const ContactAddDialog({super.key});

  @override
  State<ContactAddDialog> createState() => _ContactAddDialogState();
}

class _ContactAddDialogState extends State<ContactAddDialog> {
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String phoneNumber = "";

  void _add() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.pop(context, {
        "name": name,
        "phoneNumber": phoneNumber,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Contact"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Name",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter a name";
                }
                return null;
              },
              onSaved: (newValue) {
                name = newValue ?? "";
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.add),
                border: OutlineInputBorder(),
                labelText: "Phone Number",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter a phone number";
                } else if (!RegExp(r"^\d+$").hasMatch(value)) {
                  return "Enter a valid phone number";
                }
                return null;
              },
              onSaved: (newValue) {
                phoneNumber = newValue ?? "";
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
        ElevatedButton(
          onPressed: _add,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: const Text("Save"),
        )
      ],
    );
  }
}
