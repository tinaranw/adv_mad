part of 'pages.dart';

class Login extends StatefulWidget {
  static const String routeName = "/login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(24),
        child: Stack(
          children: [
            ListView(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 24),
                        Image.asset(
                          "assets/images/logo.png",
                        ),
                        TextFormField(
                          controller: ctrlEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.mail_outline_rounded),
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            email = value;
                            if (value.isEmpty) {
                              return "Please fill in the field!";
                            } else {
                              if (!EmailValidator.validate(value)) {
                                return "Email isn't valid!";
                              } else {
                                return null;
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: ctrlPassword,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(Icons.vpn_key_rounded),
                              border: OutlineInputBorder(),
                              suffixIcon: new GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                child: Icon(isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              )),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            password = value;
                            return value.length < 6
                                ? "Password must have at least 6 characters!"
                                : null;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton.icon(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                await AuthServices.signIn(email, password)
                                    .then((value) {
                                  if (value == "success") {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    ActivityServices.showToast(
                                        "Login success", Colors.greenAccent);
                                    Navigator.pushReplacementNamed(
                                        context, MainMenu.routeName);
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    ActivityServices.showToast(
                                        value, Colors.redAccent);
                                  }
                                });
                              } else {
                                //kosongkan aja bisa
                                Fluttertoast.showToast(
                                    msg: "Please fill in the blanks!",
                                    backgroundColor: Colors.orangeAccent);
                              }
                            },
                            icon: Icon(Icons.login_rounded),
                            label: Text("Login"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.deepPurple[400], elevation: 0)),
                      ],
                    )),
                SizedBox(height: 24),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, Register.routeName);
                    },
                    child: Text("Not registered yet? Join now.",
                        style: TextStyle(
                            color: Colors.deepOrange[400], fontSize: 16)))
              ],
            )
          ],
        ),
      ),
    );
  }
}
