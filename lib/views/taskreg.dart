import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todolistapp/presenter/main_presenter.dart';

import 'package:todolistapp/views/message.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController dateInput = TextEditingController();
  TextEditingController taskName = TextEditingController();
  TextEditingController taskDescription = TextEditingController();

  Presenter presenter=Presenter();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 18.0,
                      bottom: 12.0,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Container(
                              width: 25,
                              height: 25,
                              child: Icon(
                                Icons.arrow_back,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: taskName,
                            textCapitalization: TextCapitalization.words,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Please Enter Task Title";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Enter Task Title",
                              border: InputBorder.none,
                            ),
                            style: GoogleFonts.getFont(
                              'Poppins',
                              fontSize: 22.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
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
                        margin: EdgeInsets.only(top: 50.0),
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Center(
                          child: TextFormField(
                            controller: dateInput,
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
                                setState(() {
                                  dateInput.text = formattedDate;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                        ),
                      ),

                      Container(
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        margin: EdgeInsets.only(top: 50.0),
                        height: 45.0,
                        child: RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {

                              await presenter.insertTask(taskName.text,dateInput.text,taskDescription.text,"Pending");

                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CustomDialog(
                                      title: "New Task Added",
                                      description: "Task Added Successfully",
                                      buttonText: "Okay",
                                    ),
                              );

                              Navigator.pop(context);
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
                                  maxWidth: 150.0, minHeight: 45.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Add Task",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
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
            ),
          ),
        ),
      ),
    );
  }
}
