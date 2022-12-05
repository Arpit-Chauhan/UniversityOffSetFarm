import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:univoffst/models/getApiData.dart';
import 'package:univoffst/screens/university.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GetApiData>? apiList;

  @override
  void initState() {
    // TODO: implement initState
    getapiData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios,
            ),
          ),
          title: Text('List of Universities'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: apiList != null
            ? ListView.builder(
                itemCount: apiList!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Univ(apiList,index)));
                        },
                        child: Card(
                          elevation: 5,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Text(
                                  '${apiList![index].name}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${apiList![index].stateProvince}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                })
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                    Text('Fetching Data'),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> getapiData() async {
    String url = "http://universities.hipolabs.com/search?country=India";
    var result = await http.get(Uri.parse(url));
    setState(() {
      apiList = jsonDecode(result.body)
          .map((item) => GetApiData.fromJson(item))
          .toList()
          .cast<GetApiData>();
    });
  }
}
