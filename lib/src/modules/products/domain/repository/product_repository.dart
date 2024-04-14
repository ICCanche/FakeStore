import 'package:fake_store/common/typedef/typedef.dart';
import 'package:fake_store/src/modules/products/domain/entity/product_entity.dart';

abstract class ProductRepository {
  FutureResult<List<Product>> getProducts();
}