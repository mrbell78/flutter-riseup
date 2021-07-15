import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masterstudy_app/api_rubel_portion/api-service/apiservice.dart';
import 'package:masterstudy_app/data/models/account.dart';
import 'package:masterstudy_app/locator/locator.dart';
import 'package:masterstudy_app/main.dart';
import 'package:masterstudy_app/rb_responsedata/user-profile.dart';
import 'package:masterstudy_app/theme/theme.dart';
import 'package:masterstudy_app/ui/bloc/edit_profile_bloc/bloc.dart';
import 'package:masterstudy_app/ui/bloc/profile/profile_bloc.dart';
import 'package:masterstudy_app/ui/bloc/profile/profile_event.dart';
import 'package:masterstudy_app/ui/screen/profile_edit/edit-profile-controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

class ProfileEditScreenArgs {
  final Account account;

  ProfileEditScreenArgs(this.account);
}

class ProfileEditScreen extends StatelessWidget {
  static const routeName = "profileEditScreen";
  ProfileEditScreenArgs args;
  final EditProfileBloc bloc;

  ProfileEditScreen(this.bloc) : super();

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    return BlocProvider(
      create: (context) => bloc..account = args.account,
      child: _ProfileEditWidget(),
    );
  }
}

class _ProfileEditWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileEditWidgetState();
  }
}

class _ProfileEditWidgetState extends State<_ProfileEditWidget> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _occupationController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _facebookController = TextEditingController();
  TextEditingController _twitterController = TextEditingController();
  TextEditingController _instagramController = TextEditingController();



  TextEditingController _loginController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _designationController = TextEditingController();
  TextEditingController _organizationController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _passwordnew = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();


  var enableInputs = true;

  var passwordVisible = false;

  UserProfile userProfile;
  int radiovalue;
  EditProfileBloc _bloc;
  EditProfileController coobj;
  String districvaluechose;
  String agevaluechose;
  List<String> listitemDistrict = ["Lakshmipur" ,"Dhaka", "Chattagram","Khulna","Gajipur","maymangsing","tangaile"];

  List<String> listitemage = ["2" ,"3", "4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36"];

  var _apiService = locator<ApiService>();
  @override
  void initState() {

    coobj  = new EditProfileController();
    radiovalue=0;
    getUserProfilefull(24.toString());
    super.initState();
  }

  getUserProfilefull(id) async {

    var apiResponse = await _apiService.getUserProfile(id);
    if (apiResponse.httpCode == 200) {
      userProfile = apiResponse.data;
      setState(() {
        _firstNameController.text = userProfile.meta.firstName;
        _lastNameController.text = userProfile.meta.lastName;
        //districvaluechose=userProfile.meta.district;
        //agevaluechose=userProfile.meta.age;
        radiovalue=userProfile.meta.gender=="Male"?0:1;
        _designationController.text= userProfile.meta.designation;
        _organizationController.text=userProfile.meta.organization;
        _phoneNumberController.text=userProfile.meta.phone;
      });
      print("the data is ${userProfile.meta.phone}.................yes data found");
    } else {

    }
  }

  _saveForm() {
    if (_formKey.currentState.validate()) {
      _bloc.add(SaveEvent(
          _firstNameController.text,
          _lastNameController.text,
          _passwordController.text,
          _bioController.text,
          _occupationController.text,
          _facebookController.text,
          _twitterController.text,
          _instagramController.text,
          _image));

    }
  }

  _setradiovlue(int value){

    setState(() {

      radiovalue=value;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            localizations.getLocalization("edit_profile_title"),
            textScaleFactor: 1.0,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocListener(
          bloc: _bloc,
          listener: (context, state) {
            if (state is CloseEditProfileState) {
              BlocProvider.of<ProfileBloc>(context)..add(FetchProfileEvent());

              Scaffold.of(context)
                  .showSnackBar(SnackBar(
                    content: Text(
                      localizations.getLocalization("profile_updated_message"),
                      textScaleFactor: 1.0,
                    ),
                    duration: Duration(seconds: 2),
                  ))
                  .closed
                  .then((reason) {
                Navigator.of(context).pop(true);
              });
            }
          },
          child: BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              return _buildBody(state);
            },
          ),
        ));
  }

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  _buildBody(state) {
    enableInputs = !(state is LoadingEditProfileState);

    final Widget svg = SvgPicture.asset(
      "assets/icons/file_icon.svg",
      color: Colors.white,
    );
    Widget image;

    if (_image != null) {
      image = Image.file(
        _image,
        width: 70,
        height: 70,
        fit: BoxFit.cover,
      );
    } else {
      image = SizedBox(
        width: 100,
        height: 100,
        child: SvgPicture.asset(
          "assets/icons/empty_user.svg",
        ),
      );
    }

    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8),
            child: Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60.0),
                  child: image,
                ),
              ),
            ),
          ),
          Center(
            child: FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(32.0),
                  side: BorderSide(color: secondColor)),
              color: secondColor,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              onPressed: getImage,
              child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        child: svg,
                        width: 23,
                        height: 23,
                      ),
                      Text(
                        localizations.getLocalization("change_photo_button"),
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: TextFormField(
              controller: _firstNameController,
              enabled: enableInputs,
              decoration: InputDecoration(
                  labelText: "first name",
                  filled: true),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please Enter your First Name";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: TextFormField(
              controller: _lastNameController,
              enabled: enableInputs,
              decoration: InputDecoration(
                  labelText: "last name",
                  filled: true),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please Enter your Last Name";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: TextFormField(
              controller: _phoneNumberController,
              enabled: enableInputs,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "phone",
                  filled: true),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please Enter your Phone Number";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: TextFormField(
              controller: _designationController,
              enabled: enableInputs,

              decoration: InputDecoration(
                  labelText: "Designation",

              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please Enter your Designation";
                }
                return null;
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: TextFormField(
              controller: _passwordnew,
              enabled: enableInputs,
              obscureText: passwordVisible,
              decoration: InputDecoration(
                  labelText:"password",

                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    color: Theme.of(context).primaryColorDark,
                  )),
              validator: (value) {
                if (value.isEmpty) {
                  return null;
                } else {
                  if (value.length < 8) {
                    return localizations.getLocalization(
                        "password_register_characters_count_error_text");
                  }
                }

                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: TextFormField(

              controller: _confirmpassword,
              enabled: enableInputs,
              obscureText: passwordVisible,
              decoration: InputDecoration(
                  labelText:"Confirm password",

                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    color: Theme.of(context).primaryColorDark,
                  )),
              validator: (value) {
                if (value.isEmpty) {
                  return null;
                } else {
                  if (value.length < 8) {
                    return localizations.getLocalization(
                        "password_register_characters_count_error_text");
                  }
                }

                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: TextFormField(
              controller: _organizationController,
              enabled: enableInputs,
              obscureText: passwordVisible,
              decoration: InputDecoration(
                  labelText:"organization",

                  filled: true,
                 ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please Enter your Organization Name";
                }
                return null;
              },

            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: Container(
              child: DropdownButton(

                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down),
                hint: Text("Select District"),
                value: districvaluechose,
                onChanged: (newvalue){
                  setState(() {
                    districvaluechose=newvalue;
                  });
              },
                items: listitemDistrict.map((valueitem){
                  return DropdownMenuItem(
                      value: valueitem,
                      child: Text(valueitem));
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: Container(
              child: DropdownButton(
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down),
                hint: Text("your  Age"),
                value: agevaluechose,
                onChanged: (newvalue){
                  setState(() {
                    agevaluechose=newvalue;
                  });
                },
                items: listitemage.map((valueitem){
                  return DropdownMenuItem(
                      value: valueitem,
                      child: Text(valueitem));
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: Container(
              width: double.infinity,
              height: 80,
              child: ButtonBar(
                alignment:MainAxisAlignment.start ,
                children: [

                  Text("Gender"),
                  Radio(
                    value: 1,
                    groupValue: radiovalue,
                    activeColor: Colors.blue,
                    onChanged: (val){
                      print("radio $val");
                      _setradiovlue(val);
                    },
                  ),
                  Text("Male"),

                  Radio(
                    value: 2,
                    groupValue: radiovalue,
                    activeColor: Colors.blue,
                    onChanged: (val){
                      print("radio $val");
                      _setradiovlue(val);
                    },
                  ),

                  Text("Female"),
                ],
              ),
            )
          ),

          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
            child: new MaterialButton(
              minWidth: double.infinity,
              color: mainColor,
              onPressed: () {
                setState(() {
                  coobj.EditProfile(_firstNameController.text, _lastNameController.text, _phoneNumberController.text.toString(), radiovalue==1?"male":"female",agevaluechose,
                      _organizationController.text,districvaluechose, _passwordnew.text, _confirmpassword.text, _designationController.text);
                });
                _saveForm();
              },
              child: setUpButtonChild(enableInputs),
              textColor: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
              right: 18.0,
            ),
            child: FlatButton(
              child: Text(
                localizations.getLocalization("cancel_button"),
                textScaleFactor: 1.0,
                style: TextStyle(color: mainColor),
              ),
              onPressed: () {
                _bloc.add(CloseScreenEvent());
              },
            ),
          )
        ],
      ),
    );
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return localizations.getLocalization("email_empty_error_text");
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return localizations.getLocalization("email_invalid_error_text");
  }
}

Widget setUpButtonChild(enable) {
  if (enable == true) {
    return new Text(
      localizations.getLocalization("save_button"),
      textScaleFactor: 1.0,
    );
  } else {
    return SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.white),
      ),
    );
  }
}
