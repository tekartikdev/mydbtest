import 'package:flutter/material.dart';

class ModalFit extends StatelessWidget {
  const ModalFit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('you selected $key'),
            leading: const Icon(Icons.edit),
            onTap: () => Navigator.of(context).pop(),
          ),
          const ListTile(
            title: Text(
                'This is the definition of the text.  It means this and that and also this too.'),
          )
        ],
      ),
    ));
  }
}
