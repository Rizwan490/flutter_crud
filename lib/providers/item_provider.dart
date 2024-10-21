import 'package:crud_api/models/person_model.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ItemProvider with ChangeNotifier {
  // PersonModel? _personModel;
  bool _isLoading = false;
  List<Record> _persons = [];

  List<Record> get persons => _persons;

//  PersonModel? get personModel => _personModel;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  // Fetch all persons and notify listeners
  Future<PersonModel> fetchPersons() async {
    _isLoading = true;
    notifyListeners();
    try {
      print('Fetching persons...');
      return await _apiService.fetchAllPersons();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> addItem(Record person) async {
    await _apiService.createItem(person);
    await fetchPersons(); // Refresh the list after adding
  }

  Future<void> updateItem(String id, PersonModel person) async {
    await _apiService.updateItem(id, person);
    await fetchPersons(); // Refresh the list after updating
  }

  Future<void> deleteItem(String id) async {
    await _apiService.deleteItem(id);
    await fetchPersons(); // Refresh the list after deleting
  }
}
