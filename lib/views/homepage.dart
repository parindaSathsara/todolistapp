import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolistapp/models/dbhelper.dart';
import 'package:todolistapp/models/user_model.dart';
import 'package:todolistapp/views/message.dart';
import 'package:todolistapp/views/taskslist.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController username=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFEFDFD),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: SingleChildScrollView(
          reverse: true,
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Container(
                  height: 520,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Header.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  height: 450,
                  child: Center(
                    child: Text(
                      "TODO",
                      style: TextStyle(
                        fontFamily: 'Slimania',
                        color: Colors.white,
                        fontSize: 120,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 370.0,bottom: 20.0),

                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0XFF515151).withOpacity(.2),
                          blurRadius: 8,
                          offset: Offset(2, 2))
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 25.0),
                        child: Text(
                          'WELCOME',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.getFont(
                            'Poppins',
                            textStyle: TextStyle(
                              color: Color(0XFFFF0083),
                              fontSize: 30.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(30),
                        child: TextFormField(

                          controller: username,
                          textCapitalization: TextCapitalization.words,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please Enter Your Name";
                            }
                            return null;
                          },

                          decoration: InputDecoration(
                            hintText: 'Enter Your Name',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          style: GoogleFonts.getFont('Roboto',
                              textStyle: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30.0),
                        height: 45.0,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              DBHelper database = DBHelper();
                              Users _newUser = Users(
                                user_name: username.text,
                              );


                              database.newUser(_newUser);

                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CustomDialog(
                                      title: "Welcome " + username.text,
                                      description:
                                      "Here You Can Manage All Your Day To Day Activities",
                                      buttonText: "Start TODO",
                                    ),
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TasksList()),
                              );
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: const [Color(0xffFF2796), Color(0xffFF007F)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 180.0, minHeight: 45.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Get Started",
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
