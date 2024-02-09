import 'package:dio/dio.dart';
import 'package:prueba_venko_flutter/entities/user.dart';

class UserService {
  final dio = Dio();

  List<User> users = [];

  Future<void> initUsers() async {
    final responsePage1 = await Dio().get('https://reqres.in/api/users?page=1');
    final dataPage1 = responsePage1.data['data'];

    for (var user in dataPage1) {
      users.add(User.fromJson(user));
    }

    final responsePage2 = await Dio().get('https://reqres.in/api/users?page=2');
    final dataPage2 = responsePage2.data['data'];

    for (var user in dataPage2) {
      users.add(User.fromJson(user));
    }
  }

  List<User> getUsers(int page) {
    List<User> usersPage = [];
    for (int i = (page - 1) * 6; i < page * 6; i++) {
      if (i < users.length) {
        usersPage.add(users[i]);
      } else {
        break;
      }
    }
    return usersPage;
  }

  int getUserslength() {
    return users.length;
  }

  bool createUser(User user) {
    try {
      users.add(user);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool deleteUser(int id) {
    try {
      users.removeWhere((element) => element.id == id);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool editUser(User user) {
    try {
      users[users.indexWhere((element) => element.id == user.id)] = user;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    final response = await dio.post('https://reqres.in/api/login', data: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
