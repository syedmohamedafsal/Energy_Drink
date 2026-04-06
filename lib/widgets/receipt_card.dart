import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/drink.dart';
import 'dashed_line_painter.dart';

class ReceiptCard extends StatelessWidget {
  final Drink activeDrink;
  final VoidCallback onClose;

  const ReceiptCard({
    super.key,
    required this.activeDrink,
    required this.onClose,
  });

  TextStyle _receiptTextStyle(bool isBold) {
    return TextStyle(
      fontSize: 16,
      fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
      color: isBold ? Colors.black87 : Colors.black45,
      fontFamily: GoogleFonts.inter().fontFamily,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          // Main Ticket Body
          Container(
            margin: const EdgeInsets.only(top: 40),
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: activeDrink.bgColor.withOpacity(0.6),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "SUCCESS!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: activeDrink.textColor,
                    letterSpacing: 2.0,
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Order #ED-20495",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black45,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Item Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: activeDrink.bgColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(Icons.local_drink_rounded, color: activeDrink.textColor, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activeDrink.name.replaceAll('.', ''),
                            style: _receiptTextStyle(true).copyWith(fontSize: 16),
                          ),
                          const SizedBox(height: 6),
                          Text("1x Quantity", style: _receiptTextStyle(false).copyWith(fontSize: 13)),
                        ],
                      ),
                    ),
                    Text("\$25.00", style: _receiptTextStyle(true).copyWith(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Fees
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Taxes & Delivery", style: _receiptTextStyle(false).copyWith(fontSize: 14)),
                    Text("\$3.50", style: _receiptTextStyle(false).copyWith(fontSize: 14)),
                  ],
                ),
                
                const SizedBox(height: 24),
                // Dashed Ticket Divider
                CustomPaint(
                  size: const Size(double.infinity, 1),
                  painter: DashedLinePainter(),
                ),
                const SizedBox(height: 24),
                
                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total (USD)", style: _receiptTextStyle(false).copyWith(fontSize: 14)),
                    Text(
                      "\$28.50", 
                      style: _receiptTextStyle(true).copyWith(
                        fontSize: 26, 
                        color: activeDrink.textColor
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 36),

                // Barcode Placeholder
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(35, (index) {
                      final widths = [2.0, 4.0, 1.0, 3.0, 1.5, 5.0];
                      return Container(
                        width: widths[index % widths.length],
                        margin: const EdgeInsets.only(right: 2.5),
                        color: Colors.black87,
                      );
                    }),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Glowing Button
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    height: 56,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: activeDrink.textColor,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: activeDrink.textColor.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        )
                      ]
                    ),
                    child: Center(
                      child: Text(
                        "Return Home",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                          fontFamily: GoogleFonts.inter().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Overlapping Badge 
          Positioned(
            top: 0,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: activeDrink.bgColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 6),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  )
                ]
              ),
              child: Icon(Icons.check_rounded, color: activeDrink.textColor, size: 40),
            ),
          ),
        ],
      ),
    );
  }
}
