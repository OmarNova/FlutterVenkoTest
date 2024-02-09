import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_venko_flutter/entities/user.dart';
import 'package:prueba_venko_flutter/providers/user_provider.dart';

class UserForm extends ConsumerStatefulWidget {
  final bool createOrEdit;
  final int? id;
  const UserForm({required this.createOrEdit, this.id, Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserFormState();
}

class _UserFormState extends ConsumerState<UserForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _jobController = TextEditingController();
  final _emailController = TextEditingController();

  void createUser(User user) {
    final userCreate = ref.read(userProvider).createUser(user);
    if (userCreate) {
      context.pop(userCreate);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario creado correctamente')),
      );
    }
  }

  void editUser(User user) {
    final userEdit = ref.read(userProvider).editUser(user);
    if (userEdit) {
      context.pop(userEdit);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario editado correctamente')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Apellido'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el apellido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _jobController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el trabajo';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Trabajo'),
              ),
              TextFormField(
                controller: _emailController,
                decoration:
                    const InputDecoration(labelText: 'Correo electrónico'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el correo electronico';
                  }
                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return 'El correo electrónico no es válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              widget.createOrEdit
                  ? ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final user = User(
                              id: ref.read(userProvider).getUserslength() + 1,
                              firstname: _nameController.text,
                              lastname: _lastNameController.text,
                              job: _jobController.text,
                              email: _emailController.text,
                              avatar:
                                  "https://c1.klipartz.com/pngpicture/554/218/sticker-png-circle-silhouette-user-profile-user-interface-black-head-blackandwhite-logo.png");

                          createUser(user);
                        }
                      },
                      child: const Text("Crear usuario"),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final user = User(
                              id: widget.id!,
                              firstname: _nameController.text,
                              lastname: _lastNameController.text,
                              job: _jobController.text,
                              email: _emailController.text,
                              avatar:
                                  "https://c1.klipartz.com/pngpicture/554/218/sticker-png-circle-silhouette-user-profile-user-interface-black-head-blackandwhite-logo.png");

                          editUser(user);
                        }
                      },
                      child: const Text('Editar usuario'),
                    ),
            ],
          ),
        ));
  }
}
