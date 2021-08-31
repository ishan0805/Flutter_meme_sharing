import 'package:crio_meme_sharing_app/bloc/meme_bloc.dart';
import 'package:crio_meme_sharing_app/models/meme.dart';
import 'package:crio_meme_sharing_app/utilies/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateMeme extends StatefulWidget {
  CreateMeme({Key key}) : super(key: key);

  @override
  _CreateMemeState createState() => _CreateMemeState();
}

class _CreateMemeState extends State<CreateMeme> {
  final _formkey = GlobalKey<FormState>();

  MemeBloc _memeBloc;
  String name, url, description;

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    _memeBloc = Provider.of<MemeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Meme'),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: deviceSize.width / 2.5,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            ' Create Meme',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Spacer(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Form(
                              key: _formkey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  TextFormField(
                                    key: ValueKey('name'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'everyone has a name ';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      name = value;
                                    },
                                    decoration: InputDecoration(
                                      icon:
                                          Icon(Icons.perm_contact_cal_outlined),
                                      labelText: 'What we call you ?',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    key: ValueKey('url'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'url is required';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      url = value;
                                    },
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.link),
                                      labelText: 'url to awesomeness',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    keyboardType: TextInputType.url,
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    key: ValueKey('caption'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Don\'t be shy speak up";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      description = value;
                                    },
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.message),
                                      labelText: 'what is all this about ?',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: deviceSize.width / 4,
              height: deviceSize.height / 15,
              child: ElevatedButton(
                // RoundedRectangleBorder(
                //    borderRadius: BorderRadius.circular(15),
                //  ),
                style: TextButton.styleFrom(primary: Colors.teal),
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    _formkey.currentState.save();
                    //print("here");
                    //print(description);
                    Memes meme =
                        Memes(url: url, name: name, description: description);

                    bool isTrue = await _memeBloc.postMeme(meme);
                    if (isTrue) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Meme Posted'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Some Error Occured'),
                        ),
                      );
                    }
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
