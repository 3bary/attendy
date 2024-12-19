import 'package:flutter/material.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();

}

class _HomeViewBodyState extends State<HomeViewBody> {

  @override
  void initState() {


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendy'),
        elevation: 0.7,
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with your dynamic item count
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Item $index'), // Replace with your item data
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Handle edit action
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.details),
                    onPressed: () {
                      // Handle details action
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add new card action
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
