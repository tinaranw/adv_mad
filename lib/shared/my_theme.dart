part of 'shared.dart';

class MyTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      primarySwatch: Colors.deepPurple,
      backgroundColor: Color(0xFFf2f2f2),
      primaryColor: Colors.deepPurple[400],
      accentColor: Colors.deepOrange[400],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      fontFamily: GoogleFonts.lato().fontFamily,
    );
  }
  static ThemeData darkTheme() {
    return ThemeData(
      primarySwatch: Colors.deepPurple,
      backgroundColor: Color(0xFF262626),
      primaryColor: Colors.deepPurple[400],
      accentColor: Colors.deepOrange[400],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.lato().fontFamily,
    );
  }
}
