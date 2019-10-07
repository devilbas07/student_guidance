import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/UniversityService.dart';
import 'package:student_guidance/utils/UIdata.dart';

class AddEducation extends StatefulWidget {
  @override
  _AddEducationState createState() => _AddEducationState();
}
class Round {
  int id;
  String name = '';
  Round(this.id,this.name);
  static List<Round> getRound(){
    return <Round>[
      Round(1,'Portfolio'),
      Round(2,'การรับแบบโควตา'),
      Round(3,'รับตรงร่วมกัน (+กสพท)'),
      Round(4,'การรับแบบแอดมิชชัน'),
      Round(5,'การรับตรงอิสระ'),
    ];
  }
}

class _AddEducationState extends State<AddEducation> {
  List<Round> _round = Round.getRound();
  List<DropdownMenuItem<Round>> _dropdownMenuItem;



  Round _selectedRound;
  var _selectedUniversity;

   @override
  void initState(){
    _dropdownMenuItem = buildDropDownMenuItem(_round);
    
  
  
    super.initState();
  }
List<DropdownMenuItem<Round>> buildDropDownMenuItem(List rounded){
  List<DropdownMenuItem<Round>> items = List();
  for(Round round in rounded){
    items.add(DropdownMenuItem(value: round,child: Text(round.name),),);
  }
  return items;
}

onChangeDropdownItem(Round selectRound){
  setState(() {
   _selectedRound = selectRound; 
  });
}

  final GlobalKey<FormState> _educationKey = GlobalKey<FormState>();
   String _username,_password; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: Color(0xFF21BFBD),
         body: ListView(
           children: <Widget>[
             Padding(
               padding: EdgeInsets.only(top: 15,left: 10),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   IconButton(
                     icon: Icon(Icons.arrow_back_ios),
                     color: Colors.white,
                     onPressed: (){
                      Navigator.of(context).pop();
                     },
                   )
                 ],
               ),
             ),
             SizedBox(height: 25,),
             Padding(
               padding: EdgeInsets.only(left: 40),
               child: Row(
                 children: <Widget>[
                   Tab(
                     
                     icon: Icon(Icons.school,size: 40,color: Colors.white,),
                     
                   ),
                   SizedBox(width: 10,),
                     Text('เพิ่มข้อมูลการสอบติด',
                   style: TextStyle(
                     fontFamily: 'kanit',
                     color: Colors.white,
                     fontSize: 25
                   ),
                   ),
                 ],
               ),
             ),
             SizedBox(height: 40,),
             Container(
               height: MediaQuery.of(context).size.height -185,
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.only(topLeft: Radius.circular(75),
               ),
             ),
             child: ListView(
               children: <Widget>[
                 Form(
                   key: _educationKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          SizedBox(height: 40,),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
                Text('รอบการสมัคร',style: TextStyle(fontFamily: 'kanit',fontSize: 18,color: Colors.black45),),
                SizedBox(width: 30,),
                DropdownButton(
                  value: _selectedRound,
                  items: _dropdownMenuItem,
                  onChanged: onChangeDropdownItem,
                    hint: Text('เลือกรอบการสอบ'),
                ),
                SizedBox(height: 10,),

             ],
           ),
             SizedBox(height: 10,),
               StreamBuilder<QuerySnapshot>(stream: Firestore.instance.collection('University').snapshots(),
               builder: (context,snapshot) {
                 if(!snapshot.hasData){
                  return Text("Loading.....");
                 }
                 else{
                   List<DropdownMenuItem> currencyItem = [];
                   for(int i=0;i< snapshot.data.documents.length;i++){
                     DocumentSnapshot doc = snapshot.data.documents[i];

                     currencyItem.add(
                       DropdownMenuItem(
                         child: Text(doc.documentID),
                         value: "${doc.documentID}",
                       )
                     );
                   }
                   return Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Text('มหาวิทยาลัย',style: TextStyle(fontFamily: 'kanit',fontSize: 18,color: Colors.black45),),
                       SizedBox(width: 50,),
                       DropdownButton(
                         items: currencyItem,
                       onChanged: (values){
                         setState(() {
                           _selectedUniversity = values;
                         });
                       },
                       value: _selectedUniversity,
                      
                       hint: Text('เลือกมหาวิทยาลัย'),
                       )
                     ],
                   );
                 }
               },
               ),
           SizedBox(height: 10,),
             Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
                Text('คณะ',style: TextStyle(fontFamily: 'kanit',fontSize: 18,color: Colors.black45),),
                SizedBox(width: 30,),
                DropdownButton(
                  value: _selectedRound,
                  items: _dropdownMenuItem,
                  onChanged: onChangeDropdownItem,
                    hint: Text('เลือกคณะ'),
                ),
                SizedBox(height: 10,),

             ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
                Text('สาขา',style: TextStyle(fontFamily: 'kanit',fontSize: 18,color: Colors.black45),),
                SizedBox(width: 30,),
                DropdownButton(
                  value: _selectedRound,
                  items: _dropdownMenuItem,
                  onChanged: onChangeDropdownItem,
                    hint: Text('เลือกสาขา'),
                ),
                SizedBox(height: 10,),

             ],
           ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: TextFormField(
                maxLines: 1,
                obscureText: true,
                validator: (input){
                 if(input.length < 4 ){
                   return 'Your password needs to be atleast 6 characters ';
                 }
               },
               onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  hintText: 'กรุณากรอกรหัสผ่าน',
                  labelText: 'รายละเอียด',
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(15.0),
                shape: StadiumBorder(),
                child: Text(
                  'เพิ่มข้อมูล',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: (){},
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
           
          ],
        ),
                 )
               ],
             ),
             )
             

           ],
         ),

    );
  }
}