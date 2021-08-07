import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:optovik/domain/bloc/localalization/localization_cubit.dart';
import 'package:optovik/generated/l10n.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(S.of(context).language),
            leading: Icon(Icons.translate),
            subtitle: BlocBuilder<LocalizationCubit, Locale>(
              cubit: GetIt.instance.get<LocalizationCubit>(),
              builder: (context, state) => Text(
                GetIt.instance
                    .get<LocalizationCubit>()
                    .getCurrentLocaleTitle(state),
              ),
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return LanguageBottomSheet();
                },
              );
            },
          ),
          Divider()
        ],
      ),
    );
  }
}

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({Key key}) : super(key: key);

  @override
  _LanguageBottomSheetState createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  Locale current;

  @override
  void initState() {
    super.initState();
    current = GetIt.instance.get<LocalizationCubit>().currentLocale;
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => ListView(
        children: [
          ...S.delegate.supportedLocales
              .map((Locale e) => RadioListTile<Locale>(
                    value: e,
                    groupValue: current,
                    onChanged: _onChange,
                    title: Text(
                      GetIt.instance
                          .get<LocalizationCubit>()
                          .getCurrentLocaleTitle(e),
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }

  void _onChange(Locale value) {
    setState(() {
      current = value;
      GetIt.instance.get<LocalizationCubit>().setLocale(value);
    });
    Navigator.pop(context);
  }
}
