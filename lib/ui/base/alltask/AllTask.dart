import 'package:beecrowd_task/data/model/TaskModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class AllTaskPage extends StatefulWidget {
  const AllTaskPage({Key? key}) : super(key: key);

  @override
  State<AllTaskPage> createState() => _AllTaskPageState();
}

class _AllTaskPageState extends State<AllTaskPage> {
  List<TaskModel> dataList = [];

  getData() async {
    var fireStore =
        await FirebaseFirestore.instance.collection('AllTask').get();
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
    getData();
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
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                //title
                child: Center(
                    child: Text(
                  'All Tasks',
                  style: TextStyle(fontSize: 15.sp, color: Colors.white),
                )),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: dataList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        itemCount: dataList.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                            //list body
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
