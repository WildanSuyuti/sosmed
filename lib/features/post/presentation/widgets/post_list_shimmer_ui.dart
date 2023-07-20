import 'package:flutter/material.dart';
import 'package:logique_test/features/commons/presentation/widgets/rounded_container.dart';
import 'package:logique_test/features/commons/presentation/widgets/shimmer_container.dart';
import 'package:logique_test/features/commons/presentation/widgets/underline_ui.dart';

class PostListShimmerUI extends StatelessWidget {
  const PostListShimmerUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: List.generate(
        3,
        (_) {
          return ShimmerContainer(
            child: RoundedContainer(
              border: Border.all(color: Colors.grey),
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RoundedContainer(
                        width: 40,
                        height: 40,
                        radius: 40,
                        margin: EdgeInsets.only(right: 16),
                        color: Colors.grey,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RoundedContainer(
                            margin: const EdgeInsets.only(bottom: 8),
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 18,
                            color: Colors.grey,
                          ),
                          RoundedContainer(
                            margin: const EdgeInsets.only(bottom: 8),
                            width: MediaQuery.of(context).size.width * 0.27,
                            height: 14,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                  RoundedContainer(
                    margin: const EdgeInsets.only(bottom: 16, top: 8),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    color: Colors.grey,
                  ),
                  Row(
                    children: List.generate(3, (_) {
                      return RoundedContainer(
                        margin: const EdgeInsets.only(bottom: 8, right: 8),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 25,
                        radius: 45,
                        color: Colors.grey,
                      );
                    }).toList(),
                  ),
                  RoundedContainer(
                    margin: const EdgeInsets.only(bottom: 8),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 14,
                    color: Colors.grey,
                  ),
                  RoundedContainer(
                    margin: const EdgeInsets.only(bottom: 8),
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: 14,
                    color: Colors.grey,
                  ),
                  UnderlineUI(margin: EdgeInsets.zero.copyWith(top: 8)),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.favorite_border, size: 25),
                      ),
                      Text(
                        'Like',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
