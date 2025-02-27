import 'package:flutter/material.dart';

class NewItem extends StatelessWidget {
  const NewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              maxLength: 500,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Not Valied item';
                }
                return null;
              },
            )
          ],
        )),
      ),
    );
  }
}
