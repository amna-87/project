import 'package:diary/Login/signup.dart';
import 'package:diary/employees.dart/employees.dart';
import 'package:diary/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;
  get checkBoxValue => null;
  bool _checkbox = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        elevation: 0.0, // Remove the shadow below the app bar
        backgroundColor: const Color.fromARGB(
            255, 11, 70, 119), // Set the background color of the app bar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(
                        255, 170, 187, 201), // Change label color
                  ),
                  prefixIcon: Icon(Icons.email),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue), // Change border color when focused
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .grey), // Change border color when not focused
                  ),
                ),
                style: const TextStyle(
                  color: Colors.black, // Change text color
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(
                        255, 170, 187, 201), // Change label color
                  ),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.visibility),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 122, 175,
                            213)), // Change border color when focused
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .grey), // Change border color when not focused
                  ),
                ),
                style: const TextStyle(
                  color: Colors.black, // Change text color
                ),
              ),
              CheckboxListTile(
                title: const Text(
                  'Remember Password',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                value: _checkbox,
                onChanged: (value) {
                  // widget.callback(value!);
                  setState(() => _checkbox = !_checkbox);
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  print('Email: ${_emailController.text}');
                  print('Password: ${_passwordController.text}');
                  try {
                    auth
                        .signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text)
                        .then((value) {
                      setState(() {
                        loading = false;
                      });

                      Utils().toastMessage(
                        'Login successfull',
                        const Color.fromARGB(255, 15, 75, 124),
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return const Employees();
                        },
                      ));
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(
                        'An error occured',
                        Colors.red,
                      );
                      setState(() {
                        loading = false;
                      });
                    });
                  } catch (e) {
                    Utils().toastMessage('An error occured', Colors.red);
                    setState(() {
                      loading = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 15, 75, 124),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 14.0),
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text('Login'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account? '),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const SignupPage();
                          },
                        ));
                      },
                      child: const Text('Signup'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
