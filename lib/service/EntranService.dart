import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_guidance/model/ChartData.dart';
import 'package:student_guidance/model/EntranceExamResult.dart';
import 'package:student_guidance/model/Faculty.dart';
import 'package:student_guidance/model/Login.dart';
import 'package:student_guidance/model/Student.dart';
import 'package:student_guidance/model/University.dart';
import 'package:student_guidance/service/SchoolService.dart';
import 'package:student_guidance/service/StudentService.dart';

class EntranService {
  Future<List<EntranceExamResult>> getAllEntranceExamResult() async {
    List<DocumentSnapshot> templist;
    List<EntranceExamResult> list = new List();
    CollectionReference collectionReference =
        Firestore.instance.collection('EntranceExamResult');

    QuerySnapshot collecttionSnapshot =
        await collectionReference.getDocuments();
    templist = collecttionSnapshot.documents;
    list = templist.map((DocumentSnapshot doc) {
      return EntranceExamResult.fromJson(doc.data);
    }).toList();
    return list;
  }

  Future<Map<String, Map<int, List<ChartData>>>> getDashboard(int id) async {
    Map<String, Map<int, List<ChartData>>> chartData =
        new Map<String, Map<int, List<ChartData>>>();
    Set<String> setYear = new Set<String>();
    Set<DocumentReference> setUni = new Set<DocumentReference>();
    Set<DocumentReference> setFac = new Set<DocumentReference>();
    Set<DocumentReference> setMj = new Set<DocumentReference>();

    Student student = await StudentService().getStudent().then((result) {
      return result;
    });

    return await Firestore.instance
        .collection('EntranceExamResult')
        .where('school', isEqualTo: student.school)
        .getDocuments()
        .then((result) async {
      for (DocumentSnapshot doc in result.documents) {
        setYear.add(doc.data['year']);
        setUni.add(doc.data['university']);
        setFac.add(doc.data['faculty']);
        setMj.add(doc.data['major']);
      }

      for (String year in setYear) {
        Query fireExam = Firestore.instance
            .collection('EntranceExamResult')
            .where('year', isEqualTo: year);

        switch (id) {
          case 1:
            List<ChartData> listChartData = new List<ChartData>();
            Map<int, List<ChartData>> chartUniData =
                new Map<int, List<ChartData>>();

            for (DocumentReference uni in setUni) {
              await fireExam
                  .where('university', isEqualTo: uni)
                  .getDocuments()
                  .then((listResult) async {
                ChartData chData = new ChartData();
                University uniData = await uni.get().then((result) {
                  return University.fromJson(result.data);
                });
                chData.name = uniData.universityname;
                chData.value = listResult.documents.length.toDouble();
                chData.year = year;
                listChartData.add(chData);
              });
            }
            chartUniData[1] = listChartData;
            chartData[year] = chartUniData;
            break;
          // case 2:
          //   for (DocumentReference fac in setFac) {
          //     await fireExam
          //         .where('faculty', isEqualTo: fac)
          //         .getDocuments()
          //         .then((listResult) async {
          //       ChartData chData = new ChartData();
          //       Faculty facData = await fac.get().then((result) {
          //         return Faculty.fromJson(result.data);
          //       });
          //       chData.name = facData.facultyName;
          //       chData.value = listResult.documents.length;
          //       chData.year = year;
          //       Map<int, ChartData> chartFacData = new Map<int, ChartData>();
          //       chartFacData[2] = chData;
          //       chartData[year] = chartFacData;
          //     });
          //   }
          //   break;
        }
      }
      return chartData;
    });
  }

  addEntranceExamResult(EntranceExamResult enExam) async {
    Firestore.instance.collection('EntranceExamResult').add(enExam.toMap());
  }
}