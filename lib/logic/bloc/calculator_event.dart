part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorEvent {}

class CalculatorAddEvent extends CalculatorEvent {
  String character;
  CalculatorAddEvent({
    required this.character,
  });
}

class CalculatorResultEvent extends CalculatorEvent {
  String result;
  CalculatorResultEvent({
    required this.result,
  });
}

class CalculatorBackEvent extends CalculatorEvent {}
