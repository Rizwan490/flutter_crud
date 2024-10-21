import 'package:crud_api/models/person_model.dart';
import 'package:crud_api/providers/item_provider.dart';
import 'package:flutter/material.dart';

class PersonList extends StatefulWidget {
  const PersonList({super.key});

  @override
  State<PersonList> createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  final ItemProvider provider = ItemProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persons List'),
      ),
      body: FutureBuilder<PersonModel>(
        future: provider.fetchPersons(), // Call the fetch method
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}')); // Show error message
          } else if (!snapshot.hasData ||
              snapshot.data!.record == null ||
              snapshot.data!.record!.isEmpty) {
            return Center(
                child: Text('No persons found')); // Handle empty data case
          }

          // If data is available, display it in a ListView
          final persons = snapshot.data!.record!;
          return ListView.builder(
            itemCount: persons.length,
            itemBuilder: (context, index) {
              final person = persons[index];
              return ListTile(
                title: Text('${person.name} ${person.surname}'),
                subtitle: Text('ID: ${person.idNumber}'),
              );
            },
          );
        },
      ),
    );
  }
}
