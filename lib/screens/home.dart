import 'package:crio_meme_sharing_app/bloc/meme_bloc.dart';
import 'package:crio_meme_sharing_app/models/meme.dart';
import 'package:crio_meme_sharing_app/screens/create_meme.dart';
//import 'package:crio_meme_sharing_app/utilies/size_config.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController = ScrollController();
  final _formkey = GlobalKey<FormState>();
  MemeBloc _memeBloc;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _memeBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      _memeBloc.getMemes();
    });

    // print('here');
  }

  @override
  Widget build(BuildContext context) {
    _memeBloc = Provider.of<MemeBloc>(context);
    return Scaffold(
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
              js.context.callMethod('open', [
                'https://memesharing.herokuapp.com/swagger-ui/#/default/get_memes_get'
              ]);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_run_outlined),
            title: Text('Contact Me'),
            onTap: () {
              js.context.callMethod(
                  'open', ['https://www.linkedin.com/in/ishan0805/']);
              Navigator.pop(context);
            },
          )
        ],
      )),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('MEME SHARING'),
      ),
      body: StreamBuilder<List<Memes>>(
          stream: _memeBloc.memes,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
              return Center(child: CircularProgressIndicator());
              //_buildLoadingView();
            }
            return Scrollbar(
              thickness: 10.0,
              radius: Radius.circular(10),
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.count(
                  crossAxisCount: 3,
                  controller: _scrollController,
                  children: _buildCards(snapshot.data),
                ),
              ),
            );
          }),
    );
  }

  List<Card> _buildCards(List<Memes> memes) {
    List<Card> cards = [];
    for (var meme in memes) {
      cards.add(Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              '  by ${meme.name}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.teal),
                            ),
                          ),
                          Spacer(),
                          PopupMenuButton<String>(
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
                                _showEditDialog(meme.id);
                              } else {
                                _showDeleteDialog(meme.id);
                              }
                            },
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  flex: 10,
                  child: Center(
                    child: Image(
                        image: _getImage(meme.url),
                        //  'https://miro.medium.com/max/405/1*J9_05FyiiDk2y2hhbOwNlg.png'),
                        //   AssetImage('assets/page_not_found.png'),
                        fit: BoxFit.fitWidth),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          "Caption :",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          '${meme.description}',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'HandWriting',
                              fontWeight: FontWeight.w600,
                              color: Colors.tealAccent),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )));
    }
    return cards;
  }

  ImageProvider _getImage(String url) {
    var image;
    try {
      image = NetworkImage(url);
    } catch (e) {
      image = AssetImage('assets/page_not_found.png');
    }
    if (image == null) {
      image = AssetImage('assets/page_not_found.png');
    }
    return image;
  }

  _buildLoadingView() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: GridView.count(
        padding: EdgeInsets.all(0),
        // padding: EdgeInsets.symmetric(
        //     horizontal: SizeConfig.safeBlockHorizontal),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
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
  }

  Future<void> _showEditDialog(int id) async {
    String new_description, new_url;
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
                      if (value.isEmpty) {
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
                      if (value.isEmpty) {
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
                if (_formkey.currentState.validate()) {
                  _formkey.currentState.save();

                  bool isTrue = await _memeBloc.editMeme(Memes(
                      id: id, url: new_url, description: new_description));

                  if (isTrue) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Meme Edited'),
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

  Future<void> _showDeleteDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
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
            )
          ],
        );
      },
    );
  }
}
