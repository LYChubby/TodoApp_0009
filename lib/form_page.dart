import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController taskController = TextEditingController();
  final key = GlobalKey<FormState>();
  List<String> daftarTask = [];

  void addTask() {
    setState(() {
      daftarTask.add(taskController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
