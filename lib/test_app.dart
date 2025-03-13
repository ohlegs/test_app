import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/bloc/banks_bloc/banks_bloc.dart';
import 'package:test_app/core/data/repositories/banks_repository.dart';
import 'package:test_app/core/domain/usecases/bank_use_case.dart';
import 'package:test_app/core/ui/screens/home_screen.dart';

class TestApp extends StatelessWidget {
  final Dio dio;
  final BanksRepository repository;
  final BankUseCase useCase;

  const TestApp({
    required this.dio,
    required this.repository,
    required this.useCase,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BanksBloc(getBanks: useCase)..add(GetBanksEvent()),
      child: const MaterialApp(home: HomeScreen()),
    );
  }
}
