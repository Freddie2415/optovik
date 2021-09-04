import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/counter/counter_cubit.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/presentation/widgets/counter_btn.dart';

class CounterButtonWidget extends StatelessWidget {
  final CounterCubit _counterCubit;

  const CounterButtonWidget(this._counterCubit, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: _counterCubit,
      builder: (context, counter) {
        return SizedBox(
          height: 35,
          child: counter <= 0
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                  ),
                  onPressed: _counterCubit.increment,
                  child: Text(
                    S.of(context).addToCard,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : CounterBtn(
                  counter: counter,
                  onRemove: _counterCubit.decrement,
                  onAdd: _counterCubit.increment,
                ),
        );
      },
    );
  }
}
