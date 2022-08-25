import 'package:beecrowd_task/data/model/TaskModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdminPage extends StatefulWidget {
  AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  var isLoading = false;

  var _globalKey = GlobalKey<FormState>();
  final TextEditingController _taskNumberController = TextEditingController();
  final TextEditingController _problemController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  addTask(taskNumber, problem, date) async {
    try {
      TaskModel taskModel =
          TaskModel(taskNumber: taskNumber, problem: problem, date: date);
      final taskStore =
          FirebaseFirestore.instance.collection('CurrentTask').doc('Task');
      await taskStore.set(taskModel.addTaskAdmin());
      addAllTAsk(taskNumber, problem, date);
      setState(() {
        isLoading = false;
      });
      Get.snackbar('Success!!', 'Task added',
          isDismissible: true,
          backgroundColor: Colors.green,
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print('FireStore:$e');
      Get.snackbar('Error!!', '$e',
          isDismissible: true,
          backgroundColor: Colors.green,
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          snackPosition: SnackPosition.BOTTOM);
      setState(() {
        isLoading = false;
      });
    }
  }

  addAllTAsk(taskNumber, problem, date) async {
    try {
      TaskModel taskModel =
          TaskModel(taskNumber: taskNumber, problem: problem, date: date);
      final taskStore =
          FirebaseFirestore.instance.collection('AllTask').doc(taskNumber);
      await taskStore.set(taskModel.addTaskAdmin());
      Get.snackbar('Success!!', 'Task added to all',
          isDismissible: true,
          backgroundColor: Colors.green,
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print('FireStore:$e');
      Get.snackbar('Error!!', '$e',
          isDismissible: true,
          backgroundColor: Colors.green,
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: Form(
        key: _globalKey,
        child: Column(
          children: [
            //task number text
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextFormField(
                controller: _taskNumberController,
                decoration: InputDecoration(
                  hintText: 'Task 1',
                  label: const Text('Task number'),
                  prefixIcon: const Icon(Icons.numbers),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(color: Colors.blue)),
                ),
              ),
            ),
            //problem text
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextFormField(
                controller: _problemController,
                decoration: InputDecoration(
                  hintText: 'Problem',
                  label: const Text('Problem'),
                  prefixIcon: const Icon(Icons.text_snippet_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(color: Colors.blue)),
                ),
              ),
            ),
            //date text
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  hintText: 'Date',
                  label: const Text('dd/mm/yyyy'),
                  prefixIcon: const Icon(Icons.calendar_month),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(color: Colors.blue)),
                ),
              ),
            ),
            //admin button
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                    var taskNumber = _taskNumberController.text.trim();
                    var problem = _problemController.text.trim();
                    var date = _dateController.text.trim();
                    if (taskNumber.isEmpty) {
                      Get.snackbar('Error!!', 'Enter task number',
                          isDismissible: true,
                          backgroundColor: Colors.green,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.w),
                          colorText: Colors.white,
                          duration: const Duration(seconds: 4),
                          snackPosition: SnackPosition.BOTTOM);
                    } else if (problem.isEmpty) {
                      Get.snackbar('Error!!', 'Enter problem',
                          isDismissible: true,
                          backgroundColor: Colors.green,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.w),
                          colorText: Colors.white,
                          duration: const Duration(seconds: 4),
                          snackPosition: SnackPosition.BOTTOM);
                    } else if (date.isEmpty) {
                      Get.snackbar('Error!!', 'Enter date',
                          isDismissible: true,
                          backgroundColor: Colors.green,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.w),
                          colorText: Colors.white,
                          duration: const Duration(seconds: 4),
                          snackPosition: SnackPosition.BOTTOM);
                    } else {
                      addTask(taskNumber, problem, date);
                    }
                  });
                },
                child: Center(
                  child: isLoading == false
                      ? Padding(
                          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                          child: const Text('Admin Login'),
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
