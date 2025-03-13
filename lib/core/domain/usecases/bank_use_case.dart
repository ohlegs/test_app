import 'package:test_app/core/data/models/bank_model.dart';
import 'package:test_app/core/data/repositories/banks_repository.dart';
import 'package:test_app/core/domain/repositories/banks_repository.dart';

class BankUseCase {
  final BanksRepositoryAbstract _repository;

  BankUseCase({required BanksRepository repository}) : _repository = repository;

  Future<List<Banks>?> getBanks() async {
    return await _repository.getBanks();
  }
}
