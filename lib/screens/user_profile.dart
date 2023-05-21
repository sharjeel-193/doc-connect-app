import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_connect_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/snackbars.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late UserModel _user;
  late UserModel _editableUser;
  bool _isLoading = true;
  bool _editMode = false;
  String? _error;
  String? _profileImg;
  String? _userId;
  String? _loadingMsg = 'Fetching User Data ...';
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      print("USER DATA 1");
      print(userDoc.data()!);
      setState(() {
        _user = UserModel.fromJson(userDoc.data()!);
        _editableUser = UserModel.fromJson(userDoc.data()!);
        if (_user.profileImgUrl == null) {
          _profileImg = 'assets/images/dummy-profile-pic.jpg';
        } else {
          _profileImg = _user.profileImgUrl;
        }
        _userId = FirebaseAuth.instance.currentUser!.uid;
        print(_user);
        _error = null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveUserData() async {
    try {
      setState(() {
        _isLoading = true;
        _loadingMsg = 'Updating User Details';
      });

      final userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);

      // Create a map with the updated data
      Map<String, dynamic> updatedData = _editableUser.toJson();

      // Save the updated data to the database
      await userRef.update(updatedData);

      // Update the _user variable with the updated data
      setState(() {
        _user = _editableUser;
        _error = null;
        _isLoading = false;
      });
      showSuccessSnackBar(_scaffoldKey.currentContext!, 'User Details Updated');
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  Future<void> _uploadNewProfileImg() async {
    //Get the file from the image picker and store it
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    try {
      final file = File(pickedFile.path);
      final fileName = path.basename(file.path);
      final destination = 'profile_pics/$_userId/$fileName';

      // Upload image to Firebase storage
      final ref = _storage.ref(destination);
      await ref.putFile(file);

      // Get download URL of uploaded image
      final downloadUrl = await ref.getDownloadURL();

      // Save download URL to Firestore
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(_userId);
      await userRef.update({'profileImgUrl': downloadUrl});
    } catch (e) {
      print(e);
      showErrorSnackBar(_scaffoldKey.currentContext!,
          'Sorry we cannot complete your request currently');
    }
  }

  void _viewImage(String imageUrl) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            body: Center(
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('User Profile'),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: _isLoading
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(_loadingMsg!)
                ],
              ))
            : _error != null
                ? Center(child: Text('Error: $_error'))
                : Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // User image with edit option
                        InkWell(
                            onTap: () {
                              // Handle image edit
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: const Icon(Icons.photo_camera),
                                        title: const Text('Upload New Image'),
                                        onTap: () {
                                          // Handle upload new image option
                                          _uploadNewProfileImg();
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.photo),
                                        title: const Text('View Photo'),
                                        onTap: () {
                                          // Handle view photo option
                                          _viewImage(_user.profileImgUrl!);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: _user.profileImgUrl == null
                                ? CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: AssetImage(_profileImg!))
                                : CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage:
                                        NetworkImage(_profileImg!))),
                        // Personal details with edit button
                        if (!_editMode)
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 16.0),
                                    const Expanded(
                                      child: Text('Personal Details',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _editMode = !_editMode;
                                        });
                                      },
                                      child: const Text('Edit'),
                                    ),
                                    const SizedBox(width: 16.0),
                                  ],
                                ),
                                // User details
                                ListTile(
                                  leading: Icon(
                                    Icons.person,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  title: Text(_user.name!),
                                  subtitle: const Text('Name'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.email,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  title: Text(_user.email),
                                  subtitle: const Text('Email'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.calendar_today,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  title: Text(getCurrentDate(_user.dob!)),
                                  subtitle: const Text('Date of Birth'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.wc,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  title: Text(_user.gender ?? 'Unidentified'),
                                  subtitle: const Text('Gender'),
                                ),
                              ],
                            ),
                          )
                        else
                          // EDIT MODE PART
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 16.0),
                                    const Expanded(
                                      child: Text('Edit Your Details',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _editMode = !_editMode;
                                        });
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    const SizedBox(width: 16.0),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Name',
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      )),
                                  initialValue: _editableUser.name,
                                  onChanged: (value) {
                                    setState(() {
                                      _editableUser.name = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                InkWell(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return Theme(
                                          data: ThemeData.light().copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    ).then((selectedDate) {
                                      if (selectedDate != null) {
                                        setState(() {
                                          _editableUser.dob = selectedDate;
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
                                            .format(_editableUser.dob!),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your date of birth';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _user.dob = DateTime.parse(value!);
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                ElevatedButton(
                                  onPressed: () {
                                    _saveUserData();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                  child: const Text(
                                    'Save Details',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  ));
  }

  String getCurrentDate(DateTime dateValue) {
    var date = dateValue.toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
  }
}
