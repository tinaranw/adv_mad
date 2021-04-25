part of 'pages.dart';

class MainMenu extends StatefulWidget {
  static const String routeName = "/mainmenu";
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool isLoading = false;
  String msg = "Fail";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Main Menu"),
        ),
        body: Container(
          // ignore: deprecated_member_use
          child: ElevatedButton.icon(
              onPressed: () async {
                //melanjutkan ke next stepe
                setState(() {
                  isLoading = true;
                });
                // String msg = await AuthServices.signUp(users);
                await AuthServices.signOut().then((value) {
                  if (value) {
                    setState(() {
                      isLoading = false;
                    });
                    ActivityServices.showToast(
                        "Login success", Colors.greenAccent);
                    Navigator.pushReplacementNamed(context, Login.routeName);
                  } else {
                    setState(() {
                      isLoading = false;
                    });
                    ActivityServices.showToast(msg, Colors.redAccent);
                  }
                });
              },
              icon: Icon(Icons.logout),
              label: Text("Logout"),
              style: ElevatedButton.styleFrom(
                primary: Colors.red[300],
                elevation: 0,
              )),
        ));
  }
}
