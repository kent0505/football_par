import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/novost.dart';
import '../widgets/page_title.dart';
import 'novost_detail_page.dart';

class NovostPage extends StatelessWidget {
  const NovostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      children: [
        const PageTitle('News'),
        const SizedBox(height: 40),
        ...List.generate(
          novosti.length,
          (index) => _NovostCard(novost: novosti[index]),
        ),
        const SizedBox(height: 130),
      ],
    );
  }
}

class _NovostCard extends StatelessWidget {
  const _NovostCard({required this.novost});

  final Novost novost;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return NovostDetailPage(novost: novost);
              },
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 130,
              height: 120,
              child: Stack(
                children: [
                  Container(
                    width: 122,
                    height: 112,
                    decoration: BoxDecoration(
                      color: const Color(0xffF8FF13),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 122,
                      height: 112,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: CachedNetworkImage(
                          imageUrl: novost.image,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return const CupertinoActivityIndicator();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 112,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffF8FF13),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  novost.name,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'w700',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
