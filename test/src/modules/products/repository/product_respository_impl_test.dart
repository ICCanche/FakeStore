import 'package:dartz/dartz.dart';
import 'package:fake_store/common/error/api_exception.dart';
import 'package:fake_store/common/error/api_failure.dart';
import 'package:fake_store/common/error/failure.dart';
import 'package:fake_store/src/modules/products/data/datasource/remote/remote_data_source.dart';
import 'package:fake_store/src/modules/products/data/mappers/products_mapper.dart';
import 'package:fake_store/src/modules/products/data/model/product.dart';
import 'package:fake_store/src/modules/products/data/repository/product_repository_impl.dart';
import 'package:fake_store/src/modules/products/domain/entity/product_entity.dart';
import 'package:fake_store/src/modules/products/domain/repository/product_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../data/datasource/remote/__test/product_test_object.dart';

class RemoteDataSourceMock extends Mock implements RemoteDataSource {}

void main() {
  late RemoteDataSource remoteDataSource;
  late ProductRepository repository;

  setUp(() {
    remoteDataSource = RemoteDataSourceMock();
    repository = ProductRepositoryImpl(remoteDataSource);
  });

  group('getProducts', () {
    test('Should call the function and return data with success', () async {
      //arrange
      when(() => remoteDataSource.getProducts())
          .thenAnswer((_) => Future.value(productsTestObject));

      //act
      final result = await repository.getProducts();

      //assert
      expect(result, isA<Right<Failure, List<Product>>>());
      verify(() => remoteDataSource.getProducts()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('Should call the function and return ApiFailure', () async {
      //arrange
      const tException =
          ApiException(message: 'unknown error occurs', statusCode: 500);
      when(() => remoteDataSource.getProducts()).thenThrow(tException);

      //act
      final result = await repository.getProducts();

      //assert
      expect(
        result,
        equals(
          Left(
            ApiFailure(tException.message, tException.statusCode),
          ),
        ),
      );
      verify(() => remoteDataSource.getProducts()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
