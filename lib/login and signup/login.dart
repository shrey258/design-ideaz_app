import 'package:flutter/material.dart';
import 'package:towedvechile/auth.dart';
import 'package:towedvechile/common_style/snackbar.dart';
import 'package:towedvechile/common_style/textinput.dart';
import 'package:towedvechile/registervechile.dart';
import 'package:towedvechile/rtoemployeesignin.dart';

class RtoemployeeNewLogin extends StatefulWidget {
  const RtoemployeeNewLogin({super.key});

  @override
  State<RtoemployeeNewLogin> createState() => _RtoemployeeNewLoginState();
}

class _RtoemployeeNewLoginState extends State<RtoemployeeNewLogin> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController phonenocontroller = TextEditingController();
  bool isLoading = false;

  void despose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    namecontroller.dispose();
    phonenocontroller.dispose();
  }

  void signUpUser() async {
    String res = await AuthenticationServices().signUpUser(
        email: emailcontroller.text,
        password: passwordcontroller.text,
        name: namecontroller.text,
        phoneno: phonenocontroller.text);
    if (res == "Success") {
      setState(() {
        isLoading = true;
      });
      //navigate to next screen
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
                Container(
                  alignment: const AlignmentDirectional(-1, -1),
                  child: const BackButton(
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Image.asset('asset/images/signup.jpeg'),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New User Registration",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Textinput(
                  textEditingController: namecontroller,
                  hintText: "Enter Your Name",
                  icon: Icons.person,
                ),
                Textinput(
                  textEditingController: phonenocontroller,
                  hintText: "Enter Your Phone no",
                  icon: Icons.phone_in_talk,
                ),
                Textinput(
                  textEditingController: emailcontroller,
                  hintText: "Enter Your Email",
                  icon: Icons.mark_email_unread_outlined,
                ),
                Textinput(
                  textEditingController: passwordcontroller,
                  hintText: "Enter Your New Password",
                  icon: Icons.lock,
                ),
                 InkWell(
        onTap: () {
                      if (emailcontroller.text.toString() != "" &&
                          passwordcontroller.text.toString() != "" &&
                          phonenocontroller.text.length==10 &&
                          namecontroller.text.toString() != "") {
                        signUpUser();
                      } else {
                        showSnackBar(context, "Fill all the details correctly !");
                      }
                    },
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
             "Sign Up",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
      
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Rtoemployeesignin(),
                          ),
                        );
                      },
                      child: const Text(
                        "Already Have account? Login in",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
    
    );
  }
}
