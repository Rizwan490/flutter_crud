import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  final ApiService _apiService = ApiService();

  Future<void> login(String email, String password) async {
    final response = await _apiService.login(email, password);
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      String token = body['token'];
      await _apiService.storeToken(token);
      _isAuthenticated = true;
      notifyListeners();
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> register(String email, String password) async {
    final response = await _apiService.register(email, password);
    if (response.statusCode != 201) {
      throw Exception('Failed to register');
    }
  }

  Future<void> checkAuthStatus() async {
    String? token = await _apiService.getToken();
    _isAuthenticated = token != null;
    notifyListeners();
  }

  Future<void> logout() async {
    await _apiService.logout();
    _isAuthenticated = false;
    notifyListeners();
  }
}
