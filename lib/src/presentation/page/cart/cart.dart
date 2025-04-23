import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppywell/src/presentation/bloc/cart/cart_bloc.dart';
import 'package:shoppywell/src/presentation/bloc/cart/cart_event.dart';
import 'package:shoppywell/src/presentation/bloc/cart/cart_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: BlocListener<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              // Show success dialog or navigate to success page
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Success'),
                  content: Text('Payment done successfully.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/orders'),
                      child: Text('View Orders'),
                    ),
                  ],
                ),
              );
            } else if (state is PaymentFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message))
              );
            }
          },
          child:  BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            return Column(
              children: [
                // Your existing checkout UI
                
                // Payment button
                ElevatedButton(
                  onPressed: state is PaymentLoading 
                    ? null 
                    : () {
                        // Get order from cart or pass it from previous screen
                        // final order = Order(
                        //   id: 'order_${DateTime.now().millisecondsSinceEpoch}',
                        //   totalAmount: 7000.0, // Get from your cart
                        //   items: [...], // Get from your cart
                        // );
                        
                        context.read<PaymentBloc>().add(ProcessPaymentEvent());
                      },
                  child: state is PaymentLoading
                    ? CircularProgressIndicator()
                    : Text('Proceed to Payment'),
                ),
              ],
            );
          },)
        ),
      
    );
  }
}