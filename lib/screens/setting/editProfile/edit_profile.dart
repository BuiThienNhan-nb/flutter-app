import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DateTime _selectedDate = DateTime.now();
  TextEditingController _textEditingController = TextEditingController();
  bool isObscurePassword = true;
  bool isLoading = false;
  var txtName = TextEditingController();
  var txtPhoneNumber = TextEditingController();
  var txtEmail = TextEditingController();
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
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              print('object');
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()),
                              );
                            },
                            child: Container(
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
                                  image: AssetImage('assets/avt.jpg'),
                                ),
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
                                  print('object');
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
                      buildTextField("Full Name", "Long", false, txtName, true),
                      buildTextField(
                          "SDT", "01234567", false, txtPhoneNumber, true),
                      buildTextField("Email", "longdh210@gmail.com", false,
                          txtEmail, false),
                      TextField(
                        focusNode: AlwaysDisabledFocusNode(),
                        controller: _textEditingController,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        onTap: () {
                          _selectDate(context);
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 5),
                          labelText: 'Birthday',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Sep 21, 1998',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
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
                            setState(() {
                              isLoading = false;
                            });
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

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textEditingController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
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
            children: [
              FlatButton.icon(
                onPressed: () {},
                icon: Icon(Icons.camera),
                label: Text('Camera'),
              ),
              FlatButton.icon(
                onPressed: () {},
                icon: Icon(Icons.image),
                label: Text('Gallery'),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildTextField(
      String labelText,
      String placeholder,
      bool isPasswordTextField,
      TextEditingController controller,
      bool turnOnOff) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        obscureText: isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        controller: controller,
        enabled: turnOnOff,
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
