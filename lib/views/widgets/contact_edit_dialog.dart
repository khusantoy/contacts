import 'package:flutter/material.dart';

class ContactEditDialog extends StatefulWidget {
  final String name;
  final String phoneNumber;

  ContactEditDialog({
    required this.name,
    required this.phoneNumber,
    super.key,
  });

  TextEditingController nameInput = TextEditingController();
  TextEditingController phoneNumberInput = TextEditingController();

  @override
  State<ContactEditDialog> createState() => _ContactEditDialogState();
}

class _ContactEditDialogState extends State<ContactEditDialog> {
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String phoneNumber = "";

  @override
  void initState() {
    super.initState();
    widget.nameInput.text = widget.name;
    widget.phoneNumberInput.text = widget.phoneNumber;
  }

  void _update() {
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
      title: const Text("Edit Contact"),
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
              controller: widget.nameInput,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Phone Number",
                prefixIcon: Icon(Icons.add),
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
              controller: widget.phoneNumberInput,
            )
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
          onPressed: _update,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: const Text("Update"),
        )
      ],
    );
  }
}
