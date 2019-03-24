import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import './views/video-cell.dart';

void main() => runApp(new testProject());

class testProject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new testProjectState();
  }
}

class testProjectState extends State<testProject> {
  var _isLoading = true;
  var videos;

  _fetchData() async {
    print("Fetching data");

    final url = "https://api.letsbuildthatapp.com/youtube/home_feed";
    final response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      setState(() {
        _isLoading = false;
        this.videos = map["videos"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          title: new Text("Real Life APP"),
          backgroundColor: Color(0xFF151026),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {
                print("Reloading");
                setState(() {
                  _isLoading = true;
                });
                _fetchData();
              },
            )
          ],
        ),
        body: new Center(
            child: _isLoading ? new CircularProgressIndicator() :
             new ListView.builder(
                    itemCount: this.videos != null ? this.videos.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      final video = this.videos[index];
                      return new FlatButton(
                        onPressed: (){
                          print("video cell tapped $index");
                          Navigator.push(context, 
                          new MaterialPageRoute(
                            builder: (context) => new DetailPage()
                          ));
                        },
                        child: new VideoCell(video),
                      );
                      
                    },
                  )),
      ),
    );
  }
}

class DetailPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Detail Page"),
      ),
      body: new Center(
        child: new Text("detail detail detail"),
      ) ,
    );
    return null;
  }
}
