import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:student_guidance/model/University.dart';

class UniversityService{

   getListUniversity()  {
    List<String> list = new List<String>();
   Firestore.instance.collection('University').getDocuments().then( (QuerySnapshot docs)  {
      
        if(docs.documents.isNotEmpty){
          for(int i=0;i<docs.documents.length;i++){
         String _university =  docs.documents[i].data['university_name'];
            
            list.add(_university);
          }
        }
    }
    );
    return  list;
  }

   Future<University> getUniversity(String name) async {
    University university = new University();
   CollectionReference ref = Firestore.instance.collection("University");
     DocumentReference refQuery = await ref.document(name);
     university = await refQuery.get().then((doc) async {
        return University.fromJson(doc.data);
        
      });
    return university;

  }
  

  



  
}