import 'package:async/src/result/result.dart';
import 'package:auth/src/domain/auth_service_contract.dart';
import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/domain/token.dart';
import 'package:auth/src/infra/api/auth_api_contract.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth implements IAuthService {
  final IAuthApi _authApi;
  GoogleSignIn _googleSignIn;
  GoogleSignInAccount? _currentUser;

  GoogleAuth(this._authApi, [GoogleSignIn? googleSignIn])
      : this._googleSignIn =
            googleSignIn ?? GoogleSignIn(scopes: ['email', 'profile']);

  @override
  Future<Result<Token>> signIn() async {
    // TODO: implement signIn

    await _handleGoogleSignIn();
    if (_currentUser == null)
      return Result<Token>.error('Failed to sign in with Google');
    try {
      Credential credential = Credential(
          type: AuthType.email,
          email: _currentUser!.email,
          name: _currentUser!.displayName);
      var result = await _authApi.signIn(credential);
      return Result<Token>.value(Token(result.asValue!.value));
    } catch (err) {
      return Result<Token>.error(err);
    }
  }

  @override
  Future<void> signOut() async {
    // TODO: implement signOut
    _googleSignIn.disconnect();
  }

  _handleGoogleSignIn() async {
    try {
      _currentUser = await _googleSignIn.signIn();
    } catch (error) {
      return;
    }
  }
}
