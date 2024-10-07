import 'package:design_ideaz_app/common_style/textinput.dart';
import 'package:design_ideaz_app/login%20and%20signup/login.dart';
import 'package:flutter/material.dart';

class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signin();
}

class _signin extends State<signin> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool isLoading = false;
  void despose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void loginUser() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //  Container(alignment: AlignmentDirectional(-1, -1),
              //     child: BackButton(color: Colors.black,),),
              Container(
                alignment: const AlignmentDirectional(-1, -1),
                child: const BackButton(
                  color: Colors.black,
                ),
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
                onTap: () {
                  loginUser();
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Colors.blue,
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Log In",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                  ),
                ),
              ),

              //forgert password

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey),
                  onPressed: () async {},
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
                              builder: (context) => const login()),
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
