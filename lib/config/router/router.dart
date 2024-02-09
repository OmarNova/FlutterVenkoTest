
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_venko_flutter/screen/login_screen.dart';
import 'package:prueba_venko_flutter/screen/user_list_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(key: state.pageKey),
      ),
      GoRoute(
        path: '/userlist',
        builder: (context, state) => UserListScreen(key: state.pageKey),
      ),
    ],
  );
});