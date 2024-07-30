import 'package:flutter/material.dart';
import 'package:testflutterapp/repository.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LiveStreamLogin extends StatefulWidget {
  const LiveStreamLogin({super.key});

  @override
  State<LiveStreamLogin> createState() => _LiveStreamLoginState();
}

class _LiveStreamLoginState extends State<LiveStreamLogin> {
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late FocusNode usernameFocusNode;
  late FocusNode passwordFocusNode;
  String? _selectedRole;
  late ValueNotifier obsecurePassword;
  final _formKey = GlobalKey<FormState>();
  final List<String> _roles = ['broadcaster', 'co-broadcaster', 'viewer-realtime', 'viewer-near-realtime'];

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    obsecurePassword = ValueNotifier(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding:(kIsWeb)   ?  const EdgeInsets.only(left: 150.0, right: 150)  :  const  EdgeInsets.only(left: 15.0, right: 15),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: const Key('emailField'),
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "Username",
                    labelText: "Enter Username",
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
                SizedBox(
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
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Role',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedRole,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRole = newValue;
                    });
                  },
                  items: _roles.map((String role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
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
                      if (_formKey.currentState!.validate()) {
                        if (_selectedRole != null && _selectedRole != "Role") {
                          loginUser(_emailController.text,
                              _passwordController.text, context, _selectedRole.toString());
                        } else {
                          var snackBar = const SnackBar(
                            content: Text("Please Select Role"),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    )))
              ],
            ),
          ),
        ),
      ),
    
    );
  }
}