import 'package:beyond_wallet/api_services/verify_otp_api.dart';
import 'package:beyond_wallet/models/verify_otp_model.dart';

class VerifyOtpController{
  VerifyOtpRequestModel requestModel;
  VerifyOtpResponseModel responseModel;
  Future<VerifyOtpResponseModel> verifyOtp(String mobileNo, String email) async {
    requestModel = new VerifyOtpRequestModel();
    responseModel = new VerifyOtpResponseModel();
    requestModel.mobile = mobileNo;
    requestModel.email = email;
    responseModel =await VerifyOTPApi().verify(requestModel);
    return responseModel;
  }
}