import 'package:fake_store/src/modules/products/data/model/product.dart';
import 'package:fake_store/src/modules/products/domain/entity/product_entity.dart';

Product mapProductModelToEntity(ProductModel model) => Product(
      id: model.id,
      title: model.title,
      price: model.price,
      description: model.description,
      category: model.category,
      image: model.image,
      rating: Rating(
        rate: model.rating.rate,
        count: model.rating.count,
      ),
    );

List<Product> mapProductModelsToEntityList(List<ProductModel> models) {
  return models.map((model) => mapProductModelToEntity(model)).toList();
}