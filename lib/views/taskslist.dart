import 'package:flutter/material.dart';

import 'package:todolistapp/models/dbhelper.dart';
import 'package:todolistapp/views/widgets.dart';
import 'package:todolistapp/views/taskreg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todolistapp/views/viewtask.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  String todoListSearch = "";

  TextEditingController dateInput = TextEditingController();
  TextEditingController longDateInput = TextEditingController();
  TextEditingController titleHead = TextEditingController();

  String taskStatus="";
  String name="";
  bool taskPending=false;
  bool allTasks=false;
  bool calendarButton=true;
  bool addButton=true;

  DBHelper _dbHelper = DBHelper();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    if(titleHead.text==""){
      titleHead.text="TODAY";
    }

    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    formatter = DateFormat('d MMMM yyyy, EEEE');
    String formattedlong = formatter.format(now);

    if (dateInput.text == "") {
      dateInput.text = formattedDate;
    }
    if (longDateInput.text == "") {
      longDateInput.text = formattedlong;
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 70.0),
              child: Image(
                width: 150.0,
                height: 150.0,
                image: AssetImage('assets/images/logo.png'),
              ),
            ),

            ListTile(

              leading: Icon(Icons.date_range),
              title: Text("Task By Date"),
              selectedTileColor: Colors.black54,
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  allTasks=false;
                  calendarButton=true;
                  addButton=true;
                  taskStatus="";
                  if (allTasks != true) {
                    titleHead.text = "TODAY";
                    longDateInput.text=formattedlong;
                  }
                },);
              },
            ),

            ListTile(
              leading: Icon(Icons.calendar_view_day),
              title: Text("All Tasks"),
              onTap: () {
                Navigator.pop(context);

                setState(() {
                  allTasks=true;
                  calendarButton=false;
                  taskStatus="";
                  addButton=true;
                  if (allTasks == true) {
                    titleHead.text = "TASKS";
                    longDateInput.text="All Tasks List (Pending & Done)";
                  }
                },);

              },
            ),

            ListTile(
              leading: Icon(Icons.bubble_chart_rounded),
              title: Text("Pending Tasks"),
              onTap: () {
                Navigator.pop(context);

                setState(() {
                  allTasks=true;
                  calendarButton=false;
                  addButton=true;

                  taskStatus="Pending";

                  if (taskStatus=="Pending") {
                    titleHead.text = "PENDING";
                    longDateInput.text="Pending Tasks Are Shown Here";
                  }
                },);
              },
            ),

            ListTile(
              leading: Icon(Icons.check),
              title: Text("Done Tasks"),
              onTap: () {
                Navigator.pop(context);

                setState(() {
                  allTasks=true;
                  calendarButton=false;
                  addButton=false;
                  taskStatus="Done";

                  if (taskStatus=="Done") {
                    titleHead.text = "DONE";
                    longDateInput.text="Completed Tasks Are Shown Here";
                  }
                },);
              },
            ),
          ],
        ),
      ),




      body: SafeArea(

        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          color: Color(0xFFFFFFFF),
          child: Stack(
            children: [

              Container(

                margin: EdgeInsets.only(top: 20.0),
                child: Material(

                  color: Colors.white,

                  child: InkWell(
                    splashColor: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () => _scaffoldKey.currentState!.openDrawer(),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),

              Visibility(

                visible: addButton,
                child: Positioned(
                  top: 70.0,
                  right: 0.00,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.pink.shade50,
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TaskPage()))
                            .then((value) => setState(() {}));
                      },
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: const [
                              Color(0XFFFF2796),
                              Color(0XFFFF007F),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 50.0,
                left: 0.00,
                child: FutureBuilder(
                  future: _dbHelper.getUser(),
                  builder: (context, AsyncSnapshot<List> snapshot) {

                    if(snapshot.data==null){
                      name="";
                    }
                    else{
                      name=snapshot.data![0].user_name;
                    }

                    return Text(
                      "Hello " + name + "!",
                      style: GoogleFonts.getFont(
                        'Roboto',
                        textStyle: TextStyle(
                          color: Color(0XFF5D5D5D),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  },
                ),
              ),

              Visibility(

                visible: calendarButton,
                child: Positioned(
                  top: 70.0,
                  right: 48.00,
                  child: GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {

                        String formattedDate =DateFormat('yyyy-MM-dd').format(pickedDate);
                        String longDate =DateFormat('d MMMM yyyy, EEEE').format(pickedDate);
                        String titleDate =DateFormat('MMMd').format(pickedDate);
                        setState(() {

                          if(formattedDate==DateFormat('yyyy-MM-dd').format(now)){
                            titleHead.text="TODAY";
                          }
                          else{
                            titleHead.text=titleDate.toUpperCase();
                          }
                          dateInput.text = formattedDate;
                          longDateInput.text = longDate;
                        });
                      } else {
                        //print("Date is not selected");
                      }
                    },
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0XFF5D5D5D),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.date_range_rounded,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    margin: EdgeInsets.only(
                      bottom: 3.0,top: 70.0
                    ),
                    child: Text(
                      titleHead.text,
                      style: GoogleFonts.getFont(
                        'Roboto',
                        textStyle: TextStyle(
                          color: Color(0XFF5D5D5D),
                          fontSize: 40.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: Text(
                      longDateInput.text,
                      style: GoogleFonts.getFont(
                        'Roboto',
                        textStyle: TextStyle(
                          color: Color(0XFF5D5D5D),
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) {
                        setState(() {
                          todoListSearch = value;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: 'Search...',
                          labelText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          )),
                    ),
                  ),


                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: FutureBuilder(

                        future:_dbHelper.getTasks(taskStatus,allTasks,dateInput.text, todoListSearch),
                        builder: (context, AsyncSnapshot<List> snapshot) {

                          var snapdata = 0;
                          if (snapshot.hasData) {
                            snapdata = snapshot.data!.length;
                          } else {
                            snapdata = 0;
                          }
                          return ScrollConfiguration(
                            behavior: NoGlow(),
                            child: ListView.builder(
                              itemCount: snapdata,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TaskViewPage(
                                            tasks: snapshot.data![index]),
                                      ),
                                    ).then((value) => setState(() {}));
                                  },
                                  child: TaskCardWidget(
                                      title: snapshot.data![index].task_name,
                                      description: snapshot
                                          .data![index].task_description,
                                      status:
                                          snapshot.data![index].task_status),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
