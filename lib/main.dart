// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  Locale _locale = const Locale("en");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      locale: _locale,
      theme: _themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme(_locale.languageCode)
          : MyAppThemeConfig.light().getTheme(_locale.languageCode),
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: MyHomePage(
        toggleThemeMode: () {
          setState(() {
            if (_themeMode == ThemeMode.dark) {
              _themeMode = ThemeMode.light;
            } else {
              _themeMode = ThemeMode.dark;
            }
          });
        },
        setLanguage: (_Language _language) {
          setState(() {
            _locale = _language == _Language.en
                ? const Locale("en")
                : const Locale("fa");
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(_Language _language) setLanguage;

  const MyHomePage(
      {super.key, required this.toggleThemeMode, required this.setLanguage});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// ignore: camel_case_types
enum SkillsType { photoshop, adobeXd, illustrator, affterEffect, lightroom }

enum _Language { fa, en }

class _MyHomePageState extends State<MyHomePage> {
  SkillsType skill = SkillsType.photoshop;
  _Language _language = _Language.en;

  void _updateSkill(SkillsType skillsType) {
    setState(() {
      // ignore: unnecessary_this
      this.skill = skillsType;
    });
  }

  void _upadateSelectedLanguage(_Language language) {
    widget.setLanguage(language);
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            localizations.profileTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            const Icon(CupertinoIcons.chat_bubble),
            const SizedBox(width: 8),
            InkWell(
              onTap: widget.toggleThemeMode,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 10, 0),
                child: Icon(CupertinoIcons.ellipsis_vertical),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/image/profile2.png',
                        width: 65,
                        height: 65,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(localizations.name,
                                style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Text(
                                  localizations.job,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.location_solid,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  localizations.location,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            )
                          ]),
                    ),
                    Icon(
                      CupertinoIcons.heart,
                      size: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 32, 16),
                child: Text(
                  localizations.summary,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w900),
                        localizations.selectedlanguage),
                    CupertinoSlidingSegmentedControl<_Language>(
                        groupValue: _language,
                        children: {
                          _Language.en: Text(
                            localizations.enLanguage,
                            style: TextStyle(fontSize: 10),
                          ),
                          _Language.fa: Text(localizations.faLanguage,
                              style: TextStyle(fontSize: 10)),
                        },
                        onValueChanged: (value) => {
                              if (value != null)
                                {_upadateSelectedLanguage(value)}
                            })
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      localizations.skills,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    const Icon(
                      CupertinoIcons.chevron_down,
                      size: 10,
                    )
                  ],
                ),
              ),
              Center(
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    SkillsContainer(
                      skillsType: SkillsType.photoshop,
                      title: 'Photoshop',
                      imagePath: 'assets/image/phtoshop.jpg',
                      shadowColor: Colors.blue,
                      isActive: skill == SkillsType.photoshop ? true : false,
                      onTap: () {
                        _updateSkill(SkillsType.photoshop);
                      },
                    ),
                    SkillsContainer(
                      skillsType: SkillsType.adobeXd,
                      title: 'Adobe XD',
                      imagePath: 'assets/image/Adobe xd.png',
                      shadowColor: Colors.pink,
                      isActive: skill == SkillsType.adobeXd ? true : false,
                      onTap: () {
                        _updateSkill(SkillsType.adobeXd);
                      },
                    ),
                    SkillsContainer(
                      skillsType: SkillsType.illustrator,
                      title: 'illustrator',
                      imagePath: 'assets/image/illustrator.png',
                      shadowColor: Colors.orange,
                      isActive: skill == SkillsType.illustrator ? true : false,
                      onTap: () {
                        _updateSkill(SkillsType.illustrator);
                      },
                    ),
                    SkillsContainer(
                      skillsType: SkillsType.affterEffect,
                      title: 'After Effect',
                      imagePath: 'assets/image/After effects.png',
                      shadowColor: Colors.blue.shade800,
                      isActive: skill == SkillsType.affterEffect ? true : false,
                      onTap: () {
                        _updateSkill(SkillsType.affterEffect);
                      },
                    ),
                    SkillsContainer(
                      skillsType: SkillsType.lightroom,
                      title: 'Ligthroom',
                      imagePath: 'assets/image/Lightroom.png',
                      shadowColor: Colors.blue.shade300,
                      isActive: skill == SkillsType.lightroom ? true : false,
                      onTap: () {
                        _updateSkill(SkillsType.lightroom);
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(localizations.personalInformation,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w900)),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: localizations.email,
                          prefixIcon: const Icon(CupertinoIcons.at)),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: localizations.password,
                          prefixIcon: const Icon(CupertinoIcons.lock)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                          onPressed: () => print("ff"),
                          child: Text(localizations.save)),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class MyAppThemeConfig {
  static const String faPrimaryTextThemes = "Iranyekan";
  final Color primaryTextColor;
  final Color surfaceColor;
  final Color scaffoldBackgroundColor;
  final Color appBarColor;
  final Brightness brightness;
  final Color primaryMyColor;

  MyAppThemeConfig.dark()
      : primaryTextColor = Colors.white,
        surfaceColor = const Color(0x0dffffff),
        scaffoldBackgroundColor = const Color.fromARGB(255, 30, 30, 30),
        appBarColor = Colors.black,
        primaryMyColor = const Color.fromARGB(255, 160, 99, 99),
        brightness = Brightness.dark;
  MyAppThemeConfig.light()
      : primaryTextColor = Colors.grey.shade900,
        surfaceColor = const Color(0x0d000000),
        scaffoldBackgroundColor = Colors.white,
        appBarColor = const Color.fromARGB(255, 235, 235, 235),
        primaryMyColor = const Color.fromARGB(255, 160, 99, 99),
        brightness = Brightness.light;
  ThemeData getTheme(String languageCode) {
    return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryMyColor))),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: surfaceColor),
      primarySwatch: Colors.pink,
      primaryColor: primaryMyColor,
      brightness: brightness,

      //change background color
      // ARGB(ternasparent,red,green,blue)
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: appBarColor,
          foregroundColor: primaryMyColor),
      textTheme: enPrimaryTextTheme,
    );
  }

  TextTheme get enPrimaryTextTheme => GoogleFonts.latoTextTheme(
        TextTheme(
            bodySmall: TextStyle(fontSize: 10, color: primaryTextColor),
            bodyLarge: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: primaryTextColor),
            bodyMedium: TextStyle(fontSize: 11, color: primaryTextColor),
            titleLarge: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: primaryMyColor),
            titleMedium: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: Colors.green)),
      );

  TextTheme get faPrimaryTextTheme => TextTheme(
      bodySmall: TextStyle(
          fontSize: 10,
          color: primaryTextColor,
          fontFamily: faPrimaryTextThemes),
      bodyLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: primaryTextColor,
          fontFamily: faPrimaryTextThemes),
      bodyMedium: TextStyle(
          fontSize: 11,
          color: primaryTextColor,
          fontFamily: faPrimaryTextThemes),
      titleLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w900,
          color: primaryTextColor,
          fontFamily: faPrimaryTextThemes),
      titleMedium: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w900,
          fontFamily: faPrimaryTextThemes,
          color: Colors.green));
}

class SkillsContainer extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isActive;
  final Color shadowColor;
  final SkillsType skillsType;
  final Function() onTap;
  const SkillsContainer(
      {super.key,
      required this.isActive,
      required this.title,
      required this.imagePath,
      required this.shadowColor,
      required this.skillsType,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: 110,
        height: 110,
        decoration: isActive
            ? BoxDecoration(
                color: const Color.fromARGB(
                  30,
                  255,
                  255,
                  255,
                ),
                borderRadius: BorderRadius.circular(12))
            : null,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            decoration: isActive
                ? BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: shadowColor.withOpacity(0.5), blurRadius: 20)
                  ])
                : null,
            child: Image.asset(
              imagePath,
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(title),
        ]),
      ),
    );
  }
}
