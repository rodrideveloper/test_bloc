part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetItems extends HomeEvent {}

class CompareLists extends HomeEvent {}
