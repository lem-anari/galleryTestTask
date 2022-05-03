import 'package:flutter/material.dart';
import 'package:gallery_app/pages/full_image.dart';
import 'package:gallery_app/components/photos.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GalleryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gallery",
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List <dynamic> images = [];
//Map<String, dynamic> images;
  List<Photo> _photos = [];
  Future <List<Photo>> getData() async{
    var response = await http.get(Uri.parse('https://api.unsplash.com/photos/?client_id=ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9'));
    images = json.decode(response.body);
    for(var i=0; i<images.length; i++){
      _photos.add(Photo.fromJson(images[i]));
    }
    return _photos;
  }

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState((){
        _photos.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.red,
        appBar: AppBar(
          backgroundColor: Colors.black,//color
          title: Text("Gallery", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),),

        ),
        // ignore: unrelated_type_equality_checks
        body: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: _photos.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                          onTap: () {
                            //setState(() {});
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => FullImgPage(_photos[i].imgUrlBigSize, _photos[i].imgName)
                            ));
                          },
                          child:
                          Card(
                            elevation: 2.0,
                            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Container(
                              decoration:
                              BoxDecoration(color: Color.fromRGBO(60, 15, 105, 0.35)),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                leading: Container(
                                  padding: EdgeInsets.only(right: 12),
                                  child: Container(
                                    child: Image.network(
                                        _photos[i].imgUrl.toString(),
                                        height: 70,
                                        fit:BoxFit.fill
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right:
                                          BorderSide(width: 1, color: Colors.white24))),
                                ),
                                title: Text(
                                    _photos[i].imgAuthor.toString(),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold)
                                ),
                                trailing: Icon(Icons.keyboard_arrow_right,
                                    color: Colors.lime),
                                subtitle: subtitle(context, _photos[i]),
                              ),
                            ),
                          ));
                    }),
              )])
    );
  }

}

Widget subtitle(BuildContext context, Photo photo) {
  return Row(
    children: <Widget>[
      Expanded(
          flex: 3,
          child: Text(photo.imgName.toString(),
              style: TextStyle(color: Colors.lime)))
    ],
  );
}
