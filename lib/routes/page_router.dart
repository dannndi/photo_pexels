import 'package:flutter/material.dart';
import 'package:photo_pexels/module/detail_photo/detail_photo_page.dart';
import 'package:photo_pexels/module/edit_photo/edit_photo_page.dart';
import 'package:photo_pexels/module/home/home_page.dart';
import 'package:photo_pexels/module/search/search_page.dart';
import 'package:photo_pexels/module/settings/setting_page.dart';
import 'package:photo_pexels/routes/page_name.dart';

class PageRouter {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case PageName.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );

      case PageName.settings:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const SettingPage(),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              child: child,
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
            );
          },
        );

      case PageName.search:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const SearchPage(),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              child: child,
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
            );
          },
        );

      case PageName.detailPhoto:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const DetailPhotoPage(),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              child: child,
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
            );
          },
        );

      case PageName.editPhoto:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => EditPhotoPage(),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              child: child,
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
            );
          },
        );
    }
    return null;
  }
}
