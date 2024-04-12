import 'dart:convert';

import 'package:fake_store/common/http/constants.dart';
import 'package:fake_store/common/http/error/api_exception.dart';
import 'package:fake_store/src/modules/products/data/datasource/remote/remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '__test/product_test_object.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late RemoteDataSource dataSource;

  setUp(() {
    client = MockClient();
    dataSource = RemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group('getProducts', () {
    test(
        'should completes with success when server returns valid data with statusCode 200',
        () async {
      //arrange
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
          (_) async => http.Response(jsonEncode(productsTestObject), 200));

      //act
      final result = await dataSource.getProducts();

      //assert
      expect(result, productsTestObject);
      verify(() => client.get(Uri.parse('$baseUrl/products'),
          headers: commonHeaders)).called(1);
      verifyNoMoreInteractions(client);
    });

    test('Should throw exception when api returns an error response', () {
      // arrange
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('Bad request', 404));

      //act
      final result = dataSource.getProducts();

      //assert
      expect(
        result,
        throwsA(
          const ApiException(
            message: 'Bad request',
            statusCode: 404,
          ),
        ),
      );
      verify(() => client.get(Uri.parse('$baseUrl/products'),
          headers: commonHeaders)).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
