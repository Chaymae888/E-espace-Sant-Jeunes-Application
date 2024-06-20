import 'package:chiclet/chiclet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import 'Screen1.dart';

class Chooselanguage extends StatefulWidget {
  const Chooselanguage({super.key});

  @override
  State<Chooselanguage> createState() => _ChooselanguageState();
}

class _ChooselanguageState extends State<Chooselanguage> {
  bool en = false;
  bool fr = false;
  bool ar = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool darkMode = WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    String language;
    if (en) {
      language = 'en';
    } else if (fr) {
      language = 'fr';
    } else {
      language = 'ar';
    }
    return MaterialApp(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('fr')
      ],
      locale: Locale(language),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: darkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        body: Builder(
          builder: (context) {
            final appLocalizations = AppLocalizations.of(context);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.05),
                Text(appLocalizations!.language, style: TextStyle(fontSize: 30)),
                SizedBox(height: height * 0.12),
                Container(
                  alignment: Alignment.center,
                  child: ChicletOutlinedAnimatedButton(
                    buttonHeight: 2,
                    width: width * 0.9,
                    height: 70,
                    onPressed: () {
                      setState(() {
                        en = true;
                        fr = false;
                        ar = false;
                      });
                    },
                    backgroundColor: !darkMode? Colors.grey.shade100:Colors.grey.shade900,
                    borderColor: en ? Colors.blue : Colors.grey,
                    child: Row(
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/usa.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.04),
                        const Text("English", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Container(
                  alignment: Alignment.center,
                  child: ChicletOutlinedAnimatedButton(
                    buttonHeight: 2,
                    width: width * 0.9,
                    height: 70,
                    backgroundColor: !darkMode? Colors.grey.shade100:Colors.grey.shade900,
                    borderColor: fr ? Colors.blue : Colors.grey,
                    onPressed: () {
                      setState(() {
                        en = false;
                        fr = true;
                        ar = false;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 7),
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/french.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.04),
                        const Text("Francais", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Container(
                  alignment: Alignment.center,
                  child: ChicletOutlinedAnimatedButton(
                    buttonHeight: 2,
                    width: width * 0.9,
                    height: 70,
                    backgroundColor: !darkMode? Colors.grey.shade100:Colors.grey.shade900,
                    borderColor: ar ? Colors.blue : Colors.grey,
                    onPressed: () {
                      setState(() {
                        en = false;
                        fr = false;
                        ar = true;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/maroc.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.04),
                        const Text("Arabe", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.08),
                ChicletOutlinedAnimatedButton(
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Screen1(language: language)),
                    );
                  },
                  backgroundColor: Colors.blue,
                  borderColor: Colors.green,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    appLocalizations.next,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
