import 'dart:async';

import 'package:test_bloc/item/model/item_model.dart';

class ItemService {
  final _controller = StreamController<List<ItemModel>>();
  Stream<List<ItemModel>> getItems() {
    _controller.add(getMockItems());
    return _controller.stream;
  }
}

List<ItemModel> getMockItems() {
  final items = [
    ItemModel(
        name: 'item1',
        startAt: DateTime.now().add(const Duration(seconds: 20)),
        endAt: DateTime.now().add(const Duration(seconds: 40))),
    ItemModel(
      name: 'item2',
      startAt: DateTime.now().add(const Duration(seconds: 80)),
      endAt: DateTime.now().add(const Duration(seconds: 120)),
    ),
    ItemModel(
      name: 'item3',
      startAt: DateTime.now().add(const Duration(seconds: 150)),
      endAt: DateTime.now().add((const Duration(seconds: 200))),
    )
  ];

  return List.from(items);
}
