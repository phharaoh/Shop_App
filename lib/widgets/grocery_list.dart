import 'new_item.dart';
import '../models/grocery_item.dart';
import 'package:flutter/material.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("Not Have Any Item Yet"),
    );

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(_groceryItems[index].id),
            onDismissed: (_) {
              setState(() {
                _groceryItems.remove(_groceryItems[index]);
              });
            },
            child: ListTile(
              title: Text(_groceryItems[index].name),
              trailing: CircleAvatar(
                  backgroundColor: _groceryItems[index].category.color,
                  radius: 15,
                  child: Text(_groceryItems[index].quantity.toString())),
              leading: Container(
                width: 24,
                height: 24,
                color: _groceryItems[index].category.color,
              ),
            ),
          );
        },
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Grocery"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                    builder: (context) => const NewItem(),
                  ))
                      .then((value) {
                    if (value == null) return;
                    setState(() {
                      _groceryItems.add(value);
                    });
                  });
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: content);
  }
}
