import 'package:crypto_currency/data/sharedPreferences.dart';
import 'package:crypto_currency/ui/main_warper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isOscure = true;

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Lottie.asset(
              'images/signup.animation.json',
              height: height * 0.3,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.01),
                child: Text(
                  'Sign UP',
                  style: GoogleFonts.ubuntu(
                    fontSize: height * 0.035,
                    color: Theme.of(context).unselectedWidgetColor,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Text(
                  'Create Account',
                  style: GoogleFonts.ubuntu(
                    fontSize: height * 0.03,
                    color: Theme.of(context).unselectedWidgetColor,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            SizedBox(height: height * 0.03),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: height * 0.05),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "Full name",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            contentPadding: const EdgeInsets.all(16)),
                        controller: nameController,
                        validator: (name) {
                          if (name == null || name.isEmpty) {
                            return "Please enter your name";
                          } else if (name.length < 4) {
                            return "At least enter 4 charaters for the name field";
                          } else if (name.length > 15) {
                            return "Maximum charracter is 15";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            hintText: "Email",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            contentPadding: const EdgeInsets.all(16)),
                        controller: emailController,
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return "Please enter your email";
                          } else if (!email.trim().endsWith("@gmail.com")) {
                            return "Invalid Email!";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        obscureText: _isOscure,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: Icon(_isOscure ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isOscure = !_isOscure;
                              });
                              print(_isOscure);
                            },
                          ),
                          hintText: "Password",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        controller: passwordController,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return "Please enter your password";
                          } else if (password.length < 4) {
                            return "At least enter 6 charaters";
                          } else if (password.length > 15) {
                            return "Maximum charracter is 15";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        'When you sign up it means you are agree with our Terms of Services and our Privacy Policy',
                        style: TextStyle(fontSize: height * 0.015),
                      ),
                      SizedBox(height: height * 0.02),
                      signupBtn(),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget signupBtn() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainWraper(),
                ));

            await SharedPreferences.getInstance();
            await SharedPref().signUp();
          }
        },
        child: Text('Sign Up'),
      ),
    );
  }

  Future<void> signUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainWraper(),
          ));
      SharedPref().signUp();
    }
  }
}
