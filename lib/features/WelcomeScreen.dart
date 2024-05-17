import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notesapp/features/LoginScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController pageController = PageController();

  final List<Map<String, String>> pages = [
    {
      'image':
          'https://cdn.pixabay.com/photo/2015/05/31/15/14/woman-792162_960_720.jpg',
      'text': 'Keep all your notes'
    },
    {
      'image':
          'https://cdn.pixabay.com/photo/2024/05/11/11/23/ai-generated-8754819_960_720.jpg',
      'text': 'In one place'
    },
    {
      'image':
          'https://cdn.pixabay.com/photo/2016/11/22/19/25/adult-1850177_960_720.jpg',
      'text': 'At your palm'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Align(
                  alignment: Alignment(0.1, 0.0),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            children: [
                              PageView.builder(
                                controller: pageController,
                                scrollDirection: Axis.horizontal,
                                itemCount: pages.length,
                                itemBuilder: (context, position) {
                                  final page = pages[position];
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        page['image']!,
                                        height: 300,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        page['text']!,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: SmoothPageIndicator(
                                    controller: pageController,
                                    count: 3,
                                    axisDirection: Axis.horizontal,
                                    effect: WormEffect(
                                      dotColor: Color(0xffffc962),
                                      activeDotColor: Color(0xff000000),
                                      dotHeight: 8,
                                      dotWidth: 8,
                                      radius: 16,
                                      spacing: 8,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginScreen()),
                            );
                          },
                          color: Color(0xffffc962),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          textColor: Color(0xff000000),
                          height: 45,
                          minWidth: MediaQuery.of(context).size.width - 60,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
