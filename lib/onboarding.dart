import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/login.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _StartState();
}

class _StartState extends State<Onboarding> {
  SharedPreferencesAsync sharedPreferencesAsync = SharedPreferencesAsync();

  PageController? controller;
  int currentIndex = 0;
  List<Map> content = [
    {
      "image": "I/i1.png",
      "title": "Manage your tasks",
      "des": "You can easily manage all of your daily tasks in DoMe for free",
    },
    {
      "image": "I/i2.png",
      "title": "Create daily routine",
      "des":
          "In Tasky you can create your personalized routine to stay productive",
    },
    {
      "image": "I/i3.png",
      "title": "Orgonaize your tasks",
      "des":
          "You can organize your daily tasks by adding your tasks into separate categories",
    },
  ];

  @override
  void initState() {
    controller = PageController();

    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,

      appBar: AppBar(
        title: TextButton(
          onPressed: () async {
            await sharedPreferencesAsync.setBool("isFirst", false);

            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => Login()));
          },
          child: Text(
            "SKIP",
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
        ),
      ),

      //
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .center,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  onPageChanged: (value) {
                    currentIndex = value;
                    setState(() {});
                  },
                  itemCount: content.length,
                  itemBuilder: (context, i) {
                    return Column(
                      mainAxisAlignment: .start,
                      children: [
                        Image.asset(
                          content[i]["image"],
                          width: 327,
                          height: 293,
                        ),

                        Row(
                          spacing: 9,
                          mainAxisAlignment: .center,
                          children: [
                            ...List.generate(content.length, (index) {
                              return Container(
                                width: 27,
                                height: 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(56),
                                  color: (index == i)
                                      ? Theme.of(context).secondaryHeaderColor
                                      : Color(0xffAFAFAF),
                                ),
                              );
                            }),
                          ],
                        ),
                        SizedBox(height: 24),

                        Column(
                          crossAxisAlignment: .center,
                          children: [
                            Text(
                              content[i]["title"],
                              textAlign: .center,

                              style: Theme.of(
                                context,
                              ).primaryTextTheme.bodyLarge,
                            ),
                            SizedBox(height: 16),
                            SizedBox(
                              width: 300,
                              child: Text(
                                content[i]["des"],
                                textAlign: .center,
                                style: Theme.of(
                                  context,
                                ).primaryTextTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      //
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12, right: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: .end,
                children: [
                  MaterialButton(
                    color: Theme.of(context).secondaryHeaderColor,
                    height: 48,

                    minWidth: 90,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () async {
                      if (controller!.page != null && controller!.page! < 2) {
                        controller!.nextPage(
                          duration: Duration(microseconds: 400),
                          curve: Curves.ease,
                        );
                        setState(() {});
                      } else {
                        sharedPreferencesAsync.setBool("isFirst", false);
                        await sharedPreferencesAsync.setBool("isFirst", false);

                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      }
                    },
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text(
                      (currentIndex <= 1) ? "Next" : "Get Started",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: .w400,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
