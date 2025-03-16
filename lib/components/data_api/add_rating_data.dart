import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  static Future<void> saveTransaction({
    required BuildContext context,
    required String id,
    required int rating,
    required String review,
  }) async {
    if (id.isEmpty || rating <= 0 || review.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all information!')),
      );
      return;
    }

    try {
      final url = Uri.parse('http://3.25.92.254:5000/api/rating');

      final transactionData = {
        'order_id': id,
        'order_rating': rating,
        'order_review': review,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(transactionData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved transaction successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save failed ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã xảy ra lỗi: $e')),
      );
    }
  }
}
