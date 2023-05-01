import 'package:doc_connect_app/components/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isLoading = false;
  bool _obscurePassword = true;
  String _name = '';
  String _email = '';
  String _password = '';
  DateTime _dob = DateTime.now();

  void _signup() {
    if (_formKey.currentState!.validate()) {
      // Perform signup action
      print('Name: $_name');
      print('Email: $_email');
      print('Password: $_password');
      print('Date of Birth: $_dob');

      _handleSignUp();
      // Navigate to home screen after successful signup
      // Navigator.pushNamed(context, '/login');
    }
  }

  void _handleSignUp() async {
    print("In Handle Sing Up");

    try {
      setState(() {
        _isLoading = true;
      });

      showLoadingSnackBar(
          _scaffoldKey.currentContext!, "Creating new user ... ");
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': _name,
        'dob': _dob,
        'isVerified': false,
        'email': _email
      });

      // Navigate to the home screen after successful sign-up.
      _isLoading = false;
      showSuccessSnackBar(_scaffoldKey.currentContext!, 'New User Create!');
      await Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showErrorSnackBar(
            _scaffoldKey.currentContext!, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showErrorSnackBar(_scaffoldKey.currentContext!,
            'The account already exists for that email.');
      } else {
        print('ERROR inside Auth');
        showErrorSnackBar(_scaffoldKey.currentContext!, e.message!);
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('ERROR outsie Auth');
      setState(() {
        _isLoading = false;
      });
      showErrorSnackBar(_scaffoldKey.currentContext!,
          'Sorry we cannot complete your request currently');
    }
  }

  void _goToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Stack(
          children: [
            SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 80, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Welcome to',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/logos/logo-white.png',
                          height: 50,
                          width: 50,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'DocConnect',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      padding: const EdgeInsets.all(32.0),
                      child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 32.0),
                                const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 32.0),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _name = value.trim();
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    hintText: 'Enter your name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    ).then((selectedDate) {
                                      if (selectedDate != null) {
                                        setState(() {
                                          _dob = selectedDate;
                                        });
                                      }
                                    });
                                  },
                                  child: IgnorePointer(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Name',
                                        labelText: 'Date of Birth',
                                        // floatingLabelBehavior:
                                        // FloatingLabelBehavior.always,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade400,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                      ),
                                      controller: TextEditingController(
                                        text: DateFormat('yyyy-MM-dd')
                                            .format(_dob),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your date of birth';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _dob = DateTime.parse(value!);
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _email = value.trim();
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'Enter your email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _password = value.trim();
                                    });
                                  },
                                  obscureText: _obscurePassword,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Your Password',
                                    labelText: 'Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter confirm password';
                                    } else if (value != _password) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Confirm Your Password',
                                    labelText: 'Confirm Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _signup();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Already have an account?',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _goToLogin();
                                      },
                                      child: const Text('Log In',
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                              ])))
                ])),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.8),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ));
  }
}
