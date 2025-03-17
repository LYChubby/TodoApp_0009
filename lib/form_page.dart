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
  List<bool> isCheckedList = [];
  List<DateTime?> deadlines = [];
  String? dateError;

  DateTime? selectedDate;

  String formatTime(int hour, int minute) {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );

      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          selectedDate = pickedDateTime;
          dateError = null;
        });
      }
    }
  }

  void addTask() {
    setState(() {
      daftarTask.add(taskController.text);
      isCheckedList.add(false);
      deadlines.add(selectedDate);
      selectedDate = null;
      dateError = null; // Reset error setelah berhasil tambah task
    });
    taskController.clear();
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
                                ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} ${formatTime(selectedDate!.hour, selectedDate!.minute)}'
                                : 'No date selected',
                          ),
                          if (dateError != null)
                            Text(
                              dateError!,
                              style: TextStyle(color: Colors.red, fontSize: 12),
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
                          final isValid =
                              key.currentState!.validate() &&
                              selectedDate != null;

                          setState(() {
                            dateError =
                                selectedDate == null
                                    ? "Please select a date"
                                    : null;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Container(
                                height: 20,
                                alignment: Alignment.center,
                                child: Text(
                                  isValid
                                      ? 'Task successfully added'
                                      : 'Task failed added',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              duration: const Duration(milliseconds: 2000),
                              width: MediaQuery.of(context).size.width * 0.7,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor:
                                  isValid ? Colors.green : Colors.red,
                            ),
                          );

                          if (isValid) addTask();
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
                                        "Deadline: ${deadlines[index] != null ? '${deadlines[index]!.day}/${deadlines[index]!.month}/${deadlines[index]!.year} ${formatTime(selectedDate!.hour, selectedDate!.minute)}' : 'No date selected'}",
                                      ),
                                      Text(
                                        isCheckedList[index]
                                            ? "Done"
                                            : "Not Done",
                                        style: TextStyle(
                                          color:
                                              isCheckedList[index]
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Checkbox(
                                    checkColor: Colors.white,
                                    value: isCheckedList[index],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isCheckedList[index] = value!;
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
