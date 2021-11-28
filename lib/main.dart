import 'package:cal/logic/bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ui/screens/home_page.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, constraints, orientation) => MaterialApp(
        theme: ThemeData.dark(),
        home: BlocProvider<CalculatorBloc>(
          create: (context) => CalculatorBloc(),
          child: MyHomePage(),
          lazy: false,
        ),
      ),
    );
  }
}
