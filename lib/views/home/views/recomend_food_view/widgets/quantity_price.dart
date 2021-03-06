import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/home/widgets/quantity_numberic.dart';
import 'package:food_shop/widgets/buttons/custom_icon_button.dart';
import 'package:food_shop/widgets/texts/body_text.dart';
import 'package:food_shop/widgets/texts/header_text.dart';

class QuantityPrice extends StatefulWidget {
  final String name;
  final double price;
  final int quantity;
  const QuantityPrice({
    required this.name,
    required this.price,
    required this.quantity,
    Key? key,
  }) : super(key: key);

  @override
  State<QuantityPrice> createState() => _QuantityPriceState();
}

class _QuantityPriceState extends State<QuantityPrice> {
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    quantity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          HeaderText(widget.name, fontSize: Spacing.lg),
          Spacing.vertical.m,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BodyText(
                '\$ ${widget.price}',
                fontSize: Spacing.lg,
                fontWeight: FontWeight.w300,
              ),
              QuantityNumberic(
                initQuantity: quantity,
                onChanged: (quantity) {
                  setState(() {
                    this.quantity = quantity;
                  });
                },
              ),
            ],
          ),
          Spacing.vertical.m,
          const Divider(thickness: 1.0),
          Spacing.vertical.m,
          Align(
            alignment: Alignment.centerRight,
            child: Text.rich(
              TextSpan(
                text: 'Total: ',
                children: [
                  TextSpan(
                    text: '\$ ${(widget.price * quantity).toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: kBlackColor,
                      fontSize: Spacing.m,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              style: const TextStyle(
                color: kDefaultTextColor,
                fontSize: Spacing.s,
              ),
            ),
          ),
          Spacing.vertical.m,
          Align(
            alignment: Alignment.centerRight,
            child: KIconButton(
              size: Spacing.xxl,
              icon: Icons.add_shopping_cart,
              iconScale: .5,
              elevation: 20.0,
              iconColor: kPrimaryLightColor,
              backgroundColor: kSecondaryDarkColor,
              onPressed: () {
                Navigator.of(context).maybePop(quantity);
              },
            ),
          )
        ],
      ),
    );
  }
}
