import 'package:flutter/material.dart';
import 'package:http/http.dart';

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

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormStateRegister extends State<MyCustomForm> {
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

// Create a corresponding State class.
// This class holds data related to the form.
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


// Create a Form widget.


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