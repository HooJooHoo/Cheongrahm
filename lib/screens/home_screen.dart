import 'package:cheongrahm/screens/side_menu_screen.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cheongrahm/services/api_service.dart';
import 'package:cheongrahm/services/dayofweek_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color cheongRahmGreen = Colors.green,
    cheongRahmDarkGreen = const Color.fromARGB(255, 38, 88, 38),
    greenToDarkGreen = Colors.green,
    greenToDarkGreenException = Colors.green;
var backgroundColor = Colors.grey[200];
var whiteColor = Colors.white, blackColor = Colors.black;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int selectedIndex = 0;
  late String currentDate =
      "${GetDayOfWeek().getRequiredYear(getDayOfWeekOfToday())}년 ${GetDayOfWeek().getRequiredMonth(getDayOfWeekOfToday())}월 ${GetDayOfWeek().getRequiredDay(getDayOfWeekOfToday())}일";
  String dayOfWeekOfToday = DateFormat('EEEE').format(DateTime.now());

  List<Widget> listOfTab = [
    const Tab(
      child: Text(
        "월",
        style: TextStyle(fontSize: 20),
      ),
    ),
    const Tab(
      child: Text(
        "화",
        style: TextStyle(fontSize: 20),
      ),
    ),
    const Tab(
      child: Text(
        "수",
        style: TextStyle(fontSize: 20),
      ),
    ),
    const Tab(
      child: Text(
        "목",
        style: TextStyle(fontSize: 20),
      ),
    ),
    const Tab(
      child: Text(
        "금",
        style: TextStyle(fontSize: 20),
      ),
    ),
  ];

  int getDayOfWeekOfToday() {
    switch (dayOfWeekOfToday) {
      case "Monday":
        return 0;
      case "Tuesday":
        return 1;
      case "Wednesday":
        return 2;
      case "Thursday":
        return 3;
      case "Friday":
        return 4;
      default: //토요일, 일요일의 initialPage
        return 4;
    }
  }

  Future<void> getSharedPreferenceOfLunch() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("mondayLunch",
        await APIService().getLunchJsonFromAPI(GetDayOfWeek().getThisMonday()));
    prefs.setString("tuesdayLunch",
        await APIService().getLunchJsonFromAPI(GetDayOfWeek().getThisTuesday()));
    prefs.setString("wednesdayLunch",
        await APIService().getLunchJsonFromAPI(GetDayOfWeek().getThisWednesday()));
    prefs.setString("thursdayLunch",
        await APIService().getLunchJsonFromAPI(GetDayOfWeek().getThisThursday()));
    prefs.setString("fridayLunch",
        await APIService().getLunchJsonFromAPI(GetDayOfWeek().getThisFriday()));
  }

  Future<void> getSharedPreferenceOfDinner() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("mondayDinner",
        await APIService().getDinnerJsonFromAPI(GetDayOfWeek().getThisMonday()));
    prefs.setString("tuesdayDinner",
        await APIService().getDinnerJsonFromAPI(GetDayOfWeek().getThisTuesday()));
    prefs.setString("wednesdayDinner",
        await APIService().getDinnerJsonFromAPI(GetDayOfWeek().getThisWednesday()));
    prefs.setString("thursdayDinner",
        await APIService().getDinnerJsonFromAPI(GetDayOfWeek().getThisThursday()));
    prefs.setString("fridayDinner",
        await APIService().getDinnerJsonFromAPI(GetDayOfWeek().getThisFriday()));
  }

  Future<void> resetSharedPreferenceOfLunch() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("mondayLunch", "");
    prefs.setString("tuesdayLunch", "");
    prefs.setString("wednesdayLunch", "");
    prefs.setString("thursdayLunch", "");
    prefs.setString("fridayLunch", "");
  }

  Future<void> resetSharedPreferenceOfDinner() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("mondayDinner", "");
    prefs.setString("tuesdayDinner", "");
    prefs.setString("wednesdayDinner", "");
    prefs.setString("thursdayDinner", "");
    prefs.setString("fridayDinner", "");
  }

  Future<String> getLunchMeal(dayOfWeek) async {
    final prefs = await SharedPreferences.getInstance();
    switch (dayOfWeek) {
      case 0:
        return prefs.getString("mondayLunch")!;
      case 1:
        return prefs.getString("tuesdayLunch")!;
      case 2:
        return prefs.getString("wednesdayLunch")!;
      case 3:
        return prefs.getString("thursdayLunch")!;
      case 4:
        return prefs.getString("fridayLunch")!;
      default:
        return "Exception occured"; //index의 최대가 4이므로, 발생하지 않을 예외입니다.
    }
  }

  Future<String> getDinnerMeal(dayOfWeek) async {
    final prefs = await SharedPreferences.getInstance();
    switch (dayOfWeek) {
      case 0:
        return prefs.getString("mondayDinner")!;
      case 1:
        return prefs.getString("tuesdayDinner")!;
      case 2:
        return prefs.getString("wednesdayDinner")!;
      case 3:
        return prefs.getString("thursdayDinner")!;
      case 4:
        return prefs.getString("fridayDinner")!;
      default:
        return "Exception occured"; //index의 최대가 4이므로, 발생하지 않을 예외입니다.
    }
  }

  getPreviousState() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previous = prefs.getBool("darkMode");
    if (previous == null || previous == false) {
      setState(() {
        cheongRahmGreen = Colors.green;
        cheongRahmDarkGreen = const Color.fromARGB(255, 38, 88, 38);
        backgroundColor = Colors.grey[200];
        whiteColor = Colors.white;
        blackColor = Colors.black;
        greenToDarkGreen = Colors.green;
        greenToDarkGreenException = Colors.green;
        bulb = Icons.lightbulb;
      });
    } else {
      setState(() {
        cheongRahmGreen = const Color.fromARGB(160, 76, 175, 79);
        cheongRahmDarkGreen = const Color.fromARGB(160, 38, 88, 38);
        backgroundColor = const Color.fromARGB(255, 43, 43, 43);
        whiteColor = const Color.fromARGB(255, 20, 20, 20);
        blackColor = Colors.white;
        greenToDarkGreen = const Color.fromARGB(160, 38, 88, 38);
        greenToDarkGreenException = const Color.fromARGB(255, 38, 88, 38);
        bulb = Icons.lightbulb_outline;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPreviousState();
    resetSharedPreferenceOfLunch();
    resetSharedPreferenceOfDinner();
    avoidAsyncError();
  }

  Future<void> avoidAsyncError() async {
    _controller = TabController(length: listOfTab.length, vsync: this);
    _controller.index = getDayOfWeekOfToday();
    _controller.addListener(() {
      setState(() {
        selectedIndex = _controller.index;
        currentDate =
            "${GetDayOfWeek().getRequiredYear(selectedIndex)}년 ${GetDayOfWeek().getRequiredMonth(selectedIndex)}월 ${GetDayOfWeek().getRequiredDay(selectedIndex)}일";
      });
    });

    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("mondayLunch") !=
        await APIService()
            .getLunchJsonFromAPI(GetDayOfWeek().getThisMonday())) {
      resetSharedPreferenceOfLunch();
      resetSharedPreferenceOfDinner();
    }
    if (prefs.getString("mondayLunch") == null ||
        prefs.getString("mondayLunch") == "") {
      getSharedPreferenceOfLunch();
      getSharedPreferenceOfDinner();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: listOfTab.length,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 124, 124, 124),
          ),
          backgroundColor: backgroundColor,
          elevation: 0.0,
        ),
        drawer: const Sidemenu(),
        onDrawerChanged: (isOpened) => setState(() {}),
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(children: [
            Row(
              children: [
                const SizedBox(
                  width: 19,
                ),
                Text(
                  currentDate,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: blackColor),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              height: 40,
              width: 350,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TabBar(
                  controller: _controller,
                  indicator: BoxDecoration(
                    color: greenToDarkGreen,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor:
                      const Color.fromARGB(255, 124, 124, 124),
                  tabs: listOfTab),
            ),
            Expanded(
                child: TabBarView(
                    dragStartBehavior: DragStartBehavior.start,
                    controller: _controller,
                    children: [
                  Center(
                      child: FlipCard(
                    fill: Fill.fillBack,
                    direction: FlipDirection.HORIZONTAL,
                    side: CardSide.FRONT,
                    front: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(24.0),
                        height: 470,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: cheongRahmGreen,
                        ),
                        child: FutureBuilder(
                            future: getLunchMeal(0),
                            builder: ((BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              while (snapshot.hasData == false ||
                                  snapshot.data == "") {
                                //로딩 중
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ],
                                );
                              }
                              if (snapshot.hasError) {
                                //스냅샷 에러
                                return AlertDialog(
                                  title: const Text("오류"),
                                  content: const Text(
                                      "예기치 못한 오류가 발생했습니다. 어플리케이션을 재시작해주세요. 이와 같은 오류가 계속된다면 문의 부탁드립니다."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "확인",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            color: greenToDarkGreen,
                                          ),
                                        ))
                                  ],
                                );
                              } else {
                                //정상 작동
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              120, 38, 88, 38),
                                          borderRadius:
                                              BorderRadius.circular(7.0)),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.sunny,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "중식",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }))),
                    back: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(24.0),
                        height: 470,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: cheongRahmDarkGreen,
                        ),
                        child: FutureBuilder(
                            future: getDinnerMeal(0),
                            builder: ((BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData == false ||
                                  snapshot.data == "") {
                                //로딩 중
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                //스냅샷 에러
                                return AlertDialog(
                                  title: const Text("오류"),
                                  content: const Text(
                                      "예기치 못한 오류가 발생했습니다. 어플리케이션을 재시작해주세요. 이와 같은 오류가 계속된다면 문의 부탁드립니다."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "확인",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            color: greenToDarkGreen,
                                          ),
                                        ))
                                  ],
                                );
                              } else {
                                //정상 작동
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              120, 76, 175, 79),
                                          borderRadius:
                                              BorderRadius.circular(7.0)),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.nightlight,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "석식",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }))),
                  )),
                  Center(
                      //화요일
                      child: FlipCard(
                    fill: Fill.fillBack,
                    direction: FlipDirection.HORIZONTAL,
                    side: CardSide.FRONT,
                    front: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(24.0),
                        height: 470,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: cheongRahmGreen,
                        ),
                        child: FutureBuilder(
                            future: getLunchMeal(1),
                            builder: ((BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData == false ||
                                  snapshot.data == "") {
                                //로딩 중
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                //스냅샷 에러
                                return AlertDialog(
                                  title: const Text("오류"),
                                  content: const Text(
                                      "예기치 못한 오류가 발생했습니다. 어플리케이션을 재시작해주세요. 이와 같은 오류가 계속된다면 문의 부탁드립니다."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "확인",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            color: greenToDarkGreen,
                                          ),
                                        ))
                                  ],
                                );
                              } else {
                                //정상 작동
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              120, 38, 88, 40),
                                          borderRadius:
                                              BorderRadius.circular(7.0)),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.sunny,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "중식",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }))),
                    back: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(24.0),
                        height: 470,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: cheongRahmDarkGreen,
                        ),
                        child: FutureBuilder(
                            future: getDinnerMeal(1),
                            builder: ((BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData == false ||
                                  snapshot.data == "") {
                                //로딩 중
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                //스냅샷 에러
                                return AlertDialog(
                                  title: const Text("오류"),
                                  content: const Text(
                                      "예기치 못한 오류가 발생했습니다. 어플리케이션을 재시작해주세요. 이와 같은 오류가 계속된다면 문의 부탁드립니다."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "확인",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            color: greenToDarkGreen,
                                          ),
                                        ))
                                  ],
                                );
                              } else {
                                //정상 작동
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              120, 76, 175, 79),
                                          borderRadius:
                                              BorderRadius.circular(7.0)),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.nightlight,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "석식",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }))),
                  )),
                  Center(
                      //수요일
                      child: FlipCard(
                    fill: Fill.fillBack,
                    direction: FlipDirection.HORIZONTAL,
                    side: CardSide.FRONT,
                    front: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(24.0),
                        height: 470,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: cheongRahmGreen,
                        ),
                        child: FutureBuilder(
                            future: getLunchMeal(2),
                            builder: ((BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData == false ||
                                  snapshot.data == "") {
                                //로딩 중
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                //스냅샷 에러
                                return AlertDialog(
                                  title: const Text("오류"),
                                  content: const Text(
                                      "예기치 못한 오류가 발생했습니다. 어플리케이션을 재시작해주세요. 이와 같은 오류가 계속된다면 문의 부탁드립니다."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "확인",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            color: greenToDarkGreen,
                                          ),
                                        ))
                                  ],
                                );
                              } else {
                                //정상 작동
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              120, 38, 88, 40),
                                          borderRadius:
                                              BorderRadius.circular(7.0)),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.sunny,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "중식",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }))),
                    back: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(24.0),
                        height: 470,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: cheongRahmDarkGreen,
                        ),
                        child: FutureBuilder(
                            future: getDinnerMeal(2),
                            builder: ((BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData == false ||
                                  snapshot.data == "") {
                                //로딩 중
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                //스냅샷 에러
                                return AlertDialog(
                                  title: const Text("오류"),
                                  content: const Text(
                                      "예기치 못한 오류가 발생했습니다. 어플리케이션을 재시작해주세요. 이와 같은 오류가 계속된다면 문의 부탁드립니다."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "확인",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            color: greenToDarkGreen,
                                          ),
                                        ))
                                  ],
                                );
                              } else {
                                //정상 작동
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              120, 76, 175, 79),
                                          borderRadius:
                                              BorderRadius.circular(7.0)),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.nightlight,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "석식",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }))),
                  )),
                  Center(
                      //목요일
                      child: FlipCard(
                    fill: Fill.fillBack,
                    direction: FlipDirection.HORIZONTAL,
                    side: CardSide.FRONT,
                    front: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(24.0),
                        height: 470,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: cheongRahmGreen,
                        ),
                        child: FutureBuilder(
                            future: getLunchMeal(3),
                            builder: ((BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData == false ||
                                  snapshot.data == "") {
                                //로딩 중
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                //스냅샷 에러
                                return AlertDialog(
                                  title: const Text("오류"),
                                  content: const Text(
                                      "예기치 못한 오류가 발생했습니다. 어플리케이션을 재시작해주세요. 이와 같은 오류가 계속된다면 문의 부탁드립니다."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "확인",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            color: greenToDarkGreen,
                                          ),
                                        ))
                                  ],
                                );
                              } else {
                                //정상 작동
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              120, 38, 88, 40),
                                          borderRadius:
                                              BorderRadius.circular(7.0)),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.sunny,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "중식",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }))),
                    back: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(24.0),
                        height: 470,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: cheongRahmDarkGreen,
                        ),
                        child: FutureBuilder(
                            future: getDinnerMeal(3),
                            builder: ((BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData == false ||
                                  snapshot.data == "") {
                                //로딩 중
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                //스냅샷 에러
                                return AlertDialog(
                                  title: const Text("오류"),
                                  content: const Text(
                                      "예기치 못한 오류가 발생했습니다. 어플리케이션을 재시작해주세요. 이와 같은 오류가 계속된다면 문의 부탁드립니다."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "확인",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            color: greenToDarkGreen,
                                          ),
                                        ))
                                  ],
                                );
                              } else {
                                //정상 작동
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              120, 76, 175, 79),
                                          borderRadius:
                                              BorderRadius.circular(7.0)),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.nightlight,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "석식",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }))),
                  )),
                  Center(
                      //금요일
                      child: FlipCard(
                    fill: Fill.fillBack,
                    direction: FlipDirection.HORIZONTAL,
                    side: CardSide.FRONT,
                    front: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(24.0),
                        height: 470,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: cheongRahmGreen,
                        ),
                        child: FutureBuilder(
                            future: getLunchMeal(4),
                            builder: ((BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData == false ||
                                  snapshot.data == "") {
                                //로딩 중
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                //스냅샷 에러
                                return AlertDialog(
                                  title: const Text("오류"),
                                  content: const Text(
                                      "예기치 못한 오류가 발생했습니다. 어플리케이션을 재시작해주세요. 이와 같은 오류가 계속된다면 문의 부탁드립니다."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "확인",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            color: greenToDarkGreen,
                                          ),
                                        ))
                                  ],
                                );
                              } else {
                                //정상 작동
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              120, 38, 88, 40),
                                          borderRadius:
                                              BorderRadius.circular(7.0)),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.sunny,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "중식",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }))),
                    back: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(24.0),
                        height: 470,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: cheongRahmDarkGreen,
                        ),
                        child: FutureBuilder(
                            future: getDinnerMeal(4),
                            builder: ((BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData == false ||
                                  snapshot.data == "") {
                                //로딩 중
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                //스냅샷 에러
                                return AlertDialog(
                                  title: const Text("오류"),
                                  content: const Text(
                                      "예기치 못한 오류가 발생했습니다. 어플리케이션을 재시작해주세요. 이와 같은 오류가 계속된다면 문의 부탁드립니다."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "확인",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            color: greenToDarkGreen,
                                          ),
                                        ))
                                  ],
                                );
                              } else {
                                //정상 작동
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              120, 76, 175, 79),
                                          borderRadius:
                                              BorderRadius.circular(7.0)),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.nightlight,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "석식",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }))),
                  )),
                ])),
          ]),
        ),
      ),
    );
  }
}
