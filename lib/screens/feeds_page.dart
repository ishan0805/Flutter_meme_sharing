import 'package:crio_meme_sharing_app/bloc/meme_bloc.dart';
import 'package:crio_meme_sharing_app/models/meme.dart';
import 'package:crio_meme_sharing_app/screens/create_meme.dart';
import 'package:crio_meme_sharing_app/utilies/size_config.dart';
import 'package:flutter/cupertino.dart';
//import 'package:crio_meme_sharing_app/utilies/size_config.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

//import 'dart:js' as js;
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';

class FeedsPage extends StatefulWidget {
  final String title;

  FeedsPage({Key key, this.title}) : super(key: key);

  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  ScrollController _scrollController = ScrollController();
  final _formkey = GlobalKey<FormState>();
  MemeBloc _memeBloc;
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
    Future.delayed(Duration(milliseconds: 100), () {
      _memeBloc.getMemes();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        child: StreamBuilder<List<Memes>>(
            stream: _memeBloc.memes,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.hasError) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.data.length == 0) {
                return Text("No Meme To Show");
              }

              return ListView.builder(
                //controller: _scrollController,
                //physics: NeverScrollableScrollPhysics(),
                // primary: true,
                shrinkWrap: true,
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 1, childAspectRatio: 1.1),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                  child: _buildCards(snapshot, index),
                ),
              );
            }),
      ),
    );
  }

  Card _buildCards(AsyncSnapshot<List<Memes>> snapshot, int index) {
    return Card(
      /*shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),*/
      elevation: 0,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ' ${snapshot.data[index].name}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.teal),
                ),
                trailing: PopupMenuButton<String>(
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
                      _showEditDialog(snapshot.data[index].id);
                    } else {
                      _showDeleteDialog(snapshot.data[index].id);
                    }
                  },
                ),
              ),
            ),
          ),
          Container(
            height: 2,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(),
              ),
            ),
          ),
          //Image View
          Expanded(
            flex: 15,
            child: _getImage(snapshot.data[index].url),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                liked = liked ^ true;
              });
            },
            icon: Icon(
              CupertinoIcons.heart_circle,
              color: liked ? Colors.red : Colors.white,
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Text(
                      "${snapshot.data[index].name} : ",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal),
                    ),
                  ),
                  Flexible(
                    //fit: BoxFit.fill,
                    child: Text(
                      '${snapshot.data[index].description}',
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
    );
  }

  Image _getImage(String url) {
    return Image(
        image: NetworkImage(url),
        fit: BoxFit.cover,
        errorBuilder:
            ((BuildContext context, Object exception, StackTrace stackTrace) {
          return Image(image: AssetImage('assets/page_not_found.png'));
        }));
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

//Function to Show the Dialog box for Editing the meme
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

  void htmlOpenLink(String url) {
    html.window.open(url, '_blank');
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
