import 'package:test_app/core/data/models/bank_model.dart';

abstract class BanksRepositoryAbstract {
  Future<List<Banks>?> getBanks();
}
