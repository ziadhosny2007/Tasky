import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ToDo extends StatefulWidget {
  ToDo({super.key, required this.toDo});

  List<Map> toDo = [];

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  late List<Map> sel;
  late PageController controller;

  int selected = 0;
  String search = "";

  final List<String> weekdays = [
    "MON",
    "TUE",
    "WED",
    "THU",
    "FRI",
    "SAT",
    "SUN",
  ];

  final List<String> months = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC",
  ];

  @override
  void initState() {
    super.initState();

    sel = widget.toDo;

    selected = widget.toDo.length >= 3 ? 2 : 0;

    controller = PageController(initialPage: selected, viewportFraction: 0.2);

    updateTasks();
  }

  DateTime getDate(dynamic value) {
    if (value is DateTime) {
      return value;
    }

    return DateTime.parse(value.toString());
  }

  bool sameDate(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  void updateTasks() {
    if (widget.toDo.isEmpty) {
      sel = [];
      return;
    }

    if (selected >= widget.toDo.length) {
      selected = widget.toDo.length - 1;
    }

    DateTime selectedDate = getDate(widget.toDo[selected]["date"]);

    sel = widget.toDo.where((item) {
      DateTime itemDate = getDate(item["date"]);

      bool same = sameDate(itemDate, selectedDate);

      bool matchesSearch =
          item["task"].toString().toLowerCase().contains(
            search.toLowerCase(),
          ) ||
          item["des"].toString().toLowerCase().contains(search.toLowerCase());

      return same && matchesSearch;
    }).toList();
  }

  void deleteTask(Map task) {
    setState(() {
      widget.toDo.remove(task);

      if (widget.toDo.isEmpty) {
        sel = [];
        selected = 0;
        return;
      }

      if (selected >= widget.toDo.length) {
        selected = widget.toDo.length - 1;
      }

      updateTasks();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (value) {
              setState(() {
                search = value;
                updateTasks();
              });
            },
            decoration: InputDecoration(
              hint: const Text(
                "Search for your task...",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color(0xff6E6A7C),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: .8,
                  color: Color(0xff6E6A7C),
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              constraints: const BoxConstraints(maxHeight: 48),
              prefixIcon: Icon(
                Icons.search,
                size: 30,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
          ),
        ),

        // Calendar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SizedBox(
            height: 75,
            child: Row(
              children: [
                SizedBox(
                  width: 35,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (selected > 0) {
                        controller.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    icon: const Icon(Icons.arrow_back_ios, size: 18),
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    controller: controller,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.toDo.length,
                    onPageChanged: (value) {
                      setState(() {
                        selected = value;
                        updateTasks();
                      });
                    },
                    itemBuilder: (context, i) {
                      final DateTime date = getDate(widget.toDo[i]["date"]);

                      final bool isSelected = i == selected;

                      return InkWell(
                        onTap: () {
                          controller.animateToPage(
                            i,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: 46,
                            height: isSelected ? 62 : 58,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xff7047EB)
                                  : const Color(0xffF9F8FD),
                              borderRadius: BorderRadius.circular(9),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xff7047EB)
                                    : const Color(0xffE5E2EC),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  weekdays[date.weekday - 1],
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xffAFAFAF),
                                  ),
                                ),

                                const SizedBox(height: 2),

                                Text(
                                  "${date.day}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xffAFAFAF),
                                  ),
                                ),

                                const SizedBox(height: 1),

                                Text(
                                  months[date.month - 1],
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xffAFAFAF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(
                  width: 35,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (selected < widget.toDo.length - 1) {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Tasks
        Expanded(
          child: sel.isEmpty
              ? const Center(
                  child: Text(
                    "No tasks found",
                    style: TextStyle(color: Color(0xff6E6A7C), fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: sel.length,
                  itemBuilder: (context, i) {
                    final task = sel[i];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (task["completed"])
                          Container(
                            width: 76,
                            height: 31,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xff6E6A7C),
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              "Completed",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),

                        // Swipe Delete
                        Dismissible(
                          key: ValueKey(task["id"]),

                          direction: DismissDirection.startToEnd,

                          background: Container(
                            height: 72,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffE63248),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 25),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete_outline,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          onDismissed: (direction) {
                            deleteTask(task);
                          },

                          child: SizedBox(
                            height: 72,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  task["completed"] = !task["completed"];
                                });
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: Color(0xff6E6A7C),
                                  ),
                                ),
                                child: ListTile(
                                  isThreeLine: true,

                                  title: Text(
                                    task["task"],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),

                                  leading: Checkbox(
                                    value: task["completed"],
                                    shape: const OvalBorder(),
                                    activeColor: Theme.of(
                                      context,
                                    ).secondaryHeaderColor,
                                    onChanged: (value) {
                                      setState(() {
                                        task["completed"] = value;
                                      });
                                    },
                                  ),

                                  subtitle: Text(
                                    task["des"],
                                    style: const TextStyle(
                                      color: Color(0xffAFAFAF),
                                      fontSize: 14,
                                    ),
                                  ),

                                  trailing: Container(
                                    margin: const EdgeInsets.only(top: 24),
                                    width: 42,
                                    height: 29,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(
                                          context,
                                        ).secondaryHeaderColor,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset(
                                          "I/flag.png",
                                          width: 14,
                                          height: 14,
                                        ),
                                        Text("${task["id"]}"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }
}
