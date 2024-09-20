import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_viewer/products/bloc/product_bloc.dart';
import 'package:product_viewer/util/shared_constants.dart';

class ConnectionErrorDisplay extends StatelessWidget {
  const ConnectionErrorDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.signal_wifi_connected_no_internet_4_outlined,
            size: 150),
        const SizedBox.square(dimension: kNormalGap),
        Text(
          "Couldn't connect to server",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox.square(dimension: kNormalGap),
        ElevatedButton(
          onPressed: () =>
              context.read<ProductBloc>().add(RetryProductFetched()),
          child: const Text('Retry'),
        )
      ],
    );
  }
}
