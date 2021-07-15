import 'package:flutter/cupertino.dart';
import 'package:masterstudy_app/locator/locator.dart';
import 'package:masterstudy_app/rb_responsedata/edit-profile-response-data.dart';
import 'package:masterstudy_app/rb_responsedata/user-profile.dart';
import 'package:masterstudy_app/utils/apiconstant.dart';

import '../api_response.dart';
import '../http_service.dart';

class ApiService{

  var _httpService = locator<HttpService>();

  Future<ApiResponse<EditProfileResponse>> EditProfile(first_name, last_name, phone, gender, age, organization, district, {new_pass, new_pass_re, designation,}) async {
    var apiResponse = await _httpService.postRequest(ApiConst.BASE_URL+"wp-json/ms_lms/v1/account/edit_profile/", data: {
      "first_name": first_name,
      "last_name": last_name,
      "phone": phone,
      "gender": gender,
      "age": age,
      "organization": organization,
      "district": district,
      "new_pass": new_pass,
      "new_pass_re": new_pass_re,
      "designation": designation,
    },isFormData: true);
    return ApiResponse(
      httpCode: apiResponse.httpCode,
      message: apiResponse.message,
      data: apiResponse.httpCode == 200 ? EditProfileResponse.fromJson(apiResponse.data.data) : null,
    );
  }


  Future<ApiResponse<UserProfile>> getUserProfile(id) async {
    var apiResponse = await _httpService.getRequest(ApiConst.BASE_URL+"wp-json/ms_lms/v1/account/",qp: {
      "id": 24.toString()
    });
    return ApiResponse(
      httpCode: apiResponse.httpCode,
      message: apiResponse.message,
      data: apiResponse.httpCode == 200 ? UserProfile.fromJson(apiResponse.data.data) : null,
    );
  }
}