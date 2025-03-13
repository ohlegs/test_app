import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:test_app/core/data/models/bank_model.dart';
import 'package:test_app/core/domain/usecases/bank_use_case.dart';
import 'package:test_app/core/enum/enum_sort_type.dart';

part 'banks_event.dart';
part 'banks_state.dart';

class BanksBloc extends Bloc<BanksEvent, BanksState> {
  final BankUseCase getBanks;

  BanksBloc({required this.getBanks}) : super(BanksInitial()) {
    on<GetBanksEvent>((event, emit) async {
      try {
        emit(BanksLoading());
        final List<Banks>? result = await getBanks.getBanks();
        if (result != null) emit(BanksLoaded(banks: result));
      } on DioException catch (e) {
        emit(BanksError(message: e.toString()));
      } catch (e) {
        emit(BanksError(message: e.toString()));
      }
    });

    on<SortBanksEvent>(_onSortBanks);
  }
  void _onSortBanks(SortBanksEvent event, Emitter<BanksState> emit) {
    if (state is BanksLoaded) {
      final currentState = state as BanksLoaded;
      final sortedBanks = currentState.banks.toList();
      switch (event.sortBy) {
        case EnumSortType.interestRate:
          sortedBanks.sort(
            (a, b) => a.interestRate!.compareTo(b.interestRate ?? 0),
          );
          break;
        case EnumSortType.maxAmount:
          sortedBanks.sort((a, b) => b.maxAmount!.compareTo(a.maxAmount ?? 0));
          break;
        case EnumSortType.maxTerm:
          sortedBanks.sort((a, b) => b.maxTerm!.compareTo(a.maxTerm ?? 0));
          break;
      }
      emit(BanksLoaded(banks: sortedBanks));
    }
  }
}
