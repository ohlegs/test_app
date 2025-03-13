import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/constants.dart';
import 'package:test_app/core/data/repositories/banks_repository.dart';
import 'package:test_app/core/domain/usecases/bank_use_case.dart';
import 'package:test_app/test_app.dart';

void main() {
  //По хорошему тут нужен какой нибудь DI
  final dio = Dio(BaseOptions(baseUrl: BASE_URL));
  final repository = BanksRepository(dio: dio);
  final useCase = BankUseCase(repository: repository);

  runApp(TestApp(dio: dio, repository: repository, useCase: useCase));
}
