import 'new_item.dart';
import '../data/dummy_items.dart';
import 'package:flutter/material.dart';



class GroceryList extends StatelessWidget {
  const GroceryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Grocery"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>  NewItem(),
                ));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(groceryItems[index].name),
            trailing: CircleAvatar(
                backgroundColor: groceryItems[index].category.color,
                radius: 15,
                child: Text(groceryItems[index].quantity.toString())),
            leading: Container(
              width: 24,
              height: 24,
              color: groceryItems[index].category.color,
            ),
          );
        },
      ),
    );
  }
}
