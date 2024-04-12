import 'dart:convert';

import 'package:fake_store/common/http/constants.dart';
import 'package:fake_store/common/http/error/api_exception.dart';
import 'package:fake_store/src/modules/products/data/model/product.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  const RemoteDataSourceImpl(this.client);

  final http.Client client;

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/products'),
          headers: commonHeaders);
      if (response.statusCode != 200) {
        throw ApiException(
            message: response.body, statusCode: response.statusCode);
      }
      final parsed = jsonDecode(response.body);
      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
