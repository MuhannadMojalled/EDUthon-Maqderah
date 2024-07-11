import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class LessonsPage extends StatefulWidget {
  final String clo;

  const LessonsPage({required this.clo});

  @override
  _LessonsPageState createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  String advice = "";
  List<String> videos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAdvice();
  }

  Future<void> fetchAdvice() async {
    try {
      print(widget.clo);
      String clo = (widget.clo);
      print(clo + "2");
      print('http://10.185.246.128:5000/get-advice?clo=' + clo);
      String urlt = ('http://10.185.246.128:5000/get-advice?clo=' + clo);
      print("div");
      print({Uri.encodeComponent(widget.clo)});
      var url = Uri.parse(urlt);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          advice = data['advice'];
          videos = List<String>.from(data['videos']['links']);
          isLoading = false; // Mark loading as complete
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        setState(() {
          isLoading = false; // Mark loading as complete even if request fails
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false; // Mark loading as complete on error
      });
    }
  }

  Future<void> _launchURL(String url) async {
    print('Launching $url');
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  Widget VideoCard({required String video}) {
    return GestureDetector(
      onTap: () => _launchURL(video),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.network(returnThumbnail(video)),
            ),
            Text(
              video,
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  String returnThumbnail(String videoUrl) {
    // You can add logic here to return the thumbnail URL of the video
    return 'https://img.youtube.com/vi/${videoUrl.split("v=")[1]}/0.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF2D514B),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Home Page',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          )
        ],
        title: Text(
          'Lessons Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CLO: ${Uri.decodeComponent(widget.clo)}'),
                    SizedBox(height: 20),
                    Text('$advice'),
                    SizedBox(height: 20),
                    for (var video in videos) VideoCard(video: video),
                  ],
                ),
              ),
            ),
    );
  }
}
