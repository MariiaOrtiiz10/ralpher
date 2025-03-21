import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PopoverItem extends StatefulWidget {
  static const String routename = 'PopoverItem';
  final void Function()? deleteTab;
  const PopoverItem({super.key, this.deleteTab});

  @override
  State<PopoverItem> createState() => _PopoverItemState();
}

class _PopoverItemState extends State<PopoverItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            widget.deleteTab!();
          },
          child: Text('Delete', style: 
          TextStyle(
            fontSize: 16, 
            color: Colors.black
          )),
        ),
      ],
    );
  }
}
