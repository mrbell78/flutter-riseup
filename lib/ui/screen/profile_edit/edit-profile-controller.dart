import 'package:flutter/cupertino.dart';
import 'package:masterstudy_app/api_rubel_portion/api-service/apiservice.dart';
import 'package:masterstudy_app/locator/locator.dart';
import 'package:masterstudy_app/model/return-obj.dart';
import 'package:masterstudy_app/rb_responsedata/edit-profile-response-data.dart';
import 'package:masterstudy_app/rb_responsedata/user-profile.dart';

class EditProfileController {
  var _apiService = locator<ApiService>();

  EditProfileResponse editProfileResponse;
  UserProfile userProfile;

  Future<ReturnObj> EditProfile(
      first_name,
      last_name,
      phone,
      gender,
      age,

      organization,
      district,
      new_pass,
      new_pass_re,
      designation,)
  async {

    var apiResponse = await _apiService.EditProfile(first_name, last_name, phone, gender, age, organization, district, new_pass:new_pass, new_pass_re:new_pass_re, designation:designation,);
    if (apiResponse.httpCode == 200) {
      editProfileResponse = apiResponse.data;
      return ReturnObj(success: true, data: editProfileResponse);
    } else {
      return ReturnObj(
        success: false,
        message: "Something wrong",
      );
    }
  }


   getUserProfilefull(id) async {

    var apiResponse = await _apiService.getUserProfile(id);
    if (apiResponse.httpCode == 200) {
      userProfile = apiResponse.data;
      print("the data is ${userProfile.meta.phone}.................yes data found");
    } else {
      return ReturnObj(
        success: false,
        message: "Something wrong",
      );
    }
  }

}