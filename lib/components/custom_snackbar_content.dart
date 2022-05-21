import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSnackbarContent extends StatelessWidget {
  const CustomSnackbarContent({
    Key? key,
    required this.messageDescription,
    this.messageTitle,
    this.cardBgColor,
    this.iconName,
  }) : super(key: key);

  final String messageDescription;
  final String? messageTitle;
  final Color? cardBgColor;
  final String? iconName;

  @override
  Widget build(BuildContext context) {
    var iconName = this.iconName ?? 'bubbles';
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: cardBgColor ?? const Color(0xFFFF6055),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const SizedBox(width: 45),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      messageTitle ?? 'Oh Snap!',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      messageDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    const Spacer(),
                  ],
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SvgPicture.asset(
              'assets/bubbles.svg',
              height: 40,
              width: 35,
            ),
          ),
        ),
        Positioned(
          top: -15,
          left: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                'assets/fail.svg',
                height: 35,
              ),
              Positioned(
                bottom: 12,
                child: Icon(
                  iconName == 'bubbles'
                      ? Icons.report_problem_sharp
                      : Icons.check,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
