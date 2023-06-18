import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_application_1/features/cart/ui/cart_tile_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/ui/product_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    cartBloc.add(CartInitialEvent());
  }

  final CartBloc cartBloc = CartBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart Items')),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {},
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final succesState = state as CartSuccessState;
              return ListView.builder(
                  itemCount: succesState.cartItems.length,
                  itemBuilder: ((context, index) {
                    return CartTileWidget(
                        cartBloc: cartBloc,
                        productDataModel: succesState.cartItems[index]);
                  }));

              break;
            default:
              return Scaffold();
          }
        },
      ),
    );
  }
}
