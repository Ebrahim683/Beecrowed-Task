import 'package:beecrowd_task/data/alluserdata/AllUserData.dart';
import 'package:beecrowd_task/data/model/TaskModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var taskNumberText;
  var problemText;
  var dateText;
  var isLoading = false;
  var fireStore = FirebaseFirestore.instance;

  var allUserData = AllUserData();

  List<TaskModel> sabbirData = [];
  List<TaskModel> tarequeData = [];
  List<TaskModel> jubayerData = [];
  List<TaskModel> ashikData = [];
  List<TaskModel> ebrahimData = [];

//get all users task
  getUserTaskData() {
    setState(() {
      ebrahimData.clear();
      sabbirData.clear();
      tarequeData.clear();
      ashikData.clear();
      jubayerData.clear();
      //sabbir task
      allUserData.getUserTaskData('sabbir@gmail.com');
      sabbirData = allUserData.sabbirTaskList;
      print('sabbirData:$sabbirData');
      //tareque task
      allUserData.getUserTaskData('tareque@gmail.com');
      tarequeData = allUserData.tarequeTaskList;
      print('tarequeData:$tarequeData');
      //jubayer task
      allUserData.getUserTaskData('jubayer@gmail.com');
      jubayerData = allUserData.jubayerTaskList;
      print('jubayerData:$jubayerData');
      //ashik task
      allUserData.getUserTaskData('ashik@gmail.com');
      ashikData = allUserData.ashikTaskList;
      print('ashikData:$ashikData');
      //ashik task
      allUserData.getUserTaskData('ebrahim@gmail.com');
      ebrahimData = allUserData.ebrahimTaskList;
      print('ebrahimData:$ebrahimData');
    });
  }

//get daily task
  getTask() async {
    try {
      taskNumberText = '';
      problemText = '';
      dateText = '';
      var collection = fireStore.collection('CurrentTask');
      var snapShot = await collection.doc('Task').get();
      if (snapShot.exists) {
        var data = snapShot.data();
        print('getTask:$data');
        var taskNumber = data!['taskNumber'];
        var problem = data['problem'];
        var date = data['date'];
        setState(() {
          taskNumberText = taskNumber;
          problemText = problem;
          dateText = date;
        });
      }
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

//add task when done
  addDoneTask(taskNumber, problem) async {
    try {
      var email = FirebaseAuth.instance.currentUser!.email;
      var fireStore =
          FirebaseFirestore.instance.collection('$email').doc(taskNumber);
      TaskModel taskModel =
          TaskModel(taskNumber: taskNumber, problem: problem, date: null);
      await fireStore.set(taskModel.addDoneTask());
      setState(() {
        isLoading = false;
      });
      Get.snackbar('Success!!', 'Task completed',
          isDismissible: true,
          backgroundColor: Colors.green,
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
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

  //refresh
  Future<void> handleRefresh() async {
    getTask();
    getUserTaskData();
  }

  @override
  void initState() {
    getTask();
    getUserTaskData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
        child: LiquidPullToRefresh(
          onRefresh: () => handleRefresh(),
          child: Column(
            children: <Widget>[
              // image
              Stack(
                children: [
                  Image.asset(
                    'images/programming.jpg',
                    height: 200.h,
                    fit: BoxFit.fill,
                  ),
                  //problem
                  Positioned(
                    top: 50,
                    left: 60,
                    right: 60,
                    child: taskNumberText == null
                        ? SizedBox()
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.6),
                                border:
                                    Border.all(width: 1.w, color: Colors.white),
                                borderRadius: BorderRadius.circular(15.r)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 5.h),
                              child: Column(
                                children: [
                                  //task number
                                  Text(
                                    taskNumberText ?? 'Null',
                                    style: TextStyle(
                                      color: Colors.yellowAccent,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  //problem name
                                  Text(
                                    problemText ?? 'Null',
                                    style: TextStyle(
                                      color: Colors.yellowAccent,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  //date
                                  Text(
                                    dateText ?? 'Null',
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  )
                ],
              ),
              //all users task
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //sabbir task
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Sabbir',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        height: 50.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1.w, color: Colors.white),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 5.w),
                              child: ListView.builder(
                                  itemCount: sabbirData.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Container(
                                        height: 15.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: Colors.grey),
                                        child: Center(
                                          child: Text(
                                            '${sabbirData[index].taskNumber}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.sp),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                      ),
                      //tareque task
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Tareque',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        height: 50.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1.w, color: Colors.white),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 5.w),
                              child: ListView.builder(
                                  itemCount: tarequeData.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Container(
                                        height: 15.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: Colors.grey),
                                        child: Center(
                                          child: Text(
                                            tarequeData[index].taskNumber,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.sp),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                      ),
                      //jubayer task
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Jubayer',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        height: 50.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1.w, color: Colors.white),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 5.w),
                              child: ListView.builder(
                                  itemCount: jubayerData.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Container(
                                        height: 15.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: Colors.grey),
                                        child: Center(
                                          child: Text(
                                            jubayerData[index].taskNumber,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.sp),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                      ),
                      //ashik task
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Ashik',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        height: 50.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1.w, color: Colors.white),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 5.w),
                              child: ListView.builder(
                                  itemCount: ashikData.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Container(
                                        height: 15.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: Colors.grey),
                                        child: Center(
                                          child: Text(
                                            ashikData[index].taskNumber,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.sp),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                      ),
                      //ebrahim task
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Ebrahim',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        height: 50.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1.w, color: Colors.white),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 5.w),
                              child: ListView.builder(
                                  itemCount: ebrahimData.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Container(
                                        height: 15.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: Colors.grey),
                                        child: Center(
                                          child: Text(
                                            ebrahimData[index].taskNumber,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.sp),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      //done button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isLoading = true;
          });
          addDoneTask(taskNumberText, problemText);
        },
        backgroundColor: Colors.redAccent,
        child: isLoading == true
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(Icons.done),
      ),
    );
  }
}
