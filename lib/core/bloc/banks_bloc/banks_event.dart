part of 'banks_bloc.dart';

@immutable
sealed class BanksEvent {}

class GetBanksEvent extends BanksEvent {}

class SortBanksEvent extends BanksEvent {
  final EnumSortType sortBy;
  SortBanksEvent(this.sortBy);
}
