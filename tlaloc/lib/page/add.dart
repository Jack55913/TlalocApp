import 'package:flutter/material.dart';
import 'package:tlaloc/models/add_model.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyAdds();
  }
}

class MyAdds extends StatelessWidget {
  const MyAdds({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MyAddPage();
  }
}