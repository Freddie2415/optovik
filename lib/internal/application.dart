import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optovik/data/api/service/banner_service.dart';
import 'package:optovik/domain/bloc/auth/auth_bloc.dart';
import 'package:optovik/domain/bloc/banner/banner_cubit.dart';
import 'package:optovik/generated/l10n.dart';
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
      title: 'Optovik',
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
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
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