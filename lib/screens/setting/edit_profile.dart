import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/home/destination_detail/all_comment.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:flutter_app/utils/snack_bar_widget.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/utils/text_field_editProfile.dart';
import 'package:flutter_app/utils/text_field_birthday.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shimmer/shimmer.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isLoading = false;
  var formKey = GlobalKey<FormState>();
  var txtName = TextEditingController();
  var txtPhoneNumber = TextEditingController();
  var txtEmail = TextEditingController();
  var txtBirthday = TextEditingController();
  List<String> listKey = [];
  final List<String> listDes = [];
  // DateTime birthdayDB = DateTime.now();
  File? _pickedImage = null;
  late String url;

  @override
  void dispose() {
    super.dispose();
    txtName.dispose();
    txtPhoneNumber.dispose();
    txtEmail.dispose();
    txtBirthday.dispose();
  }

  @override
  void initState() {
    super.initState();
    txtName.text = '${UserRepo.customer.name}';
    txtPhoneNumber.text = '${UserRepo.customer.phoneNumber}';
    txtEmail.text = '${UserRepo.customer.email}';
    txtBirthday.text =
        '${DateFormat('dd/MM/yyyy').format(UserRepo.customer.birthday!.toDate())}';
  }

  Future<void> updateInfor() async {
    if (formKey.currentState!.validate()) {
      if (txtName.text != UserRepo.customer.name ||
          txtPhoneNumber.text != UserRepo.customer.phoneNumber ||
          txtEmail.text != UserRepo.customer.email ||
          txtBirthday.text.compareTo(DateFormat('dd/MM/yyyy')
                  .format(UserRepo.customer.birthday!.toDate())) !=
              0) {
        UserRepo.customer.name = txtName.text;
        UserRepo.customer.phoneNumber = txtPhoneNumber.text;
        UserRepo.customer.email = txtEmail.text;
        UserRepo.customer.birthday = Timestamp.fromDate(
            DateFormat('dd/MM/yyyy').parse(txtBirthday.text));
        await FirebaseFirestore.instance
            .doc('users/${UserRepo.customer.uid}')
            .update(UserRepo.customer.toMap());

        // update name to firebase realtime
        await updateNameToRealtime();
        // await updateNameToRealtime();

        showSnackbar(
            "Update succesful", 'Hello ${UserRepo.customer.name}', true);
      }
    }
    setState(() {});
  }

  Future<void> updateNameToRealtime() async {
    await getListKeyComment();

    listDes.toSet().toList().forEach((des) {
      // print(des);
      listKey.toSet().toList().forEach((key) {
        FirebaseDatabase.instance
            .reference()
            .child('users')
            .child('destination: $des')
            .child(key)
            .once()
            .then((snapshot) async {
          if (snapshot.value != null) {
            if (snapshot.value['id'] != null &&
                snapshot.value['id'] == UserRepo.customer.uid) {
              print('$des - $key');
              await FirebaseDatabase.instance
                  .reference()
                  .child('users')
                  .child('destination: $des')
                  .child(key)
                  .update({'name': UserRepo.customer.name});
            }
          }
        });
      });
    });
  }

  Future<void> updateImage() async {
    var imageFile = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('avatar')
        .child(UserRepo.customer.uid + '.jpg');
    UploadTask task = imageFile.putFile(_pickedImage!);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    UserRepo.customer.imageUrl = url;
    await FirebaseFirestore.instance
        .doc('users/${UserRepo.customer.uid}')
        .update(UserRepo.customer.toMap());

    // update image to firebase realtime
    await getListKeyComment();
    print(listDes);
    listDes.toSet().toList().forEach((des) {
      listKey.toSet().toList().forEach((key) {
        print('$des - $key');
        FirebaseDatabase.instance
            .reference()
            .child('users')
            .child('destination: $des')
            .child(key)
            .once()
            .then((snapshot) async {
          if (snapshot.value != null) {
            if (snapshot.value['id'] != null &&
                snapshot.value['id'] == UserRepo.customer.uid) {
              print('$des - $key');
              await FirebaseDatabase.instance
                  .reference()
                  .child('users')
                  .child('destination: $des')
                  .child(key)
                  .update({'image': UserRepo.customer.imageUrl});
            }
          }
        });
      });
    });
    _pickedImage = null;
  }

  void getListDes(key) async {
    await FirebaseDatabase.instance
        .reference()
        .child('comments')
        .child(UserRepo.customer.uid)
        .child(key)
        .once()
        .then((snapshot) {
      // print(snapshot.value['destination']);
      listDes.add(snapshot.value['destination']);
    });
    // print(listDes.toSet().toList());
  }

  Future<void> getListKeyComment() async {
    FirebaseDatabase.instance
        .reference()
        .child('keys')
        .child(UserRepo.customer.uid)
        .orderByChild('key')
        .onChildAdded
        .forEach((key) async {
      // print(key.snapshot.value['key']);
      getListDes(key.snapshot.value['key']);
      listKey.add(key.snapshot.value['key']);
      // print(listKey);
    });
    print(listKey);
  }

  Future _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.getImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedImage != null) {
      final pickedImageFile = File(pickedImage.path);
      setState(() {
        _pickedImage = pickedImageFile;
      });
    }
    Navigator.pop(context);
  }

  Future _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final pickedImageFile = File(pickedImage.path);
      setState(() {
        _pickedImage = pickedImageFile;
      });
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size sizeDevice = MediaQuery.of(context).size;
    final sizeWidth = sizeDevice.width;
    final sizeHeight = sizeDevice.height;
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: sizeHeight / 4,
                  width: sizeWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/backgroundTravel.jpg'),
                        fit: BoxFit.fill),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: FlatButton(
                      height: 50,
                      minWidth: 50,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: sizeHeight * (3 / 20),
                right: sizeWidth * 1 / 3,
                child: Stack(
                  children: [
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
                      ),
                      child: ClipOval(
                        child: _pickedImage == null &&
                                UserRepo.customer.imageUrl == ""
                            ? Container(
                                color: Colors.grey.shade400,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 100,
                                ),
                              )
                            : _pickedImage == null &&
                                    UserRepo.customer.imageUrl != ""
                                ? CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: UserRepo.customer.imageUrl!,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.grey.shade200,
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : _pickedImage != null &&
                                        UserRepo.customer.imageUrl != ""
                                    ? CircleAvatar(
                                        backgroundImage:
                                            FileImage(_pickedImage!),
                                      )
                                    : CircleAvatar(
                                        backgroundImage:
                                            FileImage(_pickedImage!),
                                      ),
                      ),
                    ),
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
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: ((builder) => bottomSheet()),
                            );
                          },
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
              Positioned(
                top: 200,
                right: 0,
                left: 0,
                child: Container(
                  padding:
                      EdgeInsets.only(top: 80, left: 30, right: 30, bottom: 30),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFieldEditProfile(
                          labelText: "Full Name",
                          placeholder: "Long",
                          controller: txtName,
                          turnOnOff: true,
                          formatter:
                              FilteringTextInputFormatter.singleLineFormatter,
                          typeValidation: 'name',
                          textInputType: TextInputType.name,
                        ),
                        TextFieldEditProfile(
                          labelText: "Phone Number",
                          placeholder: "01234567",
                          controller: txtPhoneNumber,
                          turnOnOff: true,
                          formatter: FilteringTextInputFormatter.digitsOnly,
                          typeValidation: 'phone',
                          textInputType: TextInputType.phone,
                        ),
                        TextFieldEditProfile(
                          labelText: "Email",
                          placeholder: "longdh210@gmail.com",
                          controller: txtEmail,
                          turnOnOff: false,
                          formatter:
                              FilteringTextInputFormatter.singleLineFormatter,
                          typeValidation: '',
                          textInputType: TextInputType.emailAddress,
                        ),
                        TextFieldBirthday(
                          labelText: "Birthday",
                          placeholder: "Sep 12, 1998",
                          textEditingController: txtBirthday,
                          callback: (_newDateString) =>
                              setState(() => txtBirthday.text = _newDateString),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(35),
                          width: 200,
                          child: ElevatedButton(
                            child: isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text('Save'),
                            onPressed: txtName.text == UserRepo.customer.name &&
                                    txtPhoneNumber.text ==
                                        UserRepo.customer.phoneNumber &&
                                    txtEmail.text == UserRepo.customer.email &&
                                    txtBirthday.text.compareTo(
                                            DateFormat('dd/MM/yyyy').format(
                                                UserRepo.customer.birthday!
                                                    .toDate())) ==
                                        0 &&
                                    _pickedImage == null
                                ? null
                                : () async {
                                    if (isLoading) return;
                                    setState(() {
                                      isLoading = true;
                                    });
                                    if (txtName.text !=
                                            UserRepo.customer.name ||
                                        txtPhoneNumber.text !=
                                            UserRepo.customer.phoneNumber ||
                                        txtEmail.text !=
                                            UserRepo.customer.email ||
                                        txtBirthday.text.compareTo(
                                                DateFormat('dd/MM/yyyy').format(
                                                    UserRepo.customer.birthday!
                                                        .toDate())) !=
                                            0) {
                                      await updateInfor();
                                      await updateInfor();
                                      await updateInfor();
                                    }
                                    if (_pickedImage != null) {
                                      await updateImage();
                                      showSnackbar(
                                          "Update succesful",
                                          'Hello ${UserRepo.customer.name}',
                                          true);
                                    }
                                    if (txtName.text ==
                                            UserRepo.customer.name &&
                                        txtPhoneNumber.text ==
                                            UserRepo.customer.phoneNumber &&
                                        txtEmail.text ==
                                            UserRepo.customer.email &&
                                        txtBirthday.text.compareTo(
                                                DateFormat('dd/MM/yyyy').format(
                                                    UserRepo.customer.birthday!
                                                        .toDate())) ==
                                            0) {
                                      showSnackbar(
                                          "Everything is up to date",
                                          'Hello ${UserRepo.customer.name}',
                                          true);
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                            style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(
                                    fontSize: 25, color: Colors.white),
                                minimumSize: Size.fromHeight(50),
                                shape: StadiumBorder()),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
