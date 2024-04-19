import 'package:dartz/dartz.dart';
import 'package:fake_store/common/error/api_exception.dart';
import 'package:fake_store/common/error/api_failure.dart';
import 'package:fake_store/common/typedef/typedef.dart';
import 'package:fake_store/src/modules/products/data/datasource/remote/remote_data_source.dart';
import 'package:fake_store/src/modules/products/data/mappers/products_mapper.dart';
import 'package:fake_store/src/modules/products/domain/entity/product_entity.dart';
import 'package:fake_store/src/modules/products/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl(this._remoteDataSource);

  final RemoteDataSource _remoteDataSource;

  @override
  FutureResult<List<Product>> getProducts() async {
    try {
      final productsModel = await _remoteDataSource.getProducts();
      return Right(mapProductModelsToEntityList(productsModel));
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
