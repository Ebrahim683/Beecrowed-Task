import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
        child: Column(
          children: [
            //image
            SizedBox(
              height: 200.h,
              width: double.infinity,
              // child: Image.asset(''),
            ),
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
                      child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Container(
                                height: 15.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.grey),
                                child: Center(
                                  child: Text(
                                    'Task 1',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10.sp),
                                  ),
                                ),
                              ),
                            );
                          }),
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
                      child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Container(
                                height: 15.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.grey),
                                child: Center(
                                  child: Text(
                                    'Task 1',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10.sp),
                                  ),
                                ),
                              ),
                            );
                          }),
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
                      child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Container(
                                height: 15.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.grey),
                                child: Center(
                                  child: Text(
                                    'Task 1',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10.sp),
                                  ),
                                ),
                              ),
                            );
                          }),
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
                      child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Container(
                                height: 15.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.grey),
                                child: Center(
                                  child: Text(
                                    'Task 1',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10.sp),
                                  ),
                                ),
                              ),
                            );
                          }),
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
                      child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Container(
                                height: 15.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.grey),
                                child: Center(
                                  child: Text(
                                    'Task 1',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10.sp),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      //done button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('ok');
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.done),
      ),
    );
  }
}
