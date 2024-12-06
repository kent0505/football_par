import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/button.dart';
import '../widgets/my_button.dart';
import '../widgets/my_svg.dart';
import 'home_page.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MySvg(
            'assets/o$index.svg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  index == 1
                      ? 'Be to the game and win! Everything about football in one app.'
                      : index == 2
                          ? 'Test your attentiveness and knowledge of football'
                          : 'All the latest news from the world of football in one app',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xffF8FF13),
                    fontSize: 36,
                    fontFamily: 'w900',
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const Spacer(),
              Button(
                title: 'Start',
                onPressed: () async {
                  if (index == 3) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('onboard', false);
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const HomePage();
                          },
                        ),
                        (route) => false,
                      );
                    }
                    // setState(() {
                    //   index = 1;
                    // });
                  } else {
                    setState(() {
                      index++;
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              MyButton(
                onPressed: () {},
                minSize: 20,
                child: Text(
                  'Terms of Use / Privacy Policy',
                  style: TextStyle(
                    color: const Color(0xffFAFAFA).withOpacity(0.4),
                    fontSize: 14,
                    fontFamily: 'w600',
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ],
      ),
    );
  }
}
