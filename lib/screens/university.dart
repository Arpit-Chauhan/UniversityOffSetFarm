// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:univoffst/models/getApiData.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Univ extends StatefulWidget {
  List<GetApiData>? apiList;
  int index = 0;
  Univ(List<GetApiData>? apiList, int index, {super.key}) {
    this.apiList = apiList;
    this.index = index;
  }

  @override
  State<Univ> createState() => _UnivState();
}

class _UnivState extends State<Univ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 204, 225, 243),
      appBar: AppBar(
        title: Text('University'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 01),
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(30, 176, 176, 228),
              blurRadius: 4,
              offset: Offset(6, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'University Name',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              '${widget.apiList![widget.index].name}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'State',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              '${widget.apiList![widget.index].stateProvince}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Country',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              '${widget.apiList![widget.index].country}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Country Code',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              '${widget.apiList![widget.index].alphaTwoCode}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Domains',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            widget.apiList![widget.index].domains!.length != 0
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.apiList![widget.index].domains!.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Card(
                          margin: EdgeInsets.all(10.0),
                          elevation: 0,
                          child: Text(
                            '${widget.apiList![widget.index].domains![index]}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    })
                : SizedBox(
                    height: 20,
                  ),
            Text(
              'Web Pages',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            widget.apiList![widget.index].webPages!.length != 0
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.apiList![widget.index].webPages!.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: GestureDetector(
                          onTap: () async => await launch(
                              widget.apiList![widget.index].webPages![index],
                              forceSafariVC: false),
                          child: Card(
                            elevation: 0,
                            child: Text(
                              '${widget.apiList![widget.index].webPages![index]}',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                : SizedBox(
                    height: 20,
                  ),
          ],
        ),
      ),
    );
  }
}
