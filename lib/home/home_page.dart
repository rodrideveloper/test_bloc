import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc/home/home_bloc/home_bloc.dart';
import 'package:test_bloc/home/model/home_model.dart';
import 'package:test_bloc/item/item_bloc/item_bloc.dart';
import 'package:test_bloc/item/item_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final HomeBloc homeBloc = context.read<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    homeBloc.add(GetItems());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return Column(
          children: [
            HomeList(
              state: ItemStatus.active,
              model: state.actives,
            ),
            HomeList(
              state: ItemStatus.pending,
              model: state.pendings,
            ),
            HomeList(
              state: ItemStatus.expired,
              model: state.expires,
            ),
          ],
        );
      }),
    );
  }
}

class HomeList extends StatelessWidget {
  HomeList({
    super.key,
    required this.model,
    required this.state,
  });
  final HomeModel model;
  final ItemStatus state;

  final Map<ItemStatus, String> title = {
    ItemStatus.pending: "Pendiente",
    ItemStatus.active: "Activo",
    ItemStatus.expired: "Expirado",
  };

  @override
  Widget build(BuildContext context) {
    final items = model.items;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ExpansionTile(
          maintainState: true,
          title: Text(title[state]!),
          initiallyExpanded: true,
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.transparent),
          ),
          childrenPadding: const EdgeInsets.all(14),
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              key: UniqueKey(),
              itemBuilder: (context, index) => BlocProvider(
                create: (context) =>
                    ItemBloc(itemInfo: items[index])..add(InitItemEvent()),
                child: const SizedBox(
                  child: ItemCard(),
                ),
              ),
            ),
          ]),
    );
  }
}
