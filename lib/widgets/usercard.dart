import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserCard extends ConsumerStatefulWidget {
  final int id;
  final String nombre;
  final String apellido;
  final String avatarUrl;
  final String email;
  final Function delete;
  final Function edit;

  const UserCard({
    super.key,
    required this.nombre,
    required this.apellido,
    required this.avatarUrl,
    required this.email,
    required this.id,
    required this.delete,
    required this.edit,
  });

  
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserCardState();
}

class _UserCardState extends ConsumerState<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.avatarUrl),
        ),
        title: Text('${widget.nombre} ${widget.apellido}'),
        subtitle: Text(widget.email),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                widget.edit(widget.id);
                
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                widget.delete(widget.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

