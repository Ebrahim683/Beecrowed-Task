import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllTaskPage extends StatelessWidget {
  const AllTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
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
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  itemCount: 10,
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
                              'Task 1',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.sp),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            //problem text
                            Text(
                              'Problem 1 to 10',
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
    );
  }
}
