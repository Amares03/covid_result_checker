import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSnackbarContent extends StatelessWidget {
  const CustomSnackbarContent({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFFFF6055),
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
                    const Text(
                      'Oh Snap!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      errorMessage,
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
                top: 8,
                child: SvgPicture.asset(
                  'assets/close.svg',
                  height: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
