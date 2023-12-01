import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_bloc/item/model/item_model.dart';
import 'package:test_bloc/tiker.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  late final ItemModel itemInfo;
  final _tiker = Ticker();
  StreamSubscription<int>? _tickerSubscription;

  ItemBloc({
    required this.itemInfo,
  }) : super(
          ItemState(itemInfo, ItemStatus.initial),
        ) {
    on<InitItemEvent>((event, emit) {
      _tickerSubscription?.cancel();
      _tickerSubscription = _tiker.tick().listen((_) {
        add(UpdateItemEvent());
      });
    });
    on<UpdateItemEvent>((event, emit) {
      final executionCardState = getCardState();
      emit(executionCardState);
    });
  }

  ItemState getCardState() {
    final now = DateTime.now();

    //  DateTime executionEnd = execInfo.execution.endAt;
    Duration timeUntilStart = itemInfo.startAt.difference(now);

    // Pending: Item hasnt started yet
    if (!timeUntilStart.isNegative) {
      return state.copyWith(
        itemInfo: itemInfo,
        status: ItemStatus.pending,
      );
    }
    // Expired: Item started, and doesnt have time left
    if (hasExpired(itemInfo)) {
      return state.copyWith(
        itemInfo: itemInfo,
        status: ItemStatus.expired,
      );
    }

    // Active: Item started, and still has time left

    return state.copyWith(
      itemInfo: itemInfo,
      status: ItemStatus.active,
    );
  }

  bool hasExpired(ItemModel item) => DateTime.now().isAfter(item.endAt);
  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
