import 'package:beecrowd_task/data/model/TaskModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<TaskModel> dataList = [];
  var email = FirebaseAuth.instance.currentUser!.email;

  getData() async {
    var fireStore = await FirebaseFirestore.instance.collection('$email').get();
    mapData(fireStore);
  }

  mapData(QuerySnapshot<Map<String, dynamic>> fireStore) {
    var list = fireStore.docs
        .map(
          (item) => TaskModel(
              taskNumber: item['taskNumber'],
              problem: item['problem'],
              date: null),
        )
        .toList();

    setState(() {
      dataList.clear();
      dataList.addAll(list);
      print(dataList);
    });
  }

  Future<void> handleRefresh() async {
    getData();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
        child: LiquidPullToRefresh(
          onRefresh: () => handleRefresh(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                //title
                child: Center(
                    child: Text(
                  'Profile',
                  style: TextStyle(fontSize: 15.sp, color: Colors.white),
                )),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: dataList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        itemCount: dataList.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                            child: Container(
                              height: 60.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF1605F),
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //task text
                                  Text(
                                    '${dataList[index].taskNumber}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.sp),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  //problem text
                                  Text(
                                    '${dataList[index].problem}',
                                    style: TextStyle(
                                        color: Colors.yellow, fontSize: 10.sp),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
