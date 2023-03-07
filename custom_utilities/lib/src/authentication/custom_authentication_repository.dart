import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../custom_utilities.dart';

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class CustomAuthenticationRepository {
  /// {@macro authentication_repository}
  CustomAuthenticationRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    FacebookAuth? facebookAuth,
    required LoggerService? loggerService,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _facebookAuth = facebookAuth ?? FacebookAuth.instance,
        _loggerService = loggerService;

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  final LoggerService? _loggerService;

  /// Stream of [UserAppModel] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [UserAppModel.empty] if the user is not authenticated.
  Stream<UserAppBaseModel> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null
          ? UserAppBaseModel.empty()
          : firebaseUser.toUser;
    });
  }

  /// Get token user.
  ///
  /// Throws a [GetToken] if an exception occurs.
  Future<String> getToken() async {
    try {
      return (await _firebaseAuth.currentUser?.getIdToken())!;
    } catch (e) {
      _logger(e, null);
      throw GetToken();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      _logger(e, null);
      throw LogInWithGoogleFailure(e);
    }
  }

  Future<void> logInWithFacebook() async {
    try {
      final facebookUser = await _facebookAuth.login();
      final FacebookAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(facebookUser.accessToken!.token)
              as FacebookAuthCredential;

      await _firebaseAuth.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      _logger(e, null);
      throw LogInWithFacebookFailure(e);
    }
  }

  Future<void> logInWithApple() async {
    try {
      final AuthorizationCredentialAppleID appleIdCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oAuthProvider = OAuthProvider('apple.com');
      final OAuthCredential credential = oAuthProvider.credential(
        idToken: appleIdCredential.identityToken,
        accessToken: appleIdCredential.authorizationCode,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      _logger(e, null);
      throw LogInWithAppleFailure(e);
    }
  }

  /// Signs out the current user which will emit
  /// [UserAppModel.empty] from the [UserAppModel] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
        _facebookAuth.logOut(),
      ]);
    } catch (e) {
      _logger(e, null);
      throw LogOutFailure();
    }
  }

  void _logger(dynamic onError, Map<String, dynamic>? jsonMap) {
    _loggerService!.addLogAsync(
      LoggerModel(
        typeError: LoggerTypeEnum.Error,
        // ignore: always_specify_types
        error: {
          'body': onError?.toString(),
        },
        message: onError.message,
        // ignore: always_specify_types
        extraInfo: {
          'query': jsonMap,
        },
      ),
      null,
    );
  }
}
