import 'package:beecrowd_task/ui/base/BasePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _globalKey = GlobalKey<FormState>();
  var secure = true;
  var isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  login(email, password) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _globalKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                //Login text
                Row(
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      'Login your account',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ],
                ),
                // Text input box
                //email
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      label: const Text('Email'),
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(color: Colors.blue)),
                    ),
                  ),
                ),
                //password
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextFormField(
                    obscureText: secure,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      label: const Text('Password'),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            secure = !secure;
                          });
                        },
                        child: secure == true
                            ? const Icon(Icons.remove_red_eye)
                            : const Icon(Icons.visibility_off),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(color: Colors.blue)),
                    ),
                  ),
                ),
                //login button
                SizedBox(
                  height: 30.h,
                ),
                //login button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoading = !isLoading;
                        Get.to(BasePage());
                      });
                    },
                    child: Center(
                      child: isLoading == false
                          ? Padding(
                              padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                              child: const Text('Log In'),
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
          ),
        ),
      ),
    );
  }
}
