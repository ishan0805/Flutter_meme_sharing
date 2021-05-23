import 'package:crio_meme_sharing_app/utilies/size_config.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formkey = GlobalKey<FormState>();
  var size = SizeConfig();
  bool isOnSignIn = false;
  TextEditingController passwordSignUp = TextEditingController();
  TextEditingController passwordConfirmSignUp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    size.init(context); //Initializing size of page

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(SizeConfig.inputSpacing / 1.9),
        child: Row(
          children: [
            SizeConfig.screenWidth > 800 ? sideView() : Container(),
            isOnSignIn ? SignIn() : SignUp()
          ],
        ),
      ),
    );
  }

  Expanded SignUp() {
    return Expanded(
      flex: 2,
      child: Container(
        child: Card(
          color: Color(0xFF303031),
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                Text(
                  "Enter your details",
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 7,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical,
                      ),
                      // enter password
                      TextFormField(
                        controller: passwordSignUp,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter a Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical,
                      ),
                      // confirm password
                      TextFormField(
                        controller: passwordConfirmSignUp,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter the above password';
                          }
                          if (passwordSignUp != passwordConfirmSignUp) {
                            return 'Passwords do not matched';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 6,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      SizeConfig.safeBlockHorizontal, 0, 10, 0),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF34b996),
                      ),
                      child: Text("Sign Up"),
                    ),
                  ),
                ),
                // for mobile view logic SignUp
                SizeConfig.screenWidth > 800
                    ? Container()
                    : Center(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if (isOnSignIn == true) {
                                isOnSignIn = false;
                              } else {
                                isOnSignIn = true;
                              }
                            });
                          },
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.safeBlockHorizontal,
                                  top: SizeConfig.safeBlockVertical),
                              child: switchBetweenSignInSignUp()),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // SignIn Widget
  Expanded SignIn() {
    return Expanded(
      flex: 2,
      child: Container(
        child: Card(
          color: Color(0xFF303031),
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign In ",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                Text(
                  "Enter your details",
                  //style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 7,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        keyboardType: TextInputType.url,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Checkbox(value: false, onChanged: (v) {}),
                        Text('Remember Me'),
                      ],
                    ),
                    // logiv for mobile view
                    TextButton(
                        onPressed: () {
                          if (isOnSignIn == true) {
                            isOnSignIn = false;
                          } else {
                            isOnSignIn = true;
                          }
                        },
                        child: switchBetweenSignInSignUp()),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 6,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      SizeConfig.safeBlockHorizontal, 0, 10, 0),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF34b996),
                      ),
                      child: Text("Login"),
                    ),
                  ),
                ),
                SizeConfig.screenWidth > 800
                    ? Container()
                    : Center(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if (isOnSignIn == true) {
                                isOnSignIn = false;
                              } else {
                                isOnSignIn = true;
                              }
                            });
                          },
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.safeBlockHorizontal,
                                  top: SizeConfig.safeBlockVertical),
                              child: switchBetweenSignInSignUp()),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text switchBetweenSignInSignUp() {
    if (isOnSignIn == true) {
      return Text(
        "dont't have a account ?",
        style: TextStyle(
            color: Colors.white, decoration: TextDecoration.underline),
      );
    } else {
      return Text(
        "Already have a account ?SignIn",
        style: TextStyle(
            color: Colors.white, decoration: TextDecoration.underline),
      );
    }
  }

  Expanded sideView() {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color(0xFF22909f),
              Color(0xFF24949d),
              Color(0xFF279a9d),
              Color(0xFF289e9b),
              Color(0xFF2ba399),
              Color(0xFF2da999),
              Color(0xFF30af99),
              Color(0xFF34b996),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal),
              child: Text(
                "</> MemeShare",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 9,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
              child: Text(
                "Laught .",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
              child: Text(
                "Share .",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
              child: Text(
                "Support .",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            /* Padding(
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 7),
              child: Text(
                "Spreading happiness one meme at a time !!",
                style: TextStyle(fontSize: 20),
              ),
            ),*/
            SizedBox(
              height: SizeConfig.blockSizeVertical * 8,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (isOnSignIn == true) {
                    isOnSignIn = false;
                  } else {
                    isOnSignIn = true;
                  }
                });
              },
              child: Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: switchBetweenSignInSignUp()),
            ),
          ],
        ),
      ),
    );
  }
}
