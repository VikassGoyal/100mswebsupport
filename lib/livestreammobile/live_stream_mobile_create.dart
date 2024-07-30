import 'package:flutter/material.dart';
import 'package:testflutterapp/livestream/live_stream_login.dart';
import 'package:testflutterapp/livestreammobile/live_stream_mobile_login.dart';
import 'package:testflutterapp/repository.dart';

class LiveStreamMobileCreate extends StatefulWidget {
  const LiveStreamMobileCreate({super.key});

  @override
  State<LiveStreamMobileCreate> createState() => _LiveStreamMobileCreateState();
}

class _LiveStreamMobileCreateState extends State<LiveStreamMobileCreate> {
  late TextEditingController _passwordController;
   late TextEditingController _nameController;
  late TextEditingController _emailController;
  late FocusNode usernameFocusNode;
  late FocusNode passwordFocusNode;
  
  late ValueNotifier obsecurePassword;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _nameController =TextEditingController();
    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    obsecurePassword = ValueNotifier(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 TextFormField(
                  key: const Key('nameField'),
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: "Username",
                    labelText: "Enter Username",
                    prefixIcon: Icon(
                      Icons.account_box ,
                      size: 28,
                    ),
                  ),
                  cursorColor: Colors.black,
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(passwordFocusNode);
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Please enter a name";
                    }
                    return null;
                  },
                ),
                 const SizedBox(
                  height: 20,
                ),

                TextFormField(
                  key: const Key('emailField'),
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "UserEmail",
                    labelText: "Enter Email",
                    prefixIcon: Icon(
                      Icons.email,
                      size: 28,
                    ),
                  ),
                  cursorColor: Colors.black,
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(passwordFocusNode);
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Please enter a email";
                    }
                    return null;
                  },
                ),
             const    SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder(
                    valueListenable: obsecurePassword,
                    builder: ((context, value, child) {
                      return TextFormField(
                        key: const Key('passwordField'),
                        controller: _passwordController,
                        obscureText: obsecurePassword.value,
                        decoration: InputDecoration(
                            hintText: "Password",
                            labelText: "Enter Password",
                            isDense: true,
                            prefixIcon: const Icon(
                              Icons.lock,
                              size: 28,
                            ),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  obsecurePassword.value =
                                      !obsecurePassword.value;
                                },
                                child: obsecurePassword.value
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility))),
                        cursorColor: Colors.black,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context)
                              .requestFocus(passwordFocusNode);
                        },
                        validator: (v) {
                          if (v == null || v.isEmpty || v.length < 5) {
                            return v!.isEmpty
                                ? "Please enter password"
                                : v.length < 5
                                    ? "please enter 6 digit password"
                                    : "Please enter password";
                          }
                          return null;
                        },
                      );
                    })),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                  signUpUser( _nameController.text ,_emailController.text, _passwordController.text , context);
                     
                    }
                    },
                    child: const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "SignUp",
                        style: TextStyle(color: Colors.white),
                      ),
                    ))),

              TextButton(onPressed: (){
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  const LiveStreamMobileLogin(),
              ),
            );

              }, child: const  Text("Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
