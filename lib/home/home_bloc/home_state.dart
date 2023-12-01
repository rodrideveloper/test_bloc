part of 'home_bloc.dart';

enum ListStatus { loading, empty, completed }

class HomeState extends Equatable {
  final ActivesModel actives;
  final PendingsModel pendings;
  final ExpiresModel expires;
  final ListStatus status;

  const HomeState(
    this.actives,
    this.pendings,
    this.expires,
    this.status,
  );

  HomeState copyWith({
    ActivesModel? actives,
    PendingsModel? pendings,
    ExpiresModel? expires,
    ListStatus? status,
  }) {
    return HomeState(
      actives ?? this.actives,
      pendings ?? this.pendings,
      expires ?? this.expires,
      status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [actives, pendings, expires, status];
}
