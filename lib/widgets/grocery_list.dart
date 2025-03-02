import 'dart:convert';
import 'new_item.dart';
import '../models/grocery_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/data/categories.dart';
import 'package:shop_app/models/category.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final url = Uri.https('fir-data-base-e046f-default-rtdb.firebaseio.com',
        'shopping-list.json');

    final http.Response res = await http.get(url);

    final Map<String, dynamic> loadedData = json.decode(res.body);

    final List<GroceryItem> _loadedItem = [];

    for (var item in loadedData.entries) {
      final Category category = categories.entries
          .firstWhere(
              (element) => element.value.title == item.value['category'])
          .value;
      _loadedItem.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category));
    }

    setState(() {
      _groceryItems = _loadedItem;
    });
  }

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
                onPressed: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NewItem(),
                  ));

                  loadData();
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: content);
  }
}
