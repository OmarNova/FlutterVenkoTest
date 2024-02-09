import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_venko_flutter/entities/user.dart';
import 'package:prueba_venko_flutter/providers/user_provider.dart';
import 'package:prueba_venko_flutter/widgets/user_form.dart';
import 'package:prueba_venko_flutter/widgets/usercard.dart';

class UserListScreen extends ConsumerStatefulWidget {
  const UserListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  int currentPage = 1;
  List<User> users = [];

  @override
  void initState() {
    users = ref.read(userProvider).getUsers(currentPage);
    super.initState();
  }

  void _loadUsers() {
    users = ref.watch(userProvider).getUsers(currentPage);
    if (users.isEmpty) {
      currentPage--;
      users = ref.watch(userProvider).getUsers(currentPage);
    }
  }

  void nextPage() {
    setState(() {
      currentPage++;
      _loadUsers();
    });
  }

  void previousPage() {
    setState(() {
      if (currentPage > 1) {
        currentPage--;
        _loadUsers();
      }
    });
  }

  void deleteUser(int id) {
    ref.read(userProvider).deleteUser(id);
    setState(() {
      _loadUsers();
    });
  }

  void editUser(int id) {
    final resultEdit = showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: UserForm(
            createOrEdit: false,
            id: id,
          ),
        ),
      ),
    );
    resultEdit.then((value) {
      if (value != null) {
        setState(() {
          _loadUsers();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                final resultCreate = showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: const UserForm(
                        createOrEdit: true,
                      ),
                    ),
                  ),
                );
                resultCreate.then((value) {
                  if (value != null) {
                    setState(() {
                      _loadUsers();
                    });
                  }
                });
              },
              child: const Text("Crear Usuario")),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return UserCard(
                  nombre: user.firstname,
                  apellido: user.lastname,
                  avatarUrl: user.avatar,
                  email: user.email,
                  id: user.id,
                  delete: deleteUser,
                  edit: editUser,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: previousPage,
              ),
              const SizedBox(width: 20.0),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: nextPage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
