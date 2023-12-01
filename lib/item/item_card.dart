import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc/home/home_bloc/home_bloc.dart';
import 'package:test_bloc/item/counter.dart';
import 'package:test_bloc/item/item_bloc/item_bloc.dart';
import 'package:test_bloc/item/item_detail.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({super.key});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemBloc, ItemState>(
      // La primera vez que el estado del los itemsCard es initial no llamo al listener
      // porque si no queda en un blucle infinito.
      listenWhen: (previous, current) =>
          (previous.status == ItemStatus.initial) ? false : true,
      listener: (context, state) {
        // Cuando el ItemBloc cambia el estado, busco y aviso al HomeBloc para
        // actualizar las listas.
        BlocProvider.of<HomeBloc>(context).add(CompareLists());
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ItemDetail(),
                  settings: RouteSettings(
                    arguments: BlocProvider.of<ItemBloc>(context),
                  ),
                ));
          },
          child: Card(
            child: Column(
              children: [
                Text(state.itemInfo.name),
                Text(state.status.name),
                Counter(
                  state: state,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
