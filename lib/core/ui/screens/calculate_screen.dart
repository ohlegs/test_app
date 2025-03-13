import 'dart:math';
import 'package:flutter/material.dart';

class CalculatorBottomSheet extends StatefulWidget {
  const CalculatorBottomSheet({super.key});

  @override
  _CalculatorBottomSheetState createState() => _CalculatorBottomSheetState();
}

class _CalculatorBottomSheetState extends State<CalculatorBottomSheet> {
  final _amountController = TextEditingController();
  final _rateController = TextEditingController();
  final _termController = TextEditingController();
  double? _monthlyPayment;

  late FocusNode _amountFocusNode;

  @override
  void initState() {
    super.initState();
    _amountFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _amountFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _rateController.dispose();
    _termController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  void _calculatePayment() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    final rate = double.tryParse(_rateController.text) ?? 0;
    final term = int.tryParse(_termController.text) ?? 0;

    if (amount > 0 && rate > 0 && term > 0) {
      final monthlyRate = rate / 12 / 100;
      final payment =
          amount *
          monthlyRate *
          pow(1 + monthlyRate, term) /
          (pow(1 + monthlyRate, term) - 1);
      setState(() {
        _monthlyPayment = payment.isFinite ? payment : 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Калькулятор кредита',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            RepaintBoundary(
              child: TextField(
                controller: _amountController,
                focusNode: _amountFocusNode,
                decoration: const InputDecoration(labelText: 'Сумма кредита'),
                keyboardType: TextInputType.number,
              ),
            ),
            // RepaintBoundary добавил потому что без него анимация появления модалки ловит джанки
            RepaintBoundary(
              child: TextField(
                controller: _rateController,
                decoration: const InputDecoration(
                  labelText: 'Процентная ставка (%)',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            RepaintBoundary(
              child: TextField(
                controller: _termController,
                decoration: const InputDecoration(labelText: 'Срок (месяцы)'),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculatePayment,
              child: const Text('Рассчитать'),
            ),
            const SizedBox(height: 16),
            if (_monthlyPayment != null)
              Text(
                'Ежемесячный платеж: ${_monthlyPayment!.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
