import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class facebookLogin extends StatefulWidget {
  const facebookLogin({super.key});

  @override
  State<facebookLogin> createState() => _facebookLoginState();
}

class _facebookLoginState extends State<facebookLogin> {

  Map<String, dynamic>? _userData;
  bool _checking = true;
  // ignore: unused_field
  AccessToken? _accessToken;
  @override
  void initState() {
    super.initState();
    _checkFristLogin();
  }

  _checkFristLogin() async {
    final accessToken = await FacebookAuth.instance.accessToken;

    setState(() {
      _checking = false;
    });

    if (accessToken != null) {
      print(accessToken.toJson());
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    } else {
      _loginFacebook();
    }
  }

  //function login
  _loginFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;

      print(result.status);
      print(result.message);
    }
    setState(() {
      _checking = false;
    });
  }

  //function logout
  _logoutFacebook() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Facebook Auth Project')),
        body: _checking
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _userData != null
                      ? Text('name: ${_userData!['name']}')
                      : Container(),
                  _userData != null
                      ? Text('email: ${_userData!['email']}')
                      : Container(),
                  _userData != null
                      ? Container(
                          child: Image.network(
                              _userData!['picture']['data']['url']),
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  CupertinoButton(color: Colors.blue,
                      child: Text(
                        _userData != null ? 'LOGOUT' : 'LOGIN',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _userData != null ? _logoutFacebook() : _loginFacebook())
                ],
              )),
      ),
    );
  }
}


class facebookLogins extends StatefulWidget {
  final FacebookLogin plugin;

  const facebookLogins({Key? key, required this.plugin}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<facebookLogins> {
  String? _sdkVersion;
  FacebookAccessToken? _token;
  FacebookUserProfile? _profile;
  String? _email;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();

    _getSdkVersion();
    _updateLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = _token != null && _profile != null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login via Facebook example'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              if (_sdkVersion != null) Text('SDK v$_sdkVersion'),
              if (isLogin)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildUserInfo(context, _profile!, _token!, _email),
                ),
              isLogin
                  ? OutlinedButton(
                      child: const Text('Log Out'),
                      onPressed: _onPressedLogOutButton,
                    )
                  : OutlinedButton(
                      child: const Text('Log In'),
                      onPressed: _onPressedLogInButton,
                    ),
              if (!isLogin && Platform.isAndroid)
                OutlinedButton(
                  child: const Text('Express Log In'),
                  onPressed: () => _onPressedExpressLogInButton(context),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, FacebookUserProfile profile,
      FacebookAccessToken accessToken, String? email) {
    final avatarUrl = _imageUrl;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (avatarUrl != null)
          Center(
            child: Image.network(avatarUrl),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text('User: '),
            Text(
              '${profile.firstName} ${profile.lastName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Text('AccessToken: '),
        Text(
          accessToken.token,
          softWrap: true,
        ),
        if (email != null) Text('Email: $email'),
      ],
    );
  }

  Future<void> _onPressedLogInButton() async {
    await widget.plugin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    await _updateLoginInfo();
  }

  Future<void> _onPressedExpressLogInButton(BuildContext context) async {
    final res = await widget.plugin.expressLogin();
    if (res.status == FacebookLoginStatus.success) {
      await _updateLoginInfo();
    } else {
      await showDialog<Object>(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text("Can't make express log in. Try regular log in."),
        ),
      );
    }
  }

  Future<void> _onPressedLogOutButton() async {
    await widget.plugin.logOut();
    await _updateLoginInfo();
  }

  Future<void> _getSdkVersion() async {
    final sdkVersion = await widget.plugin.sdkVersion;
    setState(() {
      _sdkVersion = sdkVersion;
    });
  }

  Future<void> _updateLoginInfo() async {
    final plugin = widget.plugin;
    final token = await plugin.accessToken;
    FacebookUserProfile? profile;
    String? email;
    String? imageUrl;

    if (token != null) {
      profile = await plugin.getUserProfile();
      if (token.permissions.contains(FacebookPermission.email.name)) {
        email = await plugin.getUserEmail();
      }
      imageUrl = await plugin.getProfileImageUrl(width: 100);
    }

    setState(() {
      _token = token;
      _profile = profile;
      _email = email;
      _imageUrl = imageUrl;
    });
  }
}