import 'package:flutter/material.dart';
import 'package:tasky/empty.dart';
import 'package:tasky/login.dart';
import 'package:tasky/toDo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> form = GlobalKey();
  List<Map> toDo = [];
  String? des;
  String? task;

  String? date = (DateTime.now()).toString();
  int pirority = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,

      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                spacing: 9,
                mainAxisAlignment: .end,
                children: [
                  Image.asset("I/logout.png", width: 24, height: 24),
                  Text(
                    "Log out",
                    style: TextStyle(
                      fontWeight: .w400,
                      fontSize: 16,
                      color: Color(0xffFF4949),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        title: Padding(
          padding: EdgeInsets.only(left: 8),
          child: SizedBox(
            height: 32,
            width: 80,
            child: Image.asset("I/tasky2.png", width: 80, height: 32),
          ),
        ),
      ),
      body: (toDo.isEmpty)
          ? Padding(padding: const EdgeInsets.all(8.0), child: Empty())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ToDo(toDo: toDo),
            ),
      //
      floatingActionButton: ClipOval(
        child: FloatingActionButton.large(
          backgroundColor: Color(0xffF4F4F4),
          onPressed: () async {
            pirority = toDo.length + 1;
            await showModalBottomSheet(
              context: context,
              backgroundColor: Theme.of(context).primaryColor,
              builder: (context) {
                return SafeArea(
                  child: AnimatedPadding(
                    padding: EdgeInsets.only(
                      left: 24,
                      top: 24,
                      right: 24,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    duration: Duration(milliseconds: 400),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: .min,
                        mainAxisAlignment: .spaceAround,
                        crossAxisAlignment: .center,
                        children: [
                          Text(
                            "Add Task",
                            style: TextStyle(
                              fontWeight: .w700,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 12),

                          Form(
                            key: form,

                            child: Column(
                              children: [
                                TextFormField(
                                  onSaved: (newValue) {
                                    setState(() {
                                      task = newValue;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    hint: Text(
                                      "Do math homework",
                                      style: TextStyle(
                                        color: Color(0xff7F7F7F),
                                        fontWeight: .w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                    fillColor: Color(0xffffffff),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Color(0xff979797),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Color(0xff979797),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12),
                                TextFormField(
                                  onSaved: (newValue) {
                                    setState(() {
                                      des = newValue;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    hint: Text(
                                      "Description",
                                      style: TextStyle(
                                        color: Color(0xff7F7F7F),
                                        fontWeight: .w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                    fillColor: Color(0xffffffff),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Color(0xff979797),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(
                                        color: Color(0xff979797),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: .spaceBetween,
                            crossAxisAlignment: .end,
                            children: [
                              Row(
                                mainAxisAlignment: .start,
                                spacing: 9,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      date = (await showDialog<DateTime>(
                                        context: context,
                                        builder: (context) {
                                          return DatePickerDialog(
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2030),
                                          );
                                        },
                                      ))?.toString();
                                    },
                                    child: Image.asset(
                                      "I/timer.png",
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      int index = pirority - 1;
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            child: Builder(
                                              builder: (context) {
                                                return StatefulBuilder(
                                                  builder:
                                                      (
                                                        BuildContext context,
                                                        void Function(
                                                          void Function(),
                                                        )
                                                        setDialogState,
                                                      ) {
                                                        return Container(
                                                          height: 360,
                                                          width: 330,
                                                          decoration: BoxDecoration(
                                                            color: Theme.of(
                                                              context,
                                                            ).primaryColor,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  4,
                                                                ),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize: .min,

                                                            mainAxisAlignment:
                                                                .start,
                                                            crossAxisAlignment:
                                                                .center,
                                                            children: [
                                                              SizedBox(
                                                                height: 10,
                                                              ),

                                                              Text(
                                                                "Task Priority",
                                                                textAlign:
                                                                    .center,
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                      .w700,
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black,
                                                                  letterSpacing:
                                                                      -.5,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                              Divider(),
                                                              SizedBox(
                                                                height: 8,
                                                              ),

                                                              Expanded(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets.all(
                                                                        8.0,
                                                                      ),
                                                                  child: GridView.builder(
                                                                    itemCount:
                                                                        toDo.length +
                                                                        1,

                                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                      crossAxisCount:
                                                                          4,
                                                                      crossAxisSpacing:
                                                                          2,
                                                                      mainAxisSpacing:
                                                                          2,
                                                                    ),

                                                                    itemBuilder: (context, i) {
                                                                      return MaterialButton(
                                                                        color:
                                                                            (index ==
                                                                                i)
                                                                            ? Theme.of(
                                                                                context,
                                                                              ).secondaryHeaderColor
                                                                            : Color(
                                                                                0xffffffff,
                                                                              ),
                                                                        height:
                                                                            64,
                                                                        minWidth:
                                                                            64,
                                                                        shape: RoundedRectangleBorder(
                                                                          side: BorderSide(
                                                                            color: Color(
                                                                              0xff6E6A7C,
                                                                            ),
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                4,
                                                                              ),
                                                                        ),
                                                                        onPressed: () {
                                                                          index =
                                                                              i;

                                                                          setDialogState(
                                                                            () {},
                                                                          );
                                                                        },
                                                                        child: Column(
                                                                          mainAxisAlignment:
                                                                              .spaceEvenly,
                                                                          crossAxisAlignment:
                                                                              .center,
                                                                          children: [
                                                                            Image.asset(
                                                                              "I/flag.png",
                                                                              width: 24,
                                                                              color:
                                                                                  (i ==
                                                                                      index)
                                                                                  ? Color(
                                                                                      0xffffffff,
                                                                                    )
                                                                                  : Color(
                                                                                      0xff5F33E1,
                                                                                    ),
                                                                              height: 24,
                                                                            ),
                                                                            Text(
                                                                              "${i + 1}",
                                                                              style: TextStyle(
                                                                                fontWeight: .w400,
                                                                                fontSize: 16,
                                                                                color:
                                                                                    (index ==
                                                                                        i)
                                                                                    ? Theme.of(
                                                                                        context,
                                                                                      ).primaryColor
                                                                                    : Colors.black,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    .end,
                                                                mainAxisAlignment:
                                                                    .center,
                                                                spacing: 9,

                                                                children: [
                                                                  MaterialButton(
                                                                    onPressed: () {
                                                                      Navigator.pop(
                                                                        context,
                                                                      );
                                                                    },
                                                                    color: Color(
                                                                      0xffffffff,
                                                                    ),
                                                                    height: 48,
                                                                    minWidth:
                                                                        145,
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            4,
                                                                          ),
                                                                      side: BorderSide(
                                                                        color: Theme.of(
                                                                          context,
                                                                        ).secondaryHeaderColor,
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      "Cancel",
                                                                      style: TextStyle(
                                                                        color: Theme.of(
                                                                          context,
                                                                        ).secondaryHeaderColor,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            .w400,
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  MaterialButton(
                                                                    onPressed: () {
                                                                      pirority =
                                                                          index +
                                                                          1;

                                                                      setState(
                                                                        () {},
                                                                      );
                                                                      Navigator.pop(
                                                                        context,
                                                                      );
                                                                    },
                                                                    color: Theme.of(
                                                                      context,
                                                                    ).secondaryHeaderColor,
                                                                    height: 48,
                                                                    minWidth:
                                                                        145,
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            4,
                                                                          ),
                                                                      side: BorderSide(
                                                                        color: Theme.of(
                                                                          context,
                                                                        ).secondaryHeaderColor,
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      "Save",
                                                                      style: TextStyle(
                                                                        color: Theme.of(
                                                                          context,
                                                                        ).primaryColor,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            .w400,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Image.asset(
                                      "I/flag.png",
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  form.currentState!.save();
                                  date ??= (DateTime.now()).toString();

                                  if (des != null &&
                                      des!.isNotEmpty &&
                                      task != null &&
                                      task!.isNotEmpty) {
                                    for (var item in toDo) {
                                      if (item["id"] >= pirority) {
                                        item["id"]++;
                                      }
                                    }

                                    DateTime taskDate = DateTime.parse(date!);

                                    List<String> days = [
                                      "MON",
                                      "TUE",
                                      "WED",
                                      "THU",
                                      "FRI",
                                      "SAT",
                                      "SUN",
                                    ];

                                    toDo.add({
                                      "task": task,
                                      "des": des,
                                      "date": taskDate,
                                      "day": days[taskDate.weekday - 1],
                                      "dayNumber": taskDate.day,
                                      "id": pirority,
                                      "completed": false,
                                    });

                                    toDo.sort(
                                      (a, b) => a["id"].compareTo(b["id"]),
                                    );

                                    pirority = toDo.length + 1;

                                    Navigator.pop(context);
                                  }
                                },
                                child: Image.asset(
                                  "I/send.png",
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
              isScrollControlled: true,

              useSafeArea: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),

              sheetAnimationStyle: AnimationStyle(
                duration: Duration(milliseconds: 400),

                reverseDuration: Duration(milliseconds: 400),
              ),
              barrierColor: Colors.black.withAlpha(100),
            );
          },
          child: Icon(Icons.add, size: 40, color: Color(0xff5F33E1)),
        ),
      ),
    );
  }
}
