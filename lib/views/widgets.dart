import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TaskCardWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final String? status;

  TaskCardWidget({required this.title, required this.description, required this.status});

  @override
  Widget build(BuildContext context) {
    LinearGradient _setGradient() {
      switch (status) {
        case 'Done':
          return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const [
                Color(0XFF00D5FF),
                Color(0XFF00A2FF),
              ]);
        case 'Pending':
          return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const [
                Color(0XFFFF007F),
                Color(0XFFFF00DE),
              ]);
        default:
          return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const [
                Color(0XFFFF007F),
                Color(0XFFFF00DE),
              ]);
      }
    }

    Icon _getIcon() {
      switch (status) {
        case 'Done':
          return Icon(
            Icons.check,
            color: Colors.white,
            size: 35.0,
          );
        case 'Pending':
          return Icon(
            Icons.bubble_chart_rounded,
            color: Colors.white,
            size: 35.0,
          );
        default:
          return Icon(
            Icons.check,
            color: Colors.white,
            size: 35.0,
          );
      }
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0,
      ),
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        gradient: _setGradient(),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
              color: Color(0XFF515151).withOpacity(.25),
              blurRadius: 6,
              offset: Offset(2, 5))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(

            children: [
              _getIcon(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                    title ?? "Unnamed Task",
                    style: GoogleFonts.getFont(
                      'Roboto',
                      color: Color(0XFFFFFFFF),
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: Text(
              description ?? "No Desc",
              style: GoogleFonts.getFont(
                'Roboto',
                fontSize: 14.0,
                color: Color(0XFFFFFFFF),
                height: 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NoGlow extends ScrollBehavior{
  @override

  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
