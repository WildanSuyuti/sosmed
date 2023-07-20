import 'package:flutter/material.dart';
import 'package:logique_test/features/commons/presentation/widgets/rounded_container.dart';
import 'package:logique_test/features/commons/presentation/widgets/shimmer_container.dart';

class CommentListShimmerUI extends StatelessWidget {
  const CommentListShimmerUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerContainer(
      child: ListView(
        shrinkWrap: true,
        children: List.generate(3, (_) {
          return Column(
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
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 16,
                        color: Colors.grey,
                      ),
                      RoundedContainer(
                        margin: const EdgeInsets.only(bottom: 8),
                        width: MediaQuery.of(context).size.width * 0.27,
                        height: 12,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              RoundedContainer(
                margin: const EdgeInsets.only(bottom: 8),
                width: MediaQuery.of(context).size.width * 0.27,
                height: 12,
                color: Colors.grey,
              ),
            ],
          );
        }),
      ),
    );
  }
}