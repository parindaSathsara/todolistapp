import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolistapp/models/task_model.dart';
import 'package:todolistapp/views/message.dart';
import 'package:todolistapp/views/taskslist.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:todolistapp/presenter/main_presenter.dart';

class TaskViewPage extends StatefulWidget {
  final Tasks tasks;


  TaskViewPage({required this.tasks});

  @override
  _TaskViewPageState createState() => _TaskViewPageState();
}

class _TaskViewPageState extends State<TaskViewPage> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  Presenter presenter=Presenter();


  int _taskID = 0;
  String _taskName = "";
  String _taskDesc = "";
  String _taskDate = "";
  String _taskStatus = "";

  int status = 0;
  TextEditingController dateinput = TextEditingController();
  TextEditingController taskName = TextEditingController();
  TextEditingController taskDescription = TextEditingController();


  @override
  void initState() {
    if (widget.tasks != null) {
      _taskID = widget.tasks.task_id!;
      _taskName = widget.tasks.task_name!;
      _taskDesc = widget.tasks.task_description!;
      _taskDate = widget.tasks.task_date!;
      _taskStatus = widget.tasks.task_status!;

      if (_taskStatus == "Pending") {
        status = 1;
      } else {
        status = 0;
      }
    }

    dateinput.text=_taskDate;
    taskName.text=_taskName;
    taskDescription.text=_taskDesc;

    super.initState();
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFEFDFD),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 20.0),
          reverse: true,
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Container(
                  height: 350,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/HeaderView.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30.0,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    focusColor: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: 25,
                        height: 25,
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 130.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      _taskName,
                      style: GoogleFonts.getFont(
                        'Poppins',
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 190),
                child: Center(
                  child: ToggleSwitch(
                    minWidth: 120.0,
                    initialLabelIndex: status,
                    cornerRadius: 20.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.white,
                    inactiveFgColor: Colors.black54,
                    totalSwitches: 2,
                    labels: ['Done', 'Pending'],
                    fontSize: 14.0,
                    icons: [Icons.check, Icons.bubble_chart_rounded],
                    activeBgColors: [
                      [Color(0XFF00D2FF)],
                      [Color(0XFFFF00BB)]
                    ],
                    onToggle: (value) async {
                      if (value == 1) {
                        _taskStatus = "Pending";
                      } else {
                        _taskStatus = "Done";
                      }

                      presenter.updateStatus(_taskID, _taskStatus);

                      showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialog(
                          title: "Task Status Updated",
                          description:
                          "Task Updated To "+_taskStatus,
                          buttonText: "Okay",
                        ),
                      );
                    },
                  ),
                ),
              ),
              Column(
                children: [

                  Container(
                    margin: EdgeInsets.only(top: 380.0),
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      controller: taskName,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please Enter Task Title";
                        }
                        return null;
                      },

                      decoration: InputDecoration(
                        labelText: "Enter Task Title",
                      ),
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      minLines: 1,
                      controller: taskDescription,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        labelText: "Enter Task Description",
                      ),
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Center(
                      child: TextFormField(
                        controller: dateinput,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Please Enter Task Date";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Enter Task Date",
                          icon: Icon(
                            Icons.calendar_today,
                          ),
                        ),
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            print(pickedDate);
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(formattedDate);

                            dateinput.text = formattedDate;
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.only(top: 30.0, right: 5.0),
                        height: 45.0,
                        child: RaisedButton(
                          onPressed: () async {

                            presenter.deleteTask(_taskID);

                            showDialog(
                              context: context,
                              builder: (BuildContext context) => CustomDialog(
                                title: "Task Deleted",
                                description:
                                "Task Deleted Successfully",
                                buttonText: "Okay",
                              ),
                            );

                            Navigator.pop(context,
                                MaterialPageRoute(builder: (_) => TasksList()));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff6E6E6E), Color(0xff515151)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 100.0, minHeight: 45.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Delete",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.only(top: 30.0, right: 20.0),
                        height: 45.0,
                        child: RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {

                              presenter.updateTask(_taskID, taskName.text, dateinput.text, taskDescription.text, _taskStatus);

                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CustomDialog(
                                      title: "Task Updated",
                                      description:
                                      "Task Updated Successfully",
                                      buttonText: "Okay",
                                    ),
                              );


                              Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const TasksList()));
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xffFF2796), Color(0xffFF007F)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 100.0, minHeight: 45.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Update",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
