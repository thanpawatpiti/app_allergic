import 'package:allergic_app/localization/language/languages.dart';
import 'package:allergic_app/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;

  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final List dataOnboard = [
      {
        "image":
            'assets/images/1906.i203.016.allergy_symptoms-removebg-preview.png',
        "title": Languages.of(context)!.onBoardTitle1,
        "description": Languages.of(context)!.onBoardDescription1,
      },
      {
        "image": 'assets/images/17439389-removebg-preview.png',
        "title": Languages.of(context)!.onBoardTitle2,
        "description": Languages.of(context)!.onBoardDescription2,
      },
      {
        "image": 'assets/images/handdrawn_vector_61-removebg-preview.png',
        "title": Languages.of(context)!.onBoardTitle3,
        "description": Languages.of(context)!.onBoardDescription3,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(4.h, 0.9.h, 4.h, 0.8.h),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: dataOnboard.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnboardContent(
                      image: dataOnboard[index]['image'],
                      title: dataOnboard[index]['title'],
                      description: dataOnboard[index]['description'],
                    );
                  },
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    dataOnboard.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(
                        right: 2.h,
                      ),
                      child: DotIndicator(
                        isActive: index == _pageIndex,
                      ),
                    ),
                  ),
                  const Spacer(),
                  _pageIndex == 2
                      ? SizedBox(
                          height: 13.h,
                          width: 13.w,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => const LoginScreen()),
                                ),
                                (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 13.h,
                          width: 13.w,
                          child: ElevatedButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2.w,
      height: isActive ? 3.h : 1.h,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          height: 45.h,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          description,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 11.sp,
          )
        ),
        const Spacer(),
      ],
    );
  }
}
