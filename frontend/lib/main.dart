import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

String currentEmail;
List<NewRequest> allRequests = [];

void main() {
  runApp(MaterialApp(
    title: 'I Need Help',
    home: LoginPage(),
  ));
}

class RegisterPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Registration Page',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Register'),
          ),
          body: MyCustomFormRegister(),
        )
    );
  }
}
class MyCustomFormRegister extends StatefulWidget {
  @override
  MyCustomFormStateRegister createState() {
    return MyCustomFormStateRegister();
  }
}
class MyCustomFormStateRegister extends State<MyCustomFormRegister> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthdateController = TextEditingController();
  final genderController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    final controllers = [
      emailController,
      passwordController,
      firstNameController,
      lastNameController,
      birthdateController,
      genderController
    ];
    for (final controller in controllers){
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child:
      ListView(
        children: <Widget>[
          Text('Email', textAlign: TextAlign.center, textScaleFactor: 2),
          TextFormField(
            controller: emailController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter  some text';
              }
              return null;
            },
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0)
          ),
          Text('Password', textAlign: TextAlign.center, textScaleFactor: 2,),
          TextFormField(
            obscureText: true,
            controller: passwordController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Text('First Name', textAlign: TextAlign.center, textScaleFactor: 2,),
          TextFormField(
            controller: firstNameController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter first name';
              }
              return null;
            },
          ),
          Text('Last Name', textAlign: TextAlign.center, textScaleFactor: 2,),
          TextFormField(
            controller: lastNameController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter last name';
              }
              return null;
            },
          ),
          Text('Birthdate', textAlign: TextAlign.center, textScaleFactor: 2,),
          TextFormField(
            controller: firstNameController,
            validator: (value) {
              if (value.isEmpty) {
                return 'MM-DD-YYYY';
              }
              return null;
            },
          ),
          Text('Gender', textAlign: TextAlign.center, textScaleFactor: 2,),
          TextFormField(
            controller: firstNameController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Male_Female';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  _makePostRequest() async {
                    // set up POST request arguments
                    String url = 'https://hackpsu-fall2019.herokuapp.com/rest-auth/login/';
                    Map<String, String> headers = {"Content-type": "application/json"};
                    String email = emailController.text;
                    String password = passwordController.text;
                    String firstName = firstNameController.text;
                    String lastName = lastNameController.text;
                    String birthdate = birthdateController.text;
                    String gender = genderController.text;
                    print(email);
                    print(password);
                    String json = '{"email": "$email","password": "$password", "firstName" : "$firstName","lastName" : "$lastName","birthdate" : "$birthdate","gender" : "$gender"}';
                    Response response = await post(url, headers: headers, body: json);
                    int statusCode = response.statusCode;
                    String body = response.body;
                    print(body);
                    print(statusCode);
                    if (statusCode == 400)
                    {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Unsuccessful')));
                    }
                    else
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                  }
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                  _makePostRequest();
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Login Page',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Login'),
          ),
          body: MyCustomForm(),
        )
    );
  }
}
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Text('Email', textAlign: TextAlign.center, textScaleFactor: 2),
          TextFormField(
            controller: emailController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter  some text';
              }
              return null;
            },
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0)
          ),
          Text('Password', textAlign: TextAlign.center, textScaleFactor: 2,),
          TextFormField(
            obscureText: true,
            controller: passwordController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  _makePostRequest() async {
                    // set up POST request arguments
                    String url = 'https://hackpsu-fall2019.herokuapp.com/rest-auth/login/';
                    Map<String, String> headers = {"Content-type": "application/json"};
                    String email = emailController.text;
                    String password = passwordController.text;
                    currentEmail = email;
                    print(email);
                    print(password);
                    String json = '{"email": "$email", "password": "$password"}';
                    Response response = await post(url, headers: headers, body: json);
                    int statusCode = response.statusCode;
                    String body = response.body;
                    print(body);
                    print(statusCode);
                    if (statusCode == 400)
                    {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Unsuccessful')));
                    }
                    else
                    {

                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LaunchPage()));
                    }
                  }
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                  _makePostRequest();
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

class LaunchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Give and Get Help',
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                child: Image(
                  image: NetworkImage('https://raw.githubusercontent.com/askvortsov1/HackPSU2019F/master/frontend/lib/I%20Help.png'),
                ),
          padding: const EdgeInsets.symmetric(vertical: 16.0)
              ),
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
                      'Get Help',
                      style: TextStyle(fontSize: 20)
                  ),
                ),
              ),
              const SizedBox(height: 30),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SendPage()));
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
                      'Give Help',
                      style: TextStyle(fontSize: 20)
                  ),
                ),
              ),
              const SizedBox(height: 30),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
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
        title: 'Primary Request',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Get Help'),
          ),
          body: MyCustomFormPrimaryRequest(),
        )
    );
  }
}
class MyCustomFormPrimaryRequest extends StatefulWidget {
  @override
  MyCustomFormStatePrimaryRequest createState() {
    return MyCustomFormStatePrimaryRequest();
  }
}
class MyCustomFormStatePrimaryRequest extends State<MyCustomFormPrimaryRequest> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final severityController = TextEditingController();
  final itemController = TextEditingController();
  final severityDetailController = TextEditingController();
  final itemDetailController = TextEditingController();



  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    severityController.dispose();
    itemController.dispose();
    severityDetailController.dispose();
    itemDetailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Padding(
              child: Text('Level of Severity (1-10)', textAlign: TextAlign.center, textScaleFactor: 2),
              padding: const EdgeInsets.symmetric(vertical: 16.0)
          ),
          TextFormField(
            controller: severityController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter  some text';
              }
              return null;
            },
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0)
          ),
          Text('Reason for Severity', textAlign: TextAlign.center, textScaleFactor: 2),
          TextFormField(
            controller: severityDetailController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter  some text';
              }
              return null;
            },
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0)
          ),
          Text('Item', textAlign: TextAlign.center, textScaleFactor: 2,),
          TextFormField(
            controller: itemController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Text('Item Details', textAlign: TextAlign.center, textScaleFactor: 2,),
          TextFormField(
            controller: itemDetailController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  _makePostRequest() async {
                    // set up POST request arguments
                    String url = 'https://hackpsu-fall2019.herokuapp.com/rest-auth/login/';
                    Map<String, String> headers = {"Content-type": "application/json"};
                    String severity = severityController.text;
                    String item = itemController.text;
                    String severityDetail = severityDetailController.text;
                    String itemDetail = itemDetailController.text;
                    String json = '{"severity" : "$severity", "item" : "$item", "severityDetail" : "$severityDetail", "itemDetail" : "$itemDetail"}';
                    Response response = await post(url, headers: headers, body: json);
                    int statusCode = response.statusCode;
                    String body = response.body;
                    allRequests.add(NewRequest(severity, item, severityDetail, itemDetail, currentEmail));
                    print(allRequests);
                    print(body);
                    print(statusCode);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LaunchPage()));
                  }
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                  _makePostRequest();
                }
              },
              child: Text('Submit'),
            ),
          ),
        ]
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Current Requests"),
              ),
              Card(
                child: InkWell(
                  onTap:(){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyInfo()));
                  },
                  child: ListTile(
                    title: Text('Severity 9'),
                    subtitle: Text('Item: Shelter'),
                    trailing: Icon(Icons.more_vert),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Severity 4'),
                  subtitle: Text('Item: Clothing'),
                  trailing: Icon(Icons.more_vert),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Severity 3'),
                  subtitle: Text('Item: Clothing'),
                  trailing: Icon(Icons.more_vert),
                ),
              ),
            ]
        ),
      ),
    );
  }
}

class SendPage extends StatelessWidget {

  final List<NewRequest> currentRequests = allRequests;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Send Help',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Nearby Help Requests'),
            ),
            body: ListView(
                children: <Widget>[
                  Card(
                    child: InkWell(
                      onTap:(){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RequestInfo()));
                      },
                      child: ListTile(
                      title: Text('Severity 9'),
                      subtitle: Text('Item: Shelter'),
                      trailing: Text('7.0 mi'),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Severity 7'),
                      subtitle: Text('Item: Food'),
                      trailing: Text('13.4 mi'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Severity 4'),
                      subtitle: Text('Item: Water'),
                      trailing: Text('14.1 mi'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Severity 2'),
                      subtitle: Text('Item: Clothing'),
                      trailing: Text('18.6 mi'),
                    ),
                  ),
                  Container(
                      color: Colors.grey[200],
                      child: ListTile(
                          title: Center(
                            child: Text('Finish', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          onTap: (){
                            null;
                          }
                      )
                  ),
          ]
            ),
    ),
    );
  }
}

class NewRequest{
  String severity, item, severityDetail, itemDetail, userEmail;
  NewRequest(String severity, item, severityDetail, itemDetail, userEmail){
    this.severity = severity;
    this.item = item;
    this.severityDetail = severity;
    this.itemDetail = itemDetail;
    this.userEmail = userEmail;
  }
}

class RequestInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Request Info',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Help Request Info'),
          ),
          body: ListView(
            children: <Widget>[
              ListTile(
                  title: Text("Severity: 9"),
                  subtitle: Text("\nREASON:\nHouse was destroyed in tornado, no place for family to live.\n"),
              ),
              ListTile(
                  title: Text("Item: Shelter"),
                  subtitle: Text("\nDETAILS:\nRoom for family of 4. Heating."),
              ),
              ListTile(
                title: Text("7.0 miles away"),
              ),
              SizedBox(height: 100),
              ButtonTheme.bar(
                child: new ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
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
                            'Back',
                            style: TextStyle(fontSize: 20)
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SendPage()));
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
                            'Add',
                            style: TextStyle(fontSize: 20)
                        ),
                      ),
                    ),
                  ],
                ),
              ),


            ],
          )
      ),
    );
  }
}

class MyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Request Info',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Help Request Info'),
          ),
          body: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Severity: 9"),
                subtitle: Text("\nREASON:\nHouse was destroyed in tornado, no place for family to live.\n"),
              ),
              ListTile(
                title: Text("Item: Shelter"),
                subtitle: Text("\nDETAILS:\nRoom for family of 4. Heating."),
              ),
              SizedBox(height: 100),
            ],
          )
      ),
    );
  }
}

