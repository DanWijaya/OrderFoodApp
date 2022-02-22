import 'package:async/src/result/result.dart';
import 'package:auth/src/domain/auth_service_contract.dart';
import 'package:auth/src/domain/token.dart';
import 'package:auth/src/infra/api/auth_api_contract.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth implements IAuthService {
  final IAuthApi? _authApi;
  GoogleSignIn? _googleSignIn;
  GoogleSignInAccount? _currentUser;

  GoogleAuth(this._authApi, [GoogleSignIn? googleSignIn])
      : this._googleSignIn = googleSignIn;

  @override
  Future<Result<Token>> signIn() {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
