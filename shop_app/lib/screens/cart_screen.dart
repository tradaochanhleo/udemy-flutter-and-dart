import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders_provider.dart';
import '/widgets/cart_item_widget.dart';
import '/providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('YOUR CART'),
      ),
      body: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 6,
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$ ${cart.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColorDark,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  OrderButton(cart: cart),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: ((context, index) {
                return CartItemWidget(
                  id: cart.items.values.toList()[index].id,
                  title: cart.items.values.toList()[index].title,
                  quantity: cart.items.values.toList()[index].quantity,
                  price: cart.items.values.toList()[index].price,
                  productId: cart.items.keys.toList()[index],
                );
              }),
              itemCount: cart.itemCount,
            ),
          ),
        ],
      ),
    );
  }
}

// kh??ng bao gi??? d??ng ??? ????u kh??c n??n ????? lu??n trong file n??y c??ng ???????c
class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final CartProvider cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<OrdersProvider>(context, listen: false).addOder(
                  widget.cart.items.values.toList(), widget.cart.totalAmount);
              // v?? m??nh ch??? d??ng c??i provider n??y ????? ?????y data ??i
              // n??n kh??ng c???n listen, listen ch??? d??ng khi m?? m??nh
              // c???n hi???n th??? d??? li???u (c???n th???y ???????c s??? c???p nh???t)
              setState(() {
                _isLoading = false;
              });
              Provider.of<CartProvider>(context, listen: false).clear();
            },
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : const Text('ORDER NOW!'),
    );
  }
}
