import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc/item/counter.dart';
import 'package:test_bloc/item/item_bloc/item_bloc.dart';

class ItemDetail extends StatefulWidget {
  const ItemDetail({super.key});

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  late final ItemBloc bloc =
      (ModalRoute.of(context)!.settings.arguments as ItemBloc);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemBloc, ItemState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.itemInfo.name,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  state.status.name,
                  style: TextStyle(fontSize: 20),
                ),
                Counter(state: state)
              ],
            ),
          ),
        );
      },
    );
  }
}
