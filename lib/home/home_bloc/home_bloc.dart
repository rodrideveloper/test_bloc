import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:test_bloc/home/model/home_model.dart';
import 'package:test_bloc/item/model/item_model.dart';
import 'package:test_bloc/services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<ItemModel> items = [];

  late final ItemService _itemService;

  HomeBloc({required ItemService itemService})
      : _itemService = itemService,
        super(
          HomeState(
            ActivesModel(items: []),
            PendingsModel(items: []),
            ExpiresModel(items: []),
            ListStatus.loading,
          ),
        ) {
    on<GetItems>((event, Emitter<HomeState> emit) async {
      emit(state.copyWith(status: ListStatus.loading));

      await emit.onEach<List<ItemModel>>(_itemService.getItems(),
          onData: (List<ItemModel> data) {
        items = data;
        add(CompareLists());
      });
    });

    on<CompareLists>((event, emit) {
      final homeViewState = getHomeBlocState();
      emit(homeViewState);
    });
  }

  HomeState getHomeBlocState() {
    List<ItemModel> actives = [];
    List<ItemModel> pendings = [];
    List<ItemModel> expires = [];

    final now = DateTime.now();

    // Determine the state of each Execution
    items.forEach((i) {
      bool isPending = now.isBefore(i.startAt);
      bool isExpired = now.isAfter(i.endAt);

      if (isPending) {
        pendings.add(i);
        return;
      }
      if (isExpired) {
        expires.add(i);
        return;
      }
      // Else is Active
      actives.add(i);
    });
    actives.sort((a, b) => a.endAt.compareTo(b.endAt));
    pendings.sort((a, b) => a.endAt.compareTo(b.endAt));
    expires.sort((a, b) => a.endAt.compareTo(b.endAt));

    return state.copyWith(
      status: items.isEmpty ? ListStatus.empty : ListStatus.completed,
      actives: ActivesModel(
        items: actives,
      ),
      pendings: PendingsModel(
        items: pendings,
      ),
      expires: ExpiresModel(
        items: expires,
      ),
    );
  }
}
