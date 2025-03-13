part of 'banks_bloc.dart';

@immutable
sealed class BanksState {}

final class BanksInitial extends BanksState {}

final class BanksLoading extends BanksState {}

final class BanksLoaded extends BanksState {
  final List<Banks> banks;
  BanksLoaded({required this.banks});
}

final class BanksError extends BanksState {
  final String message;
  BanksError({required this.message});
}
