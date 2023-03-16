import 'package:flutter/material.dart';

void main() {
  runApp(ParentWidget());
}

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  // Manages the _inActive state for ChildWidget.
  bool _inActive = true;

  // Implements _manageStateForChildWidget(), the method called when the box is tapped.
  void _manageStateForChildWidget(bool newValue) {
    setState(() {
      _inActive = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChildWidget(
      inActive: _inActive,
      notifyParent: _manageStateForChildWidget,
    );
  }
}

// Extends StatelessWidget because all state is handled by its parent, ParentWidget
class ChildWidget extends StatelessWidget {
  ChildWidget({
    Key? key,
    this.inActive = true,
    required this.notifyParent,
  }) : super(key: key);
  final bool inActive;

  // When a tap is detected, it notifies the parent.
  final ValueChanged<bool> notifyParent;

  void manageState() {
    notifyParent(!inActive);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Our App',
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: manageState,
        child: Container(
          child: Center(
            child: Text(
              inActive ? 'Inactive' : 'Active',
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          decoration:
              BoxDecoration(color: inActive ? Colors.red : Colors.green),
        ),
      ),
    );
  }
}
