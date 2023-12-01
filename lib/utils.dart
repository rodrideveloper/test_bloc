import 'package:jiffy/jiffy.dart';
import 'package:test_bloc/item/item_bloc/item_bloc.dart';
import 'package:intl/intl.dart';

const stateText = 'state';
const cooldown = 'cooldown';

Map<String, dynamic> getText(
  ItemState state,
) {
  Map<String, String> text = {
    stateText: 'pending',
    cooldown: 'Siguiente en  ${getAmountString(state.itemInfo.startAt)}'
  };

  switch (state.status) {
    case ItemStatus.active:
      text[stateText] = 'active';
      text[cooldown] = 'Expire at ${getAmountString(state.itemInfo.endAt)}';
      return text;

    case ItemStatus.expired:
      text[stateText] = 'Expire';
      text[cooldown] = getFormated(state.itemInfo.endAt);

      return text;
    default:
      return text;
  }
}

String getFormated(DateTime itemEnd) =>
    DateFormat('dd-MM-yyyy').format(DateTime.parse(itemEnd.toString()));

String getAmountString(DateTime date) {
  final timeSinceString =
      Jiffy.parseFromDateTime(date).toNow(withPrefixAndSuffix: false);

  if (isDateWithinHour(date)) {
    return formatDuration(date.difference(DateTime.now())).substring(3);
  }

  return timeSinceString;
}

bool isDateWithinHour(DateTime date) {
  final Duration difference = DateTime.now().difference(date);
  const Duration hourDuration = Duration(hours: 1);

  return difference.abs() <= hourDuration;
}

String formatDuration(Duration d) =>
    d.toString().split('.').first.padLeft(8, "0");
