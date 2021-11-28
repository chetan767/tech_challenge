import 'package:bloc/bloc.dart';
import 'package:expression_language/expression_language.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState>
    with HydratedMixin {
  CalculatorBloc() : super(CalculatorState(text: "")) {}

  var expressionGrammarDefinition = ExpressionGrammarParser({});

  @override
  Stream<CalculatorState> mapEventToState(
    CalculatorEvent event,
  ) async* {
    if (event is CalculatorAddEvent) {
      if (event.character == 'C') {
        yield state.copyWith(text: "", result: "");
      } else if (event.character == '=') {
        if (state.results.isNotEmpty &&
            state.results.last.result == state.text) {
          print("Www");
        } else {
          var parser = expressionGrammarDefinition.build();

          try {
            var now = state.text;
            if (now.endsWith('%')) {
              now = '/100';
            } else if (now.contains('%')) {
              now = '/100*';
            }

            var result = parser.parse(state.text.replaceFirst('%', now));
            var expression = result.value as Expression;
            var value = expression.evaluate();

            List<Result> cal = state.results.toList();

            if (cal.length > 10) {
              cal.removeLast();
            }

            cal.add(Result(result: value.toString(), data: state.text));

            yield state.copyWith(
                text: value.toString(), result: "", results: cal);

            print(state
                .copyWith(
                  text: "",
                  result: "",
                )
                .toJson());
          } catch (e) {
            print(e);
            yield state.copyWith(
              text: "Invalid",
            );
          }
        }
      } else {
        yield state.copyWith(text: state.text + event.character);

        var parser = expressionGrammarDefinition.build();
        try {
          var now = state.text;
          if (now.endsWith('%')) {
            now = '/100';
          } else if (now.contains('%')) {
            now = '/100*';
          }

          var result = parser.parse(state.text.replaceFirst('%', now));
          var expression = result.value as Expression;
          var value = expression.evaluate();
          yield state.copyWith(text: state.text, result: value.toString());
        } catch (e) {
          yield state.copyWith(text: state.text, result: "");
        }
      }
    } else if (event is CalculatorResultEvent) {
      yield state.copyWith(text: event.result);
    } else if (event is CalculatorBackEvent) {
      yield state.copyWith(
          text: state.text.substring(0, state.text.length - 1));

      var parser = expressionGrammarDefinition.build();
      try {
        var now = state.text;
        if (now.endsWith('%')) {
          now = '/100';
        } else if (now.contains('%')) {
          now = '/100*';
        }

        var result = parser.parse(state.text.replaceFirst('%', now));
        var expression = result.value as Expression;
        var value = expression.evaluate();
        yield state.copyWith(text: state.text, result: value.toString());
      } catch (e) {
        yield state.copyWith(text: state.text, result: "");
      }
    }
  }

  @override
  CalculatorState? fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return CalculatorState.fromMap(json);
    }
    return CalculatorState(text: "");
  }

  @override
  Map<String, dynamic>? toJson(CalculatorState state) {
    return state.toMap();
  }
}
