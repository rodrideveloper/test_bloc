import 'package:test_bloc/item/model/item_model.dart';

class HomeModel {
  final List<ItemModel> items;

  const HomeModel({
    required this.items,
  });
}

class ActivesModel extends HomeModel {
  ActivesModel({required super.items});
}

class PendingsModel extends HomeModel {
  PendingsModel({required super.items});
}

class ExpiresModel extends HomeModel {
  ExpiresModel({required super.items});
}
