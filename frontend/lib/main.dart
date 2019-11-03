import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(MaterialApp(
    title: 'I Need Help',
    home: LaunchPage(),
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
                return 'Unicorn';
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
        appBar: AppBar(
          title: Text('Give and Get Help'),
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
                      'Request Help',
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
                      'Send Help',
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
            title: Text('Request Help'),
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final severityController = TextEditingController();
  final itemController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    severityController.dispose();
    itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Text('Level of Severity', textAlign: TextAlign.center, textScaleFactor: 2),
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
                    String severity = severityController.text;
                    String item = itemController.text;
                    print(email);
                    print(password);
                    String json = '{"email": "$email", "password": "$password", "severity" : "$severity", "item" : "$item"}';
                    Response response = await post(url, headers: headers, body: json);
                    int statusCode = response.statusCode;
                    String body = response.body;
                    print(body);
                    print(statusCode);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RequestDetails()));
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

class RequestDetails extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Request Details',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Request Details'),
          ),
          body: MyCustomFormRequestDetails(),
        )
    );
  }
}
class MyCustomFormRequestDetails extends StatefulWidget {
  @override
  MyCustomFormStateRequestDetails createState() {
    return MyCustomFormStateRequestDetails();
  }
}
class MyCustomFormStateRequestDetails extends State<MyCustomFormRequestDetails> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final severityDetailController = TextEditingController();
  final itemDetailController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
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
                    String severityDetail = severityDetailController.text;
                    String itemDetail = itemDetailController.text;
                    String json = '{"severityDetail": "$severityDetail", "itemDetail": "$itemDetail"}';
                    Response response = await post(url, headers: headers, body: json);
                    int statusCode = response.statusCode;
                    String body = response.body;
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
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Profile',
        home: Text("Profile"),
    );
  }
}

class SendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Send Help',
        home: Text("Send some help"),
    );
  }
}

// Create a Form widget.