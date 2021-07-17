import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optovik/data/api/service/banner_service.dart';
import 'package:optovik/domain/bloc/auth/auth_bloc.dart';
import 'package:optovik/domain/bloc/banner/banner_cubit.dart';
import 'package:optovik/internal/dependencies/auth_module.dart';
import 'package:optovik/presentation/pages/banners.dart';
import 'package:optovik/presentation/pages/home.dart';
import 'package:optovik/presentation/widgets/loading_widget.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final BannerCubit bannerCubit = BannerCubit(bannerService: BannerService());

    return MaterialApp(
      title: 'Optovik.uz',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          headline1: GoogleFonts.comfortaa(textStyle: textTheme.headline1),
          headline2: GoogleFonts.comfortaa(textStyle: textTheme.headline2),
          headline3: GoogleFonts.comfortaa(textStyle: textTheme.headline3),
          headline4: GoogleFonts.comfortaa(textStyle: textTheme.headline4),
          headline5: GoogleFonts.comfortaa(textStyle: textTheme.headline5),
          headline6: GoogleFonts.comfortaa(textStyle: textTheme.headline6),
          subtitle1: GoogleFonts.comfortaa(textStyle: textTheme.subtitle1),
          subtitle2: GoogleFonts.comfortaa(textStyle: textTheme.subtitle2),
          bodyText1: GoogleFonts.comfortaa(textStyle: textTheme.bodyText1),
          bodyText2: GoogleFonts.comfortaa(textStyle: textTheme.bodyText2),
          button: GoogleFonts.comfortaa(textStyle: textTheme.button),
          caption: GoogleFonts.comfortaa(textStyle: textTheme.caption),
          overline: GoogleFonts.comfortaa(textStyle: textTheme.overline),
        ),
        primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
        primaryIconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      localizationsDelegates: [
        CustomLocalizationDelegate(),
      ],
      home: BlocListener<BannerCubit, BannerState>(
        cubit: bannerCubit..loadBanners(),
        listener: (context, state) {
          if (state is BannerFailure) {
            AuthModule.authBloc().add(AppStarted());
            Navigator.pushReplacement(context, HomePage.route());
          }
        },
        child: BlocBuilder<BannerCubit, BannerState>(
          cubit: bannerCubit,
          builder: (context, state) {
            if (state is BannerSuccess) {
              return BannersPage(imgList: state.banners);
            }
            return Scaffold(body: LoadingWidget());
          },
        ),
      ),
    );
  }
}

class DummyDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) => [];

  @override
  Widget buildLeading(BuildContext context) =>
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () => Navigator.of(context).pop(),
      );

  @override
  Widget buildResults(BuildContext context) => Text('Result');

  @override
  Widget buildSuggestions(BuildContext context) => Text('Suggestion');
}

class CustomLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const CustomLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      SynchronousFuture<MaterialLocalizations>(const CustomLocalization());

  @override
  bool shouldReload(CustomLocalizationDelegate old) => false;

  @override
  String toString() => 'CustomLocalization.delegate(ru_Ru)';
}

class CustomLocalization extends DefaultMaterialLocalizations {
  const CustomLocalization();

  @override
  String get searchFieldLabel => "Поиск товаров";
}
