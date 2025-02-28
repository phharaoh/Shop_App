import 'dart:developer';
import '../data/categories.dart';
import '../models/category.dart';
import 'package:flutter/material.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();

  var _entredName = '';

  var _entredQuantety = 0;

  Category _selectedCategory = categories[Categories.fruit]!;

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
                onSaved: (newValue) {
                  _entredName = newValue!;
                },
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
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: '1',
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                      ),
                      onSaved: (newValue) {
                        _entredQuantety = int.parse(newValue!);
                      },
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
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                        items: [
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
                              ),
                            )
                        ],
                        onChanged: (Category? value) {
                          setState(() {
                            _selectedCategory == value!;
                          });
                        }),
                  )
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
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        log(_entredName);
                        log(_entredQuantety.toString());
                        log(_selectedCategory.toString());
                      }
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
