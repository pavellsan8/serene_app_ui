import 'package:flutter/material.dart';

enum PageState { 
  initial, 
  loading, 
  data, 
  error 
}

abstract class GenericPageViewModel<T> extends ChangeNotifier {
  PageState state = PageState.initial;
  String errorMessage = '';
  List<T> items = [];

  // Abstract method to be implemented by specific view models
  Future<List<T>> fetchData();

  // Initialize and fetch data
  Future<void> initialize() async {
    state = PageState.loading;
    notifyListeners();
    try {
      items = await fetchData();
      state = items.isNotEmpty ? PageState.data : PageState.error;
    } catch (e) {
      errorMessage = e.toString();
      state = PageState.error;
    }
    notifyListeners();
  }

  // Refresh items with the ability to pass a custom fetch function
  Future<void> refreshItems(Future<List<T>> Function()? customFetchData) async {
    state = PageState.loading;
    notifyListeners();
    try {
      // Use custom fetch function if provided, otherwise use the default
      items = customFetchData != null 
          ? await customFetchData() 
          : await fetchData();
      
      state = items.isNotEmpty ? PageState.data : PageState.error;
    } catch (e) {
      errorMessage = e.toString();
      state = PageState.error;
    }
    notifyListeners();
  }
}