import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:optovik/domain/bloc/info/info_cubit.dart';
import 'package:optovik/domain/bloc/localalization/localization_cubit.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/domain/model/page.dart' as infoPage;
import 'package:optovik/presentation/widgets/error_widget.dart';
import 'package:optovik/presentation/widgets/loading_widget.dart';

class Info extends StatelessWidget {
  final InfoCubit infoCubit;

  const Info({Key key, this.infoCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).info),
      ),
      body: BlocBuilder<InfoCubit, InfoState>(
        cubit: infoCubit..load(),
        builder: (context, state) {
          if (state is InfoSuccess) {
            return buildPageList(state.pages, context);
          }

          if (state is InfoFailure) {
            return FailureWidget(
              message: state.message,
              onBtnPressed: () {
                this.infoCubit.load();
              },
            );
          }

          return LoadingWidget();
        },
      ),
    );
  }

  Widget buildPageList(List<infoPage.Page> pages, BuildContext context) {
    String localeTag =
        GetIt.instance.get<LocalizationCubit>().currentLocale.toLanguageTag();
    return ListView(
      children: [
        Image.asset("assets/images/info-banner.jpg"),
        ...pages
            .map((e) => ListTile(
                  title: Text(
                    e.getTitle(localeTag),
                    style: TextStyle(fontSize: 14),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("OK"),
                          )
                        ],
                        title: Text(
                          e.getTitle(localeTag),
                        ),
                        content: SingleChildScrollView(
                          child: Container(
                            child: Text("${e.getContent(localeTag)}"),
                          ),
                        ),
                      ),
                    );
                  },
                ))
            .toList(),
      ],
    );
  }
}
