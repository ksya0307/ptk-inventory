import 'package:ptk_inventory/sign_up/models/request/sign_up_request.dart';
import 'package:ptk_inventory/sign_up/models/response/sign_up_response.dart';
import 'package:ptk_inventory/sign_up/provider/sign_up_api.dart';

enum SignUpStatus { signed, unsigned }

class SignUpRepository {
  final SignUpProvider _signUpProvider;

  SignUpRepository({SignUpProvider? signUpProvider})
      : _signUpProvider = signUpProvider ?? SignUpProvider();

  Future<SignUpStatus> userSignUp(
    SignUpModelRequest signUpModelRequest,
  ) async {
    try {
      final data = await _signUpProvider.signUp(signUpModelRequest.toMap());
      return SignUpStatus.signed;
    } catch (e) {
      return SignUpStatus.unsigned;
    }
  }
}
