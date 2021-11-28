import 'dart:ui';

import 'package:cal/logic/bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  void show(BuildContext ctx) {
    showModalBottomSheet(
        backgroundColor: Colors.white10,
        barrierColor: Colors.black,
        isScrollControlled: true,
        context: ctx,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        builder: (context) {
          return BlocProvider.value(
            value: BlocProvider.of<CalculatorBloc>(ctx),
            child: Container(
                padding: EdgeInsets.all(20),
                height: 80.0.h,
                child: BlocBuilder<CalculatorBloc, CalculatorState>(
                  builder: (context, state) {
                    List<Result> results = state.results.reversed.toList();
                    return ListView.builder(
                        itemCount: state.results.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide(width: 0.5))),
                            child: ListTile(
                              onTap: () {
                                context.read<CalculatorBloc>().add(
                                    CalculatorResultEvent(
                                        result: results[index].result));
                                Navigator.pop(context);
                              },
                              title: Text(
                                results[index].result,
                                style: TextStyle(fontSize: 30.0.sp),
                              ),
                              subtitle: Text(
                                results[index].data,
                                style: TextStyle(fontSize: 20.0.sp),
                              ),
                            ),
                          );
                        });
                  },
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Calculator",
          style: TextStyle(fontSize: 20.0.sp),
        ),
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              show(context);
            },
            child: Container(
                margin: const EdgeInsets.only(right: 15),
                child: const Icon(
                  Icons.history,
                  size: 30,
                )),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 35.0.h,
            // margin: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 90.0.w,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 2, color: Colors.black12))),
                  alignment: Alignment.centerRight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      context.watch<CalculatorBloc>().state.text,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.clip,
                      style: TextStyle(fontSize: 50.0.sp),
                    ),
                  ),
                ),
                Container(
                  width: 80.0.w,
                  child: Text(
                    context.watch<CalculatorBloc>().state.result,
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 30.0.sp),
                  ),
                )
              ],
            ),
          ),
          Flexible(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 2.0.h),
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomContainer("("),
                      CustomContainer(")"),
                      CustomContainer("="),
                      CustomCircleContainer("C"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomContainer("1"),
                      CustomContainer("2"),
                      CustomContainer("3"),
                      CustomCircleContainer("/"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomContainer("7"),
                      CustomContainer("8"),
                      CustomContainer("9"),
                      CustomCircleContainer("*"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomContainer("4"),
                      CustomContainer("5"),
                      CustomContainer("6"),
                      CustomCircleContainer("-"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomContainer("1"),
                      CustomContainer("2"),
                      CustomContainer("3"),
                      CustomCircleContainer("+"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomContainer("0"),
                      CustomContainer("%"),
                      CustomContainer("."),
                      InkWell(
                        onTap: () {
                          context
                              .read<CalculatorBloc>()
                              .add(CalculatorBackEvent());
                        },
                        child: Container(
                          width: 20.0.w,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.backspace,
                            size: 25,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final String text;
  CustomContainer(this.text);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<CalculatorBloc>().add(CalculatorAddEvent(character: text));
      },
      child: Container(
        width: 20.0.w,
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30.0.sp),
        ),
      ),
    );
  }
}

class CustomCircleContainer extends StatelessWidget {
  final String text;
  CustomCircleContainer(this.text);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<CalculatorBloc>().add(CalculatorAddEvent(character: text));
      },
      child: Container(
        width: 20.0.w,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(fontSize: 30.0.sp, color: Colors.pinkAccent),
        ),
      ),
    );
  }
}
