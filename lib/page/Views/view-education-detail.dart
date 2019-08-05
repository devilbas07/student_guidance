import 'package:flutter/material.dart';
import 'package:student_guidance/styleguide.dart';
import 'package:student_guidance/utils/UIdata.dart';
import 'package:student_guidance/widgets/education_widget.dart';

class ViewEducation extends StatefulWidget {
  static String tag = 'view-education';
  @override
  _ViewEducationState createState() => _ViewEducationState();
}

class _ViewEducationState extends State<ViewEducation> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: UIdata.backIcon,
        onPressed: () {Navigator.pop(context);}
        ),
     
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 32.0, top: 8.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Education", style: AppTheme.display1),
                      TextSpan(text: "\n"),
                      TextSpan(text: "Detail", style: AppTheme.display2),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: EdicationWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}