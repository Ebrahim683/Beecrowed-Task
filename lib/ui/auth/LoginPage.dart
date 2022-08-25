import 'package:beecrowd_task/ui/admin/AdminPage.dart';
import 'package:beecrowd_task/ui/base/BasePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _globalKey = GlobalKey<FormState>();
  final code = "845";
  var secure = true;
  var isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _adminCodeController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  loginUser(email, password) async {
    try {
      var credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print('Auth: ${credential.user!.email}');
      isLoading = false;
      Get.off(BasePage());
    } on FirebaseAuthException catch (e) {
      print('Auth: ${e.message}');
      setState(() {
        isLoading = false;
      });
      Get.snackbar('Error!!', '${e.message}',
          isDismissible: true,
          backgroundColor: Colors.green,
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  checkUser() async {
    var user = await firebaseAuth.currentUser;
    if (user != null) {
      print('user: ${firebaseAuth.currentUser!.email}');
      Get.off(BasePage());
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _globalKey,
          child: SingleChildScrollView(
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
                      controller: _emailController,
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
                      controller: _passController,
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          var email = _emailController.text.trim();
                          var password = _passController.text.trim();
                          if (email.isEmpty) {
                            Get.snackbar('Error!!', 'Enter email',
                                isDismissible: true,
                                backgroundColor: Colors.green,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.w),
                                colorText: Colors.white,
                                duration: const Duration(seconds: 4),
                                snackPosition: SnackPosition.BOTTOM);
                          } else if (password.isEmpty) {
                            Get.snackbar('Error!!', 'Enter password',
                                isDismissible: true,
                                backgroundColor: Colors.green,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.w),
                                colorText: Colors.white,
                                duration: const Duration(seconds: 4),
                                snackPosition: SnackPosition.BOTTOM);
                          } else {
                            isLoading = true;
                            loginUser(email, password);
                          }
                        });
                      },
                      child: Center(
                        child: isLoading == false
                            ? Padding(
                                padding:
                                    EdgeInsets.only(top: 10.h, bottom: 10.h),
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
                  //admin code
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: TextFormField(
                      controller: _adminCodeController,
                      decoration: InputDecoration(
                        hintText: 'Admin code',
                        label: const Text('Admin code'),
                        prefixIcon: const Icon(Icons.code),
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
                          var adminCode = _adminCodeController.text.trim();
                          if (adminCode.isEmpty) {
                            Get.snackbar('Error!!', 'Enter admin code',
                                isDismissible: true,
                                backgroundColor: Colors.green,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.w),
                                colorText: Colors.white,
                                duration: const Duration(seconds: 4),
                                snackPosition: SnackPosition.BOTTOM);
                          } else if (adminCode == code) {
                            Get.to(AdminPage());
                          } else {
                            Get.snackbar('Error!!', 'Enter correct admin code',
                                isDismissible: true,
                                backgroundColor: Colors.green,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.w),
                                colorText: Colors.white,
                                duration: const Duration(seconds: 4),
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        });
                      },
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                          child: const Text('Admin Login'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
