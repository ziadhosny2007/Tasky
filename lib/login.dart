import 'package:flutter/material.dart';
import 'package:tasky/home.dart';
import 'package:tasky/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormFieldState> form = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(),

      body: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 8),

            child: Text(
              "Login",
              style: Theme.of(context).primaryTextTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            child: Form(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    "Username",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: .bold,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        hint: Text(
                          "enter username..",
                          style: TextStyle(
                            color: Color(0xff7F7F7F),
                            fontWeight: .w400,
                            fontSize: 14,
                            letterSpacing: .2,
                          ),
                        ),
                        fillColor: Color(0xffffffff),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xffBABABA)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xffBABABA)),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: .bold,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        hint: Text(
                          "Password..",
                          style: TextStyle(
                            color: Color(0xff7F7F7F),
                            fontWeight: .w400,
                            fontSize: 14,
                            letterSpacing: .2,
                          ),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {},
                          child: Icon(Icons.remove_red_eye_outlined),
                        ),
                        fillColor: Color(0xffffffff),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xffBABABA)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xffBABABA)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Home()),
                          (route) => false,
                        );
                      },
                      height: 48,
                      minWidth: 380,
                      color: Theme.of(context).secondaryHeaderColor,
                      padding: EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 12,
                        bottom: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      //
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            children: [
              Text(
                "Don’t have an account? ",
                style: TextStyle(fontWeight: .w400, fontSize: 16),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontWeight: .w400,
                    fontSize: 16,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
