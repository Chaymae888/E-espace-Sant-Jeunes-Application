import 'package:chiclet/chiclet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Screen1 extends StatefulWidget {
  final String language;
  Screen1({super.key,required this.language});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  MaterialAccentColor borderColor = Colors.greenAccent;
  ThemeMode _themeMode;

  _Screen1State()
      : _themeMode = WidgetsBinding.instance.window.platformBrightness == Brightness.dark
      ? ThemeMode.dark
      : ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }
  int item=0;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _themeMode == ThemeMode.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: MaterialApp(
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
          Locale('fr')
        ],
        locale: Locale(widget.language),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: _themeMode,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              double height=MediaQuery.of(context).size.height;
              double width=MediaQuery.of(context).size.width;
              final appLocalizations = AppLocalizations.of(context);
              List<String> titles=[appLocalizations!.title1,appLocalizations.title2,appLocalizations.title3];
              List<String> body=[
                appLocalizations.description1,
                appLocalizations.description2,
                appLocalizations.description3
              ];
              List<LottieBuilder> animations =[Lottie.asset("assets/Animation1.json"),Lottie.asset("assets/Animation2.json"),Lottie.asset("assets/Animation3.json")];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: ThemeSwitcher(
                      onToggle: _toggleTheme,
                      isDarkMode: _themeMode == ThemeMode.dark,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: width,
                    height: height*0.3,
                    child: animations[item],
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    titles[item],
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity! < 0 && item<2) {
                        setState(() {
                          item++;
                        });
                      } else if (details.primaryVelocity! > 0 && item>0) {
                        setState(() {
                          item--;
                        });
                      }
                    },
                    child: Container(
                      height: height*0.3,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child:  Text(
                        body[item],
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap:(){
                            setState(() {
                              item=0;
                            });
                          },
                          child: Container(
                            height: 7,
                            width: width * 0.1,
                            decoration: BoxDecoration(
                              color: item==0? Colors.blue:Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                            setState(() {
                              item=1;
                            });
                          },
                          child: Container(
                            height: 7,
                            width: width * 0.1,
                            decoration: BoxDecoration(
                              color: item==1? Colors.blue:Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                            setState(() {
                              item=2;
                            });
                          },
                          child: Container(
                            height: 7,
                            width: 40,
                            decoration: BoxDecoration(
                              color: item==2? Colors.blue:Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  ChicletOutlinedAnimatedButton(
                    onPressed: () {
                      setState(() {
                        if (item<2){
                          item++;
                        }
                      });
                    },
                    backgroundColor: Colors.blue,
                    borderColor: borderColor,
                    width: width * 0.6,
                    child: Text(
                      item==2?appLocalizations.started:appLocalizations.next,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}

class ThemeSwitcher extends StatefulWidget {
  final VoidCallback onToggle;
  final bool isDarkMode;

  ThemeSwitcher({required this.onToggle, required this.isDarkMode});

  @override
  _ThemeSwitcherState createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  SMIInput<bool>? switchInput;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (switchInput != null) {
          widget.onToggle();
          switchInput!.value = !switchInput!.value;
        }
      },
      borderRadius: BorderRadius.circular(150),
      child: SizedBox(
        height: 50,
        width: 70,
        child: RiveAnimation.asset(
          "assets/switch_theme.riv",
          fit: BoxFit.fill,
          stateMachines: const ["Switch Theme"],
          onInit: (artboard) {
            final controller = StateMachineController.fromArtboard(artboard, "Switch Theme");
            if (controller != null) {
              artboard.addController(controller);
              switchInput = controller.findInput<bool>("isDark");
              switchInput?.value = widget.isDarkMode;
            }
          },
        ),
      ),
    );
  }
}