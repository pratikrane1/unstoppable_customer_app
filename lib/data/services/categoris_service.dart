import 'dart:convert';

import 'package:http/http.dart';

class CategoryService {

  static const Per_Page = 15;
  final baseUrl = "https://unstoppabletrade.in/customer_app/categories";

  Future<List<dynamic>> fetchCategory(int perPage, int startFrom) async {
    try {
      final response = await get(Uri.parse("$baseUrl?per_page=$Per_Page&start_from=$startFrom"));
      return jsonDecode(response.body) as List<dynamic>;
    } catch (err) {
      return [];
    }
  }
  
}