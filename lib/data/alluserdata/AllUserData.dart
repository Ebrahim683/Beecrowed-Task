import 'package:beecrowd_task/data/model/TaskModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AllUserData {
  List<TaskModel> sabbirTaskList = [];
  List<TaskModel> tarequeTaskList = [];
  List<TaskModel> jubayerTaskList = [];
  List<TaskModel> ashikTaskList = [];
  List<TaskModel> ebrahimTaskList = [];

  getUserTaskData(collection) async {
    var fireStore =
        await FirebaseFirestore.instance.collection('$collection').get();
    mapUserData(fireStore, collection);
  }

  mapUserData(QuerySnapshot<Map<String, dynamic>> fireStore, collection) {
    var list = fireStore.docs
        .map(
          (item) => TaskModel(
              taskNumber: item['taskNumber'],
              problem: item['problem'],
              date: null),
        )
        .toList();
    if (collection == "sabbir@gmail.com") {
      sabbirTaskList.addAll(list);
    } else if (collection == "tareque@gmail.com") {
      tarequeTaskList.addAll(list);
    } else if (collection == "jubayertareque@gmail.com") {
      jubayerTaskList.addAll(list);
    } else if (collection == "ashik@gmail.com") {
      ashikTaskList.addAll(list);
    } else if (collection == "ebrahim@gmail.com") {
      ebrahimTaskList.addAll(list);
    }
    print('sabbirList:$sabbirTaskList');
  }
}
