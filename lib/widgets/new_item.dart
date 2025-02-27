import '../data/categories.dart';
import 'package:flutter/material.dart';

class NewItem extends StatelessWidget {
  NewItem({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                keyboardType: TextInputType.number,
                maxLength: 500,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'in valid name';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,

                // space here !!!!!
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: '1',
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                      ),
                      validator: (String? value) {
                        if (int.tryParse(value!) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Must be valid ,positive number !.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: DropdownButtonFormField(items: [
                    for (final category in categories.entries)
                      DropdownMenuItem(
                          value: category.value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: category.value.color,
                              ),
                              Text(category.value.title),
                            ],
                          ))
                  ], onChanged: (value) {}))
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: const Text("Reset"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.validate();
                    },
                    child: const Text("Add Item"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
