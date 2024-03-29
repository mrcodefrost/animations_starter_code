import 'package:flutter/material.dart';

class ShoppingCartButton extends StatefulWidget {
  const ShoppingCartButton({super.key});

  @override
  State<ShoppingCartButton> createState() => _ShoppingCartButtonState();
}

class _ShoppingCartButtonState extends State<ShoppingCartButton> {
  bool isExpanded = false;
  bool showText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;

              if (isExpanded) {
                Future.delayed(const Duration(milliseconds: 150), () {
                  setState(() {
                    showText = true;
                  });
                });
              } else {
                // hide text immediately if isExpanded is false
                showText = false;
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 900),
            curve: Curves.fastEaseInToSlowEaseOut,
            width: isExpanded ? 200 : 80,
            height: 60.0,
            decoration: BoxDecoration(
              color: isExpanded ? Colors.green : Colors.blue,
              borderRadius: isExpanded
                  ? BorderRadius.circular(100)
                  : BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  isExpanded ? Icons.check : Icons.shopping_cart,
                  color: Colors.white,
                ),
                if (showText)
                  const Text(
                    'Added to cart',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
