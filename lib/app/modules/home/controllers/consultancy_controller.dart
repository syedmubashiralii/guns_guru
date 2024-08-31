import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/models/consultancy_model.dart';

class ConsultancyController extends GetxController {
  RxList<Consultancy> consultancyList = <Consultancy>[].obs;
   RxInt selectedConsultancyIndex = 0.obs;

  Future<void> fetchConsultancyData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('admin')
          .doc('consultancy')
          .get();

      final List<dynamic> consultancyData =
          snapshot.data()?['consultancy'] ?? [];
      final consultancyListData =
          consultancyData.map((e) => Consultancy.fromMap(e)).toList();

      consultancyList.value = consultancyListData;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    // fetchConsultancyData();
  }
}
