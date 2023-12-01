part of 'item_bloc.dart';

enum ItemStatus { initial, active, pending, expired }

class ItemState extends Equatable {
  final ItemModel itemInfo;
  final ItemStatus status;

  const ItemState(
    this.itemInfo,
    this.status,
  );

  ItemState copyWith({
    ItemModel? itemInfo,
    ItemStatus? status,
  }) {
    return ItemState(
      itemInfo ?? this.itemInfo,
      status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [itemInfo, status];
}
