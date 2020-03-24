import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practica_dos/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:practica_dos/home/home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isTextHidden = true;
  TextEditingController _usernameController;
  TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text("Un errror")),
          );
        }
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: _loginBody(),
            ),
          ),
        ),
      ),
    );
  }

  Column _loginBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _userTextField(),
        SizedBox(height: 24),
        _passwordTextField(),
        SizedBox(height: 48),
        _loginButton(),
        SizedBox(height: 8),
        _googleButton(),
      ],
    );
  }

  // username
  Widget _userTextField() {
    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff94d500),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff94d500),
          ),
        ),
        errorStyle: TextStyle(
          color: Color(0xff94d500),
        ),
        labelText: "Usuario",
        labelStyle: TextStyle(color: Colors.grey[300]),
      ),
      validator: (contenido) {
        if (contenido.isEmpty) {
          return "Ingrese nombre";
        } else {
          return null;
        }
      },
    );
  }

  // password
  Widget _passwordTextField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _isTextHidden,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff94d500),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff94d500),
          ),
        ),
        errorStyle: TextStyle(
          color: Color(0xff94d500),
        ),
        labelText: "Password",
        labelStyle: TextStyle(color: Colors.grey[300]),
        suffixIcon: IconButton(
          icon: _isTextHidden
              ? Icon(Icons.visibility_off, color: Colors.grey[300])
              : Icon(Icons.visibility, color: Colors.grey[300]),
          onPressed: () {
            setState(() {
              _isTextHidden = !_isTextHidden;
            });
          },
        ),
      ),
      validator: (contenido) {
        if (contenido.isEmpty) {
          return "Ingrese password";
        } else {
          return null;
        }
      },
    );
  }

  // login button
  Widget _loginButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: MaterialButton(
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.envelope,
                  color: Colors.grey[200],
                ),
                Expanded(
                  child: Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[200]),
                  ),
                ),
              ],
            ),
            onPressed: _login,
          ),
        ),
      ],
    );
  }

  // google button
  Widget _googleButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: MaterialButton(
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.google,
                  color: Colors.grey[200],
                ),
                Expanded(
                  child: Text(
                    "Google",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[200]),
                  ),
                ),
              ],
            ),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(LoginWithGoogle());
            },
          ),
        ),
      ],
    );
  }

  _login() {
    if (_formKey.currentState.validate()) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    } else {
      return Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Rellenar formulario ..."),
        ),
      );
    }
  }
}
