import 'dart:developer';

import 'package:agile_crafts_task/injectors.dart';
import 'package:agile_crafts_task/src/core/database/hive_service.dart';
import 'package:agile_crafts_task/src/core/router/app_routers.dart';
import 'package:agile_crafts_task/src/features/home/view/home.dart';
import 'package:agile_crafts_task/src/features/sign_in/view/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final goNavigatorKey = GlobalKey<NavigatorState>();
bool loggedIn = false;
final GoRouter goRouter = GoRouter(
  initialLocation: AppRoutes.homeRoute,
  navigatorKey: goNavigatorKey,
  routes: <RouteBase>[
    GoRoute(path: AppRoutes.signinRoute, name: SignInView.name, builder: (_, _) => const SignInView()),
    GoRoute(path: AppRoutes.homeRoute, name: HomeView.name, builder: (_, __) => const HomeView()),
  ],
  redirect: (context, state) {
    final loggedIn = sl<HiveService>().getToken() != null;

    //  Auth
    if (!loggedIn) {
      return AppRoutes.signinRoute;
    }
    if (loggedIn) {
      return AppRoutes.homeRoute;
    }
    return null;
  },
);
