import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:flutter_app/utils/snack_bar_widget.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/utils/text_field_editProfile.dart';
import 'package:flutter_app/utils/text_field_birthday.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isLoading = false;
  var txtName = TextEditingController();
  var txtPhoneNumber = TextEditingController();
  var txtEmail = TextEditingController();
  File? _pickedImage = null;
  late String url;
  @override
  void initState() {
    super.initState();
    txtName.text = '${UserRepo.customer.name}';
    txtPhoneNumber.text = '${UserRepo.customer.phoneNumber}';
    txtEmail.text = '${UserRepo.customer.email}';
  }

  Future<void> updateInfor() async {
    if (txtName.text != UserRepo.customer.name) {
      UserRepo.customer.name = txtName.text;
      await FirebaseFirestore.instance
          .doc('users/${UserRepo.customer.uid}')
          .update(UserRepo.customer.toMap());
    }
    if (txtPhoneNumber.text != UserRepo.customer.phoneNumber) {
      UserRepo.customer.phoneNumber = txtPhoneNumber.text;
      await FirebaseFirestore.instance
          .doc('users/${UserRepo.customer.uid}')
          .update(UserRepo.customer.toMap());
    }
    if (txtEmail.text != UserRepo.customer.email) {
      UserRepo.customer.email = txtEmail.text;
      await FirebaseFirestore.instance
          .doc('users/${UserRepo.customer.uid}')
          .update(UserRepo.customer.toMap());
    }
  }

  updateImage() async {
    var imageFile = FirebaseStorage.instance
        .ref()
        .child('usersimages')
        .child(UserRepo.customer.name! + '.jpg');
    UploadTask task = imageFile.putFile(_pickedImage!);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    UserRepo.customer.imageUrl = url;
    await FirebaseFirestore.instance
        .doc('users/${UserRepo.customer.uid}')
        .update(UserRepo.customer.toMap());
  }

  Future _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.getImage(source: ImageSource.camera, imageQuality: 100);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  Future _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Stack(
                  overflow: Overflow.visible,
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/background.png',
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: -50.0,
                      child: InkWell(
                        onTap: () {
                          print('object');
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomSheet()),
                          );
                        },
                        child: Stack(
                          children: [
                            // InkWell(
                            //   onTap: () {
                            //     print('object');
                            //     showModalBottomSheet(
                            //       context: context,
                            //       builder: ((builder) => bottomSheet()),
                            //     );
                            //   },
                            //   child:
                            Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 4,
                                  color: Colors.white,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                  )
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: _pickedImage == null &&
                                          UserRepo.customer.imageUrl == null
                                      ? AssetImage('assets/avt.jpg')
                                      : _pickedImage == null &&
                                              UserRepo.customer.imageUrl != null
                                          ? NetworkImage(
                                              UserRepo.customer.imageUrl!)
                                          : _pickedImage != null &&
                                                  UserRepo.customer.imageUrl !=
                                                      null
                                              ? FileImage(_pickedImage!)
                                              : FileImage(_pickedImage!)
                                                  as ImageProvider,
                                ),
                              ),
                            ),
                            // ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Colors.white,
                                  ),
                                  color: Colors.blue,
                                ),
                                child: InkWell(
                                  // onTap: () {
                                  //   print('object');
                                  //   showModalBottomSheet(
                                  //     context: context,
                                  //     builder: ((builder) => bottomSheet()),
                                  //   );
                                  // },
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: -10,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 50.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 80, left: 30, right: 30, bottom: 30),
                  child: Column(
                    children: [
                      TextFieldEditProfile(
                          labelText: "Full Name",
                          placeholder: "Long",
                          controller: txtName,
                          turnOnOff: true,
                          formatter:
                              FilteringTextInputFormatter.singleLineFormatter),
                      TextFieldEditProfile(
                        labelText: "Phone Number",
                        placeholder: "01234567",
                        controller: txtPhoneNumber,
                        turnOnOff: true,
                        formatter: FilteringTextInputFormatter.digitsOnly,
                      ),
                      TextFieldEditProfile(
                          labelText: "Email",
                          placeholder: "longdh210@gmail.com",
                          controller: txtEmail,
                          turnOnOff: false,
                          formatter:
                              FilteringTextInputFormatter.singleLineFormatter),
                      TextFieldBirthday(
                        labelText: "Birthday",
                        placeholder: "Sep 12, 1998",
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(35),
                        child: ElevatedButton(
                          child: isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text('Save'),
                          onPressed: () async {
                            if (isLoading) return;
                            setState(() {
                              isLoading = true;
                            });
                            await updateInfor();
                            if (_pickedImage != null) {
                              await updateImage();
                            }
                            setState(() {
                              isLoading = false;
                            });
                            showSnackbar("Update succesful",
                                'Hello ${UserRepo.customer.name}', true);
                          },
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(fontSize: 28),
                            minimumSize: Size.fromHeight(55),
                            shape: StadiumBorder(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            'Choose Profile photo',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                onPressed: () async {
                  await _pickImageCamera();
                  // _openCamera(context);
                },
                icon: Icon(Icons.camera),
                label: Text('Camera'),
              ),
              FlatButton.icon(
                onPressed: () async {
                  await _pickImageGallery();
                  // _openGallery(context);
                },
                icon: Icon(Icons.image),
                label: Text('Gallery'),
              )
            ],
          )
        ],
      ),
    );
  }
}
