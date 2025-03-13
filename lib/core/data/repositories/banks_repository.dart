import 'package:dio/dio.dart';
import 'package:test_app/core/data/models/bank_model.dart';
import 'package:test_app/core/domain/repositories/banks_repository.dart';
import 'package:test_app/core/utils/logger.dart';

class BanksRepository implements BanksRepositoryAbstract {
  late final Dio _dio;
  BanksRepository({required Dio dio}) {
    _dio = dio;
  }

  @override
  Future<List<Banks>?> getBanks() async {
    try {
      final response = await _dio.get('/banks-api/banks.json');
      final List<Banks> banks =
          (response.data as List).map((e) => Banks.fromJson(e)).toList();
      return banks;
    } on DioException catch (e) {
      logger.e('DioException: ${e.message}');
      return null;
    } catch (e) {
      logger.e('Unexpected error: $e');
      return null;
    }
  }
}
