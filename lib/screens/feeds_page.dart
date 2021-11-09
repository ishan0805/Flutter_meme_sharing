import 'package:crio_meme_sharing_app/bloc/meme_bloc.dart';
import 'package:crio_meme_sharing_app/core/failures.dart';
import 'package:crio_meme_sharing_app/core/providers.dart';
import 'package:crio_meme_sharing_app/models/meme.dart';
import 'package:crio_meme_sharing_app/screens/create_meme.dart';
import 'package:crio_meme_sharing_app/utilies/size_config.dart';
import 'package:flutter/cupertino.dart';
//import 'package:crio_meme_sharing_app/utilies/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: implementation_imports
import 'package:flutter_riverpod/src/provider.dart';
import 'package:hive/hive.dart';
// ignore: avoid_web_libraries_in_flutter
//import 'dart:html' as html;

//import 'dart:js' as js;
// ignore: import_of_legacy_library_into_null_safe
//import 'package:shimmer/shimmer.dart';

class FeedsPage extends StatefulWidget {
  final String? title;

  FeedsPage({Key? key, this.title}) : super(key: key);

  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  ScrollController _scrollController = ScrollController();
  final _formkey = GlobalKey<FormState>();
  late MemeBloc _memeBloc;
  int grids = 3;
  bool liked = false;
  @override
  void dispose() {
    super.dispose();
    _memeBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    _memeBloc = context.read(memeBlocProvider);
    Future.delayed(Duration(milliseconds: 100), () {
      _memeBloc.getMemes();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      extendBody: false,
      drawer: Drawer(
          child: ListView(
        children: [
          ListTile(
            title: Text('Post Meme'),
            leading: Icon(Icons.add_box),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CreateMeme();
              }));

              // _showMyDialog();
            },
          ),
          ListTile(
            leading: Icon(Icons.file_copy_rounded),
            title: Text('See Documents For Api'),
            onTap: () {
              /* js.context.callMethod('open', [
                'https://memesharing.herokuapp.com/swagger-ui/#/default/get_memes_get'
              ]);*/
              htmlOpenLink(
                  'https://memesharing.herokuapp.com/swagger-ui/#/default/get_memes_get');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_run_outlined),
            title: Text('Contact Me'),
            onTap: () {
              /* js.context.callMethod(
                  'open', ['https://www.linkedin.com/in/ishan0805/']);*/
              htmlOpenLink('https://www.linkedin.com/in/ishan0805/');
              Navigator.pop(context);
            },
          ),
        ],
      )),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('Meme Sharing'),
        actions: SizeConfig.screenWidth > 800
            ? [
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CreateMeme();
                      }));
                    },
                    child: Text('Post Meme')),
                SizedBox(
                  width: 25,
                ),
                TextButton(
                    onPressed: () {
                      htmlOpenLink(
                          'https://memesharing.herokuapp.com/swagger-ui/#/default/get_memes_get');
                    },
                    child: Text('See Documents For Api')),
                SizedBox(
                  width: 25,
                ),
                TextButton(
                    onPressed: () {
                      htmlOpenLink('https://www.linkedin.com/in/ishan0805/');
                    },
                    child: Text('Contact Us')),
                SizedBox(
                  width: 25,
                ),
                TextButton(
                    onPressed: () {
                      context.read(authBlocProvider).logout();
                      Navigator.pop(context);
                    },
                    child: Text('Logout')),
                SizedBox(
                  width: 55,
                ),
              ]
            : [],
      ),
      body: StreamBuilder<List<Memes>>(
          stream: _memeBloc.memes,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data!.length == 0) {
              return Center(child: Text("No Meme To Show"));
            }

            return Center(
              child: SizedBox(
                width: SizeConfig.screenWidth / 3,
                child: ListView.builder(
                  //controller: _scrollController,
                  // physics: NeverScrollableScrollPhysics(),
                  // primary: true,
                  //shrinkWrap: true,
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 1, childAspectRatio: 1.1),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                    child: _buildCards(snapshot.data ?? [], index),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildCards(List<Memes> snapshot, int index) {
    return SizedBox(
      width: SizeConfig.screenWidth / 2,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 4,
              child: Padding(
                padding:
                    EdgeInsets.fromLTRB(5, 5, 5, SizeConfig.blockSizeVertical),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/NoDp.jpg"),
                  ),
                  title: Text(
                    ' ${snapshot[index].ownerName}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.teal),
                  ),
                  trailing: snapshot[index].ownerEmail ==
                          Hive.box('user').get('email')
                      ? PopupMenuButton<String>(
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                value: "edit",
                                child: Text('Edit'),
                              ),
                              PopupMenuItem<String>(
                                value: "delete",
                                child: Text('Delete'),
                              )
                            ];
                          },
                          onSelected: (value) {
                            if (value == 'edit') {
                              _showEditDialog(snapshot[index].id ?? 0);
                            } else {
                              _showDeleteDialog(snapshot[index].id ?? 0);
                            }
                          },
                        )
                      : SizedBox(),
                ),
              ),
            ),
            /*Container(
              height: 2,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(),
                ),
              ),
            ),*/
            //Image View
            Flexible(
              flex: 15,
              child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 1, minHeight: 1),
                      child: _getImage(snapshot[index].url ?? ""))),
            ),
            /* IconButton(
              onPressed: () {
                setState(() {
                  liked = liked ^ true;
                });
              },
              icon: Icon(
                CupertinoIcons.heart_circle,
                color: liked ? Colors.red : Colors.white,
              ),
            ),*/
            Flexible(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Text(
                        "${snapshot[index].ownerName} : ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                    ),
                    Flexible(
                      //fit: BoxFit.fill,
                      child: Text(
                        '${snapshot[index].caption}',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'HandWriting',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Image _getImage(String url) {
    CircularProgressIndicator();
    return Image(
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      image: NetworkImage(url),
      fit: BoxFit.cover,
      errorBuilder:
          ((BuildContext context, Object exception, StackTrace? stackTrace) {
        return Image(
          image: AssetImage('assets/page_not_found.png'),
        );
      }),
    );
    /*var image;
    try {
      image = NetworkImage(url);
    } catch (e) {
      image = AssetImage('assets/page_not_found.png');
    }
    if (image == null) {
      image = AssetImage('assets/page_not_found.png');
    }
    return image;*/
  }

  // LoadView till the data is not fetched show this
  /*_buildLoadingView() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: GridView.count(
        padding: EdgeInsets.all(0),
        // padding: EdgeInsets.symmetric(
        //     horizontal: SizeConfig.safeBlockHorizontal),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,

        crossAxisCount: 3,
        childAspectRatio: 1.2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: List.generate(
          100,
          (int index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }*/

//Function to Show the Dialog box for Editing the meme
  Future<void> _showEditDialog(int id) async {
    String? new_description, new_url;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit this  Meme',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'url is required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      new_url = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'edit url',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    keyboardType: TextInputType.url,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return "Don\'t be shy speak up";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      new_description = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Change description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                if (_formkey.currentState!.validate()) {
                  _formkey.currentState!.save();

                  final response = (await _memeBloc.editMeme(Memes(
                          id: id, url: new_url, caption: new_description)))
                      .fold((l) => l, (r) => r);

                  showError(response, context);

                  Navigator.of(context).pop();
                }
              },
              child: Text('Do It !!'),
            ),
            TextButton(
              child: Text('Not Interested Anymore'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showError(Object response, BuildContext context) {
    if (response is Failures) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Success"),
        ),
      );
    }
  }

  void htmlOpenLink(String url) {
    // html.window.open(url, '_blank');
  }

  Future<void> _showDeleteDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          height: SizeConfig.screenHeight / 2,
          width: SizeConfig.screenWidth / 3,
          child: AlertDialog(
            title: Text(
              'Delete this  Meme',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  bool isTrue = await _memeBloc.deleteMeme(id);
                  if (isTrue) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Meme Deleted'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Some Error Occured'),
                      ),
                    );
                  }
                  Navigator.of(context).pop();
                },
                child: Text('Do It !!'),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Not Interested Anymore'),
              ),
            ],
          ),
        );
      },
    );
  }
}
