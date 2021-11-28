part of 'calculator_bloc.dart';

class Result {
  String result;
  String data;
  Result({
    required this.result,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'result': result,
      'data': data,
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      result: map['result'],
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Result.fromJson(String source) => Result.fromMap(json.decode(source));
}

class CalculatorState {
  String text;
  String result;
  List<Result> results;
  CalculatorState({
    required this.text,
    this.result = '',
    this.results = const [],
  });

  CalculatorState copyWith({
    String? text,
    String? result,
    List<Result>? results,
  }) {
    return CalculatorState(
      text: text ?? this.text,
      result: result ?? this.result,
      results: results ?? this.results,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'result': result,
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory CalculatorState.fromMap(Map<String, dynamic> map) {
    return CalculatorState(
      text: map['text'],
      result: map['result'],
      results: List<Result>.from(map['results']?.map((x) => Result.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CalculatorState.fromJson(String source) =>
      CalculatorState.fromMap(json.decode(source));
}
