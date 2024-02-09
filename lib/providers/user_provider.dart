
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_venko_flutter/api/user_api_service.dart';

final userProvider = Provider<UserService>((ref) {
  final userProvider =
      UserService();
  return userProvider;
});