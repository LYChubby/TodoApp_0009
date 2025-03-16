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

  bool isChecked = false;

  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2021, 7, 25),
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
    );

    setState(() {
      selectedDate = pickedDate;
    });
  }

  void addTask() {
    setState(() {
      daftarTask.add(taskController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Form Page',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 20,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Task Date :',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            selectedDate != null
                                ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                : 'No date selected',
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: _selectDate,
                        icon: Icon(Icons.date_range, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    spacing: 15,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: taskController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a task';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            labelText: "Add Task",
                            hintText: "Input Task",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          if (key.currentState!.validate()) {
                            addTask();
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "List Task",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: daftarTask.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.indigo[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        daftarTask[index],
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        "Deadline : ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} ",
                                      ),
                                      Text(
                                        "Not Done",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  Checkbox(
                                    checkColor: Colors.white,
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
