import 'package:flutter/material.dart';
import 'package:towedvechile/auth.dart';
import 'package:towedvechile/common_style/snackbar.dart';
import 'package:towedvechile/common_style/textinput.dart';
import 'package:towedvechile/forgetpassword.dart';
import 'package:towedvechile/google_auth.dart';
import 'package:towedvechile/registervechile.dart';
import 'package:towedvechile/rtoemployee_new_login.dart';

class Rtoemployeesignin extends StatefulWidget {
  const Rtoemployeesignin({super.key});

  @override
  State<Rtoemployeesignin> createState() => _RtoemployeesigninState();
}

class _RtoemployeesigninState extends State<Rtoemployeesignin> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool isLoading = false;
  void despose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void loginUser() async {
    String res = await AuthenticationServices().loginUser(
      email: emailcontroller.text,
      password: passwordcontroller.text,
    );
    if (res == "Success") {
      setState(() {
        isLoading = true;
      });
      //Navigate to next screen
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Registervechile()));
    } else {
      setState(() {
        isLoading = false;
      });
      //show error
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //  Container(alignment: AlignmentDirectional(-1, -1),
                //     child: BackButton(color: Colors.black,),),
                Container(
                  child: const BackButton(
                    color: Colors.black,
                  ),
                  alignment: const AlignmentDirectional(-1, -1),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Image.asset('asset/images/login.jpg'),
                ),
                Textinput(
                  textEditingController: emailcontroller,
                  hintText: "Enter Your Email",
                  icon: Icons.mark_email_unread_outlined,
                ),
                Textinput(
                  textEditingController: passwordcontroller,
                  hintText: "Enter Your Password",
                  icon: Icons.lock,
                ),
      
                InkWell(
        onTap: () { loginUser();  },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: ShapeDecoration(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              color: Colors.blue,
            ),
            child: isLoading?const CircularProgressIndicator(color: Colors.white,)
            :const Text(
             "Log In",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
                
                //forgert password
                const Forgetpassword(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 1,
                      color: Colors.black,
                    )),
                    const Text("  or  "),
                    Expanded(
                        child: Container(
                      height: 1,
                      color: Colors.black,
                    )),
                  ],
                ),
                //for google Login
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey),
                    onPressed: () async {
                      await FirebaseServices().signInWithGoogle();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Registervechile()));
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Image.asset(
                            "asset/images/goggle.png",
                            height: 35,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          "Continue With Google",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RtoemployeeNewLogin()),
                          );
                        },
                        child: const Text(
                          "Dont't have account? Create new",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
     
    );
  }
}
