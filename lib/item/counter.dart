import 'package:flutter/material.dart';
import 'package:test_bloc/item/item_bloc/item_bloc.dart';
import 'package:test_bloc/utils.dart';

class Counter extends StatelessWidget {
  const Counter({
    super.key,
    required this.state,
  });

  final ItemState state;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          final text = getText(state);

          return Text(
            text[cooldown],
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 15,
            ),
          );
        });
  }
}
