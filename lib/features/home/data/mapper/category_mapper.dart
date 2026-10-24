import 'package:ecommerce_app_huma_volve/features/home/data/model/category_dm.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entity/category.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesMapper {
  Category toEntity(CategoryDM categoryDM) =>
      Category(id: categoryDM.id ?? "", name: categoryDM.name ?? "");

  List<Category> toEntities(List<CategoryDM> categories) =>
      categories.map(toEntity).toList();
}
