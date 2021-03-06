import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'global_bloc/blocs.dart';
import 'global_bloc/global_bloc.dart';

import 'presentation/utils/size_config.dart';
import 'router/router.gr.dart';
// import './presentation/utils/platform.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(100, 88, 122, 50),
    systemNavigationBarColor: Colors.grey,
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    GlobalBloc.dispose();
    super.dispose();
  }

  // final _appRouter = AppRouter();
  final _appRouter = AppRouter();

  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: GlobalBloc.blocProviders,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return ScreenUtilInit(
                    designSize: const Size(360, 690),
                    minTextAdapt: true,
                    splitScreenMode: true,
                    builder: () => GlobalLoaderOverlay(
                      child: MaterialAppWidget(
                        appRouter: _appRouter,
                        buildThemeData: _buildThemeData(),
                        scaffoldMessengerKey: _messengerKey,
                        authState: state,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  ThemeData _buildThemeData() {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: const Color(0xFFFDEFF4),
        titleTextStyle: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFB3541E),
          fontStyle: FontStyle.italic,
          fontFamily: GoogleFonts.openSans().fontFamily,
          letterSpacing: 1.0,
        ),
      ),
      iconTheme: const IconThemeData().copyWith(
        size: 20.h,
      ),
      elevatedButtonTheme: elevatedButtonTheme(),
      textTheme: textTheme(),
    );
  }
}

class CupertinoAppWidget extends StatelessWidget {
  const CupertinoAppWidget({
    Key? key,
    required AppRouter appRouter,
    required ThemeData buildThemeData,
  })  : _appRouter = appRouter,
        _buildThemeData = buildThemeData,
        super(key: key);

  final AppRouter _appRouter;
  final ThemeData _buildThemeData;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _buildThemeData,
      child: CupertinoApp.router(
        builder: (context, child) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
          Locale('es', ''), // Spanish, no country code
        ],
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
      ),
    );
  }
}

class MaterialAppWidget extends StatelessWidget {
  const MaterialAppWidget({
    Key? key,
    required AppRouter appRouter,
    required ThemeData buildThemeData,
    required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
    required this.authState,
  })  : _appRouter = appRouter,
        _buildThemeData = buildThemeData,
        _scaffoldMessengerKey = scaffoldMessengerKey,
        super(key: key);

  final AppRouter _appRouter;
  final ThemeData _buildThemeData;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey;
  final AuthState authState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      builder: (context, child) {
        ScreenUtil.setContext(context);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('es', ''), // Spanish, no country code
      ],
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: AutoRouterDelegate.declarative(
        _appRouter,
        routes: (_) => [
          // if the user is logged in, they may proceed to the main App
          if (authState is Authenticated)
            const HomeScreenRoute()
          // if they are not logged in, bring them to the Login page
          else
            const LoginRoute(),
        ],
      ),
      theme: _buildThemeData,
    );
  }
}

elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    // style: ButtonStyle(
    //   backgroundColor: MaterialStateProperty.all(const Color(0xFFb1c795)),
    //   foregroundColor: MaterialStateProperty.all(Colors.white),
    //   padding: MaterialStateProperty.all(
    //     EdgeInsets.symmetric(vertical: 14.h),
    //   ),
    // ),
    style: ElevatedButton.styleFrom(
      primary: const Color(0xFFb1c795),
      onPrimary: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 14.h),
    ),
  );
}

textTheme() {
  return GoogleFonts.openSansTextTheme().copyWith(
    headline1: TextStyle(
      fontSize: 90.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
    ),
    headline2: TextStyle(
      fontSize: 60.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
    ),
    headline3: TextStyle(
      fontSize: 48.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    headline4: TextStyle(
      fontSize: 34.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    headline5: TextStyle(
      fontSize: 25.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    headline6: TextStyle(
      fontSize: 20.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    subtitle1: TextStyle(
      fontSize: 16.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    subtitle2: TextStyle(
      fontSize: 14.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    bodyText1: TextStyle(
      fontSize: 16.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    bodyText2: TextStyle(
      fontSize: 14.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    button: TextStyle(
      fontSize: 14.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    caption: TextStyle(
      fontSize: 12.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
    overline: TextStyle(
      fontSize: 10.sp,
      fontFamily: GoogleFonts.openSans().fontFamily,
      color: const Color(0xff323232),
    ),
  );
}
