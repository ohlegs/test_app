import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/bloc/banks_bloc/banks_bloc.dart';
import 'package:test_app/core/enum/enum_sort_type.dart';
import 'package:test_app/core/ui/screens/calculate_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "Кредитный калькулятор",
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return CalculatorBottomSheet();
            },
          );
        },
        child: const Icon(Icons.calculate_outlined),
      ),
      appBar: AppBar(title: const Text('Banks')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed:
                    () => context.read<BanksBloc>().add(
                      SortBanksEvent(EnumSortType.interestRate),
                    ),
                child: const Text('Sort by Rate'),
              ),
              ElevatedButton(
                onPressed:
                    () => context.read<BanksBloc>().add(
                      SortBanksEvent(EnumSortType.maxAmount),
                    ),
                child: const Text('Sort by Amount'),
              ),
              ElevatedButton(
                onPressed:
                    () => context.read<BanksBloc>().add(
                      SortBanksEvent(EnumSortType.maxTerm),
                    ),
                child: const Text('Sort by Term'),
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<BanksBloc, BanksState>(
              builder: (context, state) {
                if (state is BanksLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is BanksLoaded) {
                  return ListView.builder(
                    itemCount: state.banks.length,
                    itemBuilder: (context, index) {
                      final bank = state.banks[index];
                      return ListTile(
                        title: Text('${bank.bankName} - ${bank.creditName}'),
                        subtitle: Text(
                          'Rate: ${bank.interestRate}% | Max: ${bank.maxAmount} | Term: ${bank.maxTerm} months',
                        ),
                      );
                    },
                  );
                }
                if (state is BanksError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
