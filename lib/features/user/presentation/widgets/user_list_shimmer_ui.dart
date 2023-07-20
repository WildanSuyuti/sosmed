import 'package:flutter/material.dart';
import 'package:logique_test/features/commons/presentation/widgets/rounded_container.dart';
import 'package:logique_test/features/commons/presentation/widgets/shimmer_container.dart';

class UserListShimmerUI extends StatelessWidget {
  const UserListShimmerUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(8, (_) {
        return ShimmerContainer(
          child: RoundedContainer(
            border: Border.all(color: Colors.grey),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 8,
            ),
            margin: const EdgeInsets.all(8),
            child: Column(
              children: [
                RoundedContainer(
                  margin: const EdgeInsets.only(bottom: 8),
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.width * 0.25,
                  color: Colors.grey,
                ),
                RoundedContainer(
                  margin: const EdgeInsets.only(bottom: 8),
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 16,
                  color: Colors.grey,
                ),
                RoundedContainer(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: 10,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
