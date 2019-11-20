import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PHOTOFILE',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'PHOTOFILE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File photo;
  File profileImage;
  File imgGrid1;
  List<File> pickedImgs = [];
  List<PopupMenuEntry> popMenuList = [
    PopupMenuItem(
      child: Text('iniciar sesion'),
    ),
    PopupMenuItem(
      child: Text('registrarse'),
    ),
  ];

  Future getImage1() async {
    var image2 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      photo = image2;
    });
  }

  Future getImage2() async {
    var image2 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      profileImage = image2;
    });
  }

  Future getImage3() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImgs.add(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return popMenuList;
            },
          )
        ],
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: MaterialButton(
                onPressed: () => getImage2(),
                child: Text('Cambiar imagen de usuario'),
              ),
            ),
            ListTile(
              leading: Text('Usuario: '),
              title: Text(''),
              trailing: CircleAvatar(
                backgroundImage:
                profileImage != null ? FileImage(profileImage) : null,
              ),
            ),
          ],
        ),
      ),
      body: pickedImgs.length == 0 ? Center (child: Text('No hay fotos!',style: TextStyle(
        fontSize: 30 ,
      ),),) : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: pickedImgs.length == 0 ? 0 : pickedImgs.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    pickedImgs.removeAt(index);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(pickedImgs[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getImage3(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Colors.white ,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}