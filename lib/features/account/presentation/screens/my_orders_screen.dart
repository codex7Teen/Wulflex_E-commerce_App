import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/cart/bloc/order_bloc/order_bloc.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';

class ScreenMyOrders extends StatelessWidget {
  const ScreenMyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OrderBloc>().add(FetchUserOrdersEvent());
    return Scaffold(
      appBar: customAppbarWithBackbutton(context, 'My Orders', 0.145),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderError) {
            return Text(state.errorMessage);
          } else if (state is OrderLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is OrdersLoaded) {
            final orders = state.orders;
            return Padding(
              padding: const EdgeInsets.only(
                  left: 18, right: 18, top: 18, bottom: 18),
              child: Column(children: [
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return Text(order.orderDate.toString());
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemCount: orders.length),
                )
              ]),
            );
          }
          return Text('sorry');
        },
      ),
    );
  }
}
