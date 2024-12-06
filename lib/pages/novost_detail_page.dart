import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/novost.dart';
import '../utils/utils.dart';
import '../widgets/my_button.dart';

class NovostDetailPage extends StatelessWidget {
  const NovostDetailPage({super.key, required this.novost});

  final Novost novost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 320,
                decoration: const BoxDecoration(
                  color: Color(0xffF8FF13),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(46),
                  ),
                ),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: novost.image,
                      height: 194,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) {
                        return const CupertinoActivityIndicator();
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Center(
                          child: Text(
                            novost.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontFamily: 'w700',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 42),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  novost.body,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'w700',
                  ),
                ),
              ),
              const SizedBox(height: 42),
            ],
          ),
          Positioned(
            top: 10 + statusbar(context),
            left: 10,
            child: MyButton(
              onPressed: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
