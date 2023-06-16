import 'package:cheongrahm/common/custom_icons_icons.dart';
import 'package:cheongrahm/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var bulb = Icons.lightbulb;

class Sidemenu extends StatefulWidget {
  const Sidemenu({super.key});

  @override
  State<Sidemenu> createState() => _SidemenuState();
}

class _SidemenuState extends State<Sidemenu> {
  bool state = false;

  getPreviousState() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previous = prefs.getBool("darkMode");
    if (previous == null) {
      state = false;
    } else {
      setState(() {
        state = previous;
      });
    }
  }

  @override
  void initState() {
    getPreviousState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: greenToDarkGreenException,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 90,
          ),
          const Icon(
            CustomIcons.DefalultNameofIcon,
            color: Colors.white,
            size: 60,
          ),
          const SizedBox(
            height: 80,
          ),
          ListTile(
            leading: Icon(
              bulb,
              size: 28,
              color: Colors.white,
            ),
            title: Row(
              children: [
                const Text(
                  "다크 모드",
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                const SizedBox(
                  width: 60,
                ),
                Switch.adaptive(
                    value: state,
                    activeColor: cheongRahmGreen,
                    onChanged: (value) async {
                      state = value;
                      final prefs = await SharedPreferences.getInstance();
                      setState(() {
                        prefs.setBool("darkMode", value);
                        if (prefs.getBool("darkMode") == false) {
                          //라이트 모드
                          cheongRahmGreen = Colors.green;
                          cheongRahmDarkGreen =
                              const Color.fromARGB(255, 38, 88, 38);
                          backgroundColor = Colors.grey[200];
                          whiteColor = Colors.white;
                          blackColor = Colors.black;
                          greenToDarkGreen = Colors.green;
                          greenToDarkGreenException = Colors.green;
                          bulb = Icons.lightbulb;
                        } else {
                          //다크 모드
                          cheongRahmGreen =
                              const Color.fromARGB(160, 76, 175, 79);
                          cheongRahmDarkGreen =
                              const Color.fromARGB(160, 38, 88, 38);
                          backgroundColor =
                              const Color.fromARGB(255, 43, 43, 43);
                          whiteColor = const Color.fromARGB(255, 20, 20, 20);
                          blackColor = Colors.white;
                          greenToDarkGreen =
                              const Color.fromARGB(160, 38, 88, 38);
                          greenToDarkGreenException =
                              const Color.fromARGB(255, 38, 88, 38);
                          bulb = Icons.lightbulb_outline;
                        }
                      });
                    }),
              ],
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              size: 25,
              color: Colors.white,
            ),
            title: const Text(
              "정보",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("정보"),
                  content: const Text(
                      "이 어플리케이션은 청원중학교, 청원고등학교, 청원여자고등학교의 급식 정보를 제공하기 위해 제작되었습니다. 앞으로 다양한 기능이 추가될 예정입니다.\n\n로딩이 지속된다면 어플리케이션을 재시작해주세요.\n\n개발자 연락처 : HooJooHoo050@gmail.com\n\n앱 버전 : 1.0.6"),
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
