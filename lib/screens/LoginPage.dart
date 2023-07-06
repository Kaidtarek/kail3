import 'package:flutter/material.dart';
import 'package:kafil/Services/Users.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  late Users u;
  late String _email, _pwd;
  final _formKey = GlobalKey<FormState>();
  Future<void> validate() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        barrierDismissible:
            false, // Prevent dismissing the dialog when tapping outside
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16.0),
                  Text("Loading..."),
                ],
              ),
            ),
          );
        },
      );
      u = Users(_email, _pwd);
      await Future.delayed(Duration(seconds: 2));
      Navigator.of(context).pop();
      final msg = await u.login();

      if (msg != "succes") {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
              title: const Text("error"),
              content: Text(msg),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Container(
                    color: Colors.green,
                    padding: const EdgeInsets.all(14),
                    child: const Text("okay"),
                  ),
                ),
              ]),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Text(
                "Login",
                style: TextStyle(fontSize: 48),
              )),
            ),
            SizedBox(
              height: 100,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20, bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        "email",
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: TextFormField(
                            onSaved: (val) {
                              _email = val.toString();
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "this field can't be empty ";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                fillColor: Color.fromARGB(125, 158, 158, 158)),
                          ),
                        )),
                    SizedBox(height: 50),
                    Container(
                      padding: EdgeInsets.only(left: 20, bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        "password",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontFamily: "Poppins-Thin"),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: TextFormField(
                            obscureText: _obscureText,
                            onSaved: (val) {
                              _pwd = val.toString();
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "this field can't be empty ";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                                filled: true,
                                border: InputBorder.none,
                                fillColor: Color.fromARGB(125, 158, 158, 158)),
                          ),
                        )),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90))),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Color(0XFFE464E4),
                            ),
                          ),
                          onPressed: () {
                            validate();
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(fontSize: 15),
                          ),
                        )),
                  ],
                )),
          ]),
        ),
      ),
    );
  }
}
