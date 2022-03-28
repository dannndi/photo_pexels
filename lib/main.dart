import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_pexels/dependency_injection.dart';
import 'package:photo_pexels/routes/page_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_pexels/theme/cubit/theme_cubit.dart';
import 'package:photo_pexels/theme/theme_application.dart';
import 'data/constans/http_override.dart';
import 'theme/cubit/theme_cubit.dart';

void main() {
  if (!kReleaseMode) {
    // This should be used while in development mode,\
    // do NOT do this when you want to release to production,
    // the aim of this answer is to make the development a bit easier for you,
    // for production, you need to fix your certificate issue and use it properly,
    // look at the other answers for this as it might be helpful for your case.
    HttpOverrides.global = MyHttpOverrides();
  }

  setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()..checkTheme()),
      ],
      child: const _MyApp(),
    );
  }
}

class _MyApp extends StatelessWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Photo Pexels',
          themeMode: state.theme,
          theme: ThemeApplication.light,
          darkTheme: ThemeApplication.dark,
          onGenerateRoute: PageRouter.generate,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
