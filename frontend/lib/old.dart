// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'I Need Help',
    home: LaunchPage(),
  ));
}

class LaunchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I Need Help',
      home: Scaffold(
        appBar: AppBar(
          title: Text('I Neep Help'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PrimaryRequest()),
                  );
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                      'Request',
                      style: TextStyle(fontSize: 20)
                  ),
                ),
              ),
              const SizedBox(height: 30),
              RaisedButton(
                onPressed: () {},
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                      'Send',
                      style: TextStyle(fontSize: 20)
                  ),
                ),
              ),
              const SizedBox(height: 30),
              RaisedButton(
                onPressed: () {},
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                      'Profile',
                      style: TextStyle(fontSize: 20)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrimaryRequest extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Request Page',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Requests'),
        ),
        body: ListView(
      children: ListTile.divideTiles(
      context: context,
        tiles: [
          Container(
      color: Colors.grey[200],
        child: ListTile(
              title: Center(
                child: Text('Go Back', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              onTap: (){
                Navigator.pop(context);
              }
          )
      ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text('Severity of Situation', textScaleFactor: 1.1, textAlign: TextAlign.center,),
              ),
              ListTile(
                title: Text('High'),
              ),
              ListTile(
                title: Text('Medium'),
              ),
              ListTile(
                title: Text('Low'),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text('Items', textScaleFactor: 1.1, textAlign: TextAlign.center,),
              ),
              ListTile(
                title: Text('Food/water'),
              ),
              ListTile(
                title: Text('Clothing'),
              ),
              ListTile(
                title: Text('Shelter'),
              ),
              ListTile(
                title: Text('Toiletries'),
              ),
              Container(
                  color: Colors.grey[200],
                  child: ListTile(
                      title: Center(
                        child: Text('Next', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RequestDetails()),
                      );
                    },
                  )
              ),
            ],
          )
        ],
      ).toList(),
    )

      ),
    );

  }
}

class RequestDetails extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Request Details Page',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Details'),
          ),
          body: ListView(
            children: ListTile.divideTiles(
              context: context,
              tiles: [
                Container(
                    color: Colors.grey[200],
                    child: ListTile(
                        title: Center(
                          child: Text('Go Back', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        onTap: (){
                          Navigator.pop(context);
                        }
                    )
                ),
                Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('Severity of Situation', textScaleFactor: 1.1, textAlign: TextAlign.center,),
                    ),
                    ListTile(
                      title: Text('High'),
                    ),
                    ListTile(
                      title: Text('Medium'),
                    ),
                    ListTile(
                      title: Text('Low'),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('Items', textScaleFactor: 1.1, textAlign: TextAlign.center,),
                    ),
                    ListTile(
                      title: Text('Food/water'),
                    ),
                    ListTile(
                      title: Text('Clothing'),
                    ),
                    ListTile(
                      title: Text('Shelter'),
                    ),
                    ListTile(
                      title: Text('Toiletries'),
                    ),
                    Container(
                        color: Colors.grey[200],
                        child: ListTile(
                            title: Center(
                              child: Text('Next', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            onTap: (){
                              Navigator.pop(context);
                            }
                        )
                    ),
                  ],
                )
              ],
            ).toList(),
          )

      ),
    );

  }
}


