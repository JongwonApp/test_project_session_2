import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project_session_2/viewmodel/login_model.dart';
import 'package:test_project_session_2/style.dart' as style;

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginModel = Provider.of<LoginModel>(context);
    TextEditingController _uidController = TextEditingController();
    TextEditingController _pwdController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 80),
        child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/app_icon.png', height: 190, fit: BoxFit.contain),
          TextField(
            controller: _uidController,
            decoration: InputDecoration(hintText: '아이디를 입력하세요.', errorText: loginModel.loginFail ? "아이디 또는 비밀번호를 다시 확인해주세요" : null),
          ),
          TextField(
            controller: _pwdController,
            decoration: InputDecoration(hintText: '패스워드를 입력하세요.'),
          ),
          SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  loginModel.loginAction(_uidController.text, _pwdController.text);
                  if(!loginModel.loginFail) {
                    Navigator.pushNamed(context, '/');
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: style.primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(15)
                ),
                child: Text('로그인')
            ),
          )
        ])),
      ),
    );
  }
}
