
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/model/response/task.dart';
import '../../provider/home_provider.dart';
import '../../utill/app_constants.dart';
import '../../utill/globalmethod.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  int selectedPriority = 0;
  final formKey = GlobalKey<FormState>();
  final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
  List<int> priorityList = [0, 1, 2];

  @override
  void initState() {
    super.initState();
    var homePro = Provider.of<HomeProvider>(context, listen: false);
    nameController.text = "${homePro.allTaskList.task![homePro.selectedIndex].name}";
    descriptionController.text = "${homePro.allTaskList.task![homePro.selectedIndex].description}";
    deadlineController.text = formatter.format(DateTime.fromMillisecondsSinceEpoch(homePro.allTaskList.task![homePro.selectedIndex].deadline ?? 0));
    selectedPriority = homePro.allTaskList.task![homePro.selectedIndex].priority ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider homeProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: (homeProvider.getTaskDataLoading)?
            CircularProgressIndicator()
                : (homeProvider.allTaskList.task != null && homeProvider.allTaskList.task!.isNotEmpty) ?
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: nameController,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            errorText: (nameController.text.isEmpty)? "Task Title is Empty" : null,
                            labelStyle: TextStyle(color: Colors.black),
                            label: Center(
                              child: Text("Task Title"),
                            ),
                            hintStyle: TextStyle(color: Colors.black),
                            floatingLabelAlignment: FloatingLabelAlignment.start,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 2.0,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black, width: 2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                          ),
                          onChanged: (s) {
                            formKey.currentState!.validate();
                            setState(() {});
                          },
                          validator: (val) {
                            if(nameController.text.isEmpty){
                              return "Task Title is Empty";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: descriptionController,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            errorText: (descriptionController.text.isEmpty)? "Task Description is Empty" : null,
                            labelStyle: TextStyle(color: Colors.black),
                            label: Center(
                              child: Text("Task Description"),
                            ),
                            hintStyle: TextStyle(color: Colors.black),
                            floatingLabelAlignment: FloatingLabelAlignment.start,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 2.0,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black, width: 2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                          ),
                          onChanged: (s) {
                            formKey.currentState!.validate();
                            setState(() {});
                          },
                          validator: (val) {
                            if(descriptionController.text.isEmpty){
                              return "Task Description is Empty";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: deadlineController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.calendar_month,
                              color: Colors.black,
                            ),
                            errorText: (deadlineController.text.isEmpty)? "Select a Deadline Date" : null,
                            labelText: "Select Date",
                            labelStyle: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                            errorStyle: TextStyle(color: Colors.red),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 2.0,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black, width: 2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                          ),
                          onChanged: (s) {
                            formKey.currentState!.validate();
                            setState(() {});
                          },
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());  // To hide the keyboard
                            await _selectDate(context);
                            setState(() {
                              formKey.currentState!.validate();  // Call validate manually
                            });
                          },
                          validator: (s) {
                            if(deadlineController.text.isEmpty){
                              return "Select a Deadline Date";
                            }
                            return null;
                          },
                          readOnly: true,
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Text(
                              "Priority",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        ListView(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: priorityList.map((option) {
                            return RadioListTile<int>(
                              title: Text(
                                "${AppConstants.priority[option]}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value: option,
                              groupValue: selectedPriority,
                              onChanged: (int? value) {
                                selectedPriority = value ?? 0;
                                setState(() {});
                              },
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            if(formKey.currentState!.validate()){
                              Task task = Task(
                                  name: nameController.text,
                                  description: descriptionController.text,
                                  deadline: DateTime.parse(deadlineController.text).millisecondsSinceEpoch,
                                  status: homeProvider.allTaskList.task![homeProvider.selectedIndex].status,
                                  priority: selectedPriority,
                                  created: DateTime.now().millisecondsSinceEpoch,
                                  updated: DateTime.now().millisecondsSinceEpoch
                              );
                              homeProvider.editTask(task).then((response){
                                if(response){
                                  if(context.mounted){
                                    Navigator.pop(context);
                                  }
                                }else{
                                  showToast(homeProvider.addTaskListErrorMessage);
                                }
                              });
                            }else{
                              showToast("Fill the form First.");
                            }
                          },
                          child: Card(
                            elevation: 10,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Center(
                                child: homeProvider.editTaskDataLoading ? CircularProgressIndicator() : Text("Update", style: TextStyle(
                                    color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ) : Text("No Data Found", style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold
            ),),
          ),
        );
      },
    );
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: deadlineController.text.isEmpty
            ? DateTime.parse(formatter.format(DateTime.now()))
            : DateTime.parse(deadlineController.text),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark(),
            child: child!,
          );
        },
        firstDate: DateTime.parse(formatter.format(DateTime.now())),
        lastDate: DateTime.parse(formatter.format(DateTime.now().add(Duration(days: 100)))))
        .onError((error, stackTrace) => showToast(error.toString()));
    if (picked != null) {
      deadlineController.text = formatter.format(picked);
    }
  }

}
