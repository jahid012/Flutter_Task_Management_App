import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task2do/controllers/task_controllter.dart';
import 'package:task2do/models/task.dart';
import 'package:task2do/services/theme_services.dart';
import 'package:task2do/ui/theme.dart';
import 'package:task2do/widgets/button.dart';
import 'package:task2do/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskControllter = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9.30PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

  String _selectedRepeat = "None";
  List<String> repeatList = [
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];

  int _selecetedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: headingStyle,
              ),
              InputField(
                title: "Title",
                hint: "Enter your title",
                controller: _titleController,
              ),
              InputField(
                title: "Note",
                hint: "Enter your note",
                controller: _noteController,
              ),
              InputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: InputField(
                    title: "Start Date",
                    hint: _startTime,
                    widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        )),
                  )),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: InputField(
                    title: "End Date",
                    hint: _endTime,
                    widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        )),
                  )),
                ],
              ),
              InputField(
                title: "Remind",
                hint: "$_selectedRemind minutes early",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      child: Text(value.toString()),
                      value: value.toString(),
                    );
                  }).toList(),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                ),
              ),
              InputField(
                title: "Repeat",
                hint: "$_selectedRepeat",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  items:
                      repeatList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.grey),
                      ),
                      value: value,
                    );
                  }).toList(),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorPallete(),
                  MyButton(
                      label: "Create Task",
                      onTap: () {
                        _validateData();
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 28,
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage("images/profile.png"),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      // add to Database
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon: Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    }
  }

  _addTaskToDb() async {
    int value = await _taskControllter.addTask(
        task: Task(
      note: _noteController.text,
      title: _titleController.text,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _startTime,
      endTime: _endTime,
      remind: _selectedRemind,
      repeat: _selectedRepeat,
      color: _selecetedColor,
      isCompleted: 0,
    ));
    print("My id is $value");
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selecetedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  child: _selecetedColor == index
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                  radius: 14,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : yellowClr,
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("It is null");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time canceld");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }
}
