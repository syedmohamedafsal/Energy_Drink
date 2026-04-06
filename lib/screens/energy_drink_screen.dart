import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../data/drinks_data.dart';
import '../widgets/arc_painter.dart';
import '../widgets/receipt_card.dart';
import '../widgets/shared_components.dart';

class EnergyDrinkScreen extends StatefulWidget {
  const EnergyDrinkScreen({super.key});

  @override
  State<EnergyDrinkScreen> createState() => _EnergyDrinkScreenState();
}

class _EnergyDrinkScreenState extends State<EnergyDrinkScreen> {
  int _currentIndex = 0;
  bool _isPurchasing = false;

  void _nextDrink() {
    if (_isPurchasing) return;
    setState(() {
      _currentIndex = (_currentIndex + 1) % drinksData.length;
    });
  }

  void _prevDrink() {
    if (_isPurchasing) return;
    setState(() {
      _currentIndex = (_currentIndex - 1 + drinksData.length) % drinksData.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeDrink = drinksData[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.transparent, // Background handled by AnimatedContainer
      body: Stack(
        children: [
          // The base layer UI
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOutCubic,
            color: activeDrink.bgColor,
            child: SafeArea(
              child: Column(
                children: [
                  // Top App Bar Area
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: _isPurchasing ? 0.0 : 1.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildIconButton(Icons.shopping_cart_outlined, activeDrink.iconBgColor, activeDrink.iconColor),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 600),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: activeDrink.textColor.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 600),
                                  style: TextStyle(
                                    color: activeDrink.textColor,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                  ),
                                  child: const Text("Explore more"),
                                ),
                                const SizedBox(width: 8),
                                TweenAnimationBuilder<Color?>(
                                  duration: const Duration(milliseconds: 600),
                                  tween: ColorTween(begin: activeDrink.textColor, end: activeDrink.textColor),
                                  builder: (context, color, child) {
                                    return Icon(Icons.arrow_outward, color: color, size: 18);
                                  },
                                ),
                              ],
                            ),
                          ),
                          buildIconButton(Icons.menu, activeDrink.iconBgColor, activeDrink.iconColor),
                        ],
                      ),
                    ),
                  ),
                  
                  // Header Text
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: _isPurchasing ? 0.0 : 1.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          buildAnimatedText("Pure Taste Power.", activeDrink.textColor),
                          buildAnimatedText("Meet our new blend:", activeDrink.textColor),
                          buildAnimatedText(activeDrink.name, activeDrink.highlightColor),
                        ],
                      ),
                    ),
                  ),

                  // 3D Model Area with Arc and Arrows
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOutCubic,
                      alignment: _isPurchasing ? Alignment.bottomRight : Alignment.center,
                      transform: _isPurchasing 
                        ? Matrix4.translationValues(0, MediaQuery.of(context).size.height * 0.15, 0) 
                        : Matrix4.identity(),
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOutCubic,
                        scale: _isPurchasing ? 0.02 : 1.0, 
                        child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // The Arc Curve
                              Positioned.fill(
                                child: TweenAnimationBuilder<Color?>(
                                  duration: const Duration(milliseconds: 600),
                                  tween: ColorTween(begin: activeDrink.arcColor, end: activeDrink.arcColor),
                                  builder: (context, color, child) {
                                    return CustomPaint(
                                      painter: ArcPainter(arcColor: color ?? Colors.white),
                                    );
                                  },
                                ),
                              ),
                              
                              // WebGL Model Layout
                              ...drinksData.asMap().entries.map((entry) {
                                final i = entry.key;
                                final drink = entry.value;

                                int diff = i - _currentIndex;
                                if (diff > drinksData.length / 2) {
                                  diff -= drinksData.length;
                                } else if (diff < -drinksData.length / 2) {
                                  diff += drinksData.length;
                                }

                                double slideOffsetX = 0.0;
                                double slideOffsetY = 0.0;
                                double rotationTurns = 0.0;

                                if (diff < 0) {
                                  slideOffsetX = -1.5;
                                  slideOffsetY = 0.5;
                                  rotationTurns = -0.2; 
                                } else if (diff > 0) {
                                  slideOffsetX = 1.5;
                                  slideOffsetY = 0.5;
                                  rotationTurns = 0.2; 
                                }

                                return Positioned.fill(
                                  child: AnimatedSlide(
                                    offset: Offset(slideOffsetX, slideOffsetY),
                                    duration: const Duration(milliseconds: 700),
                                    curve: Curves.easeInOutCubic,
                                    child: AnimatedRotation(
                                      turns: rotationTurns,
                                      duration: const Duration(milliseconds: 700),
                                      curve: Curves.easeInOutCubic,
                                      child: AnimatedOpacity(
                                        opacity: diff == 0 ? 1.0 : 0.0,
                                        duration: const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                        child: IgnorePointer(
                                          ignoring: diff != 0,
                                          child: ModelViewer(
                                            key: ValueKey(drink.path),
                                            src: drink.path,
                                            alt: drink.name,
                                            ar: false,
                                            autoRotate: true,
                                            disableZoom: true,
                                            cameraControls: true,
                                            backgroundColor: Colors.transparent,
                                            loading: Loading.eager,
                                            environmentImage: 'neutral',
                                            interactionPrompt: InteractionPrompt.none,
                                            shadowIntensity: 1,
                                            autoPlay: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              
                              // Navigation Arrows
                              Positioned(
                                left: 20,
                                child: AnimatedOpacity(
                                  opacity: _isPurchasing ? 0.0 : 1.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: IgnorePointer(
                                    ignoring: _isPurchasing,
                                    child: IconButton(
                                      onPressed: _prevDrink,
                                      icon: TweenAnimationBuilder<Color?>(
                                        duration: const Duration(milliseconds: 600),
                                        tween: ColorTween(begin: activeDrink.textColor, end: activeDrink.textColor),
                                        builder: (context, color, child) => Icon(Icons.arrow_back, color: color),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 20,
                                child: AnimatedOpacity(
                                  opacity: _isPurchasing ? 0.0 : 1.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: IgnorePointer(
                                    ignoring: _isPurchasing,
                                    child: IconButton(
                                      onPressed: _nextDrink,
                                      icon: TweenAnimationBuilder<Color?>(
                                        duration: const Duration(milliseconds: 600),
                                        tween: ColorTween(begin: activeDrink.textColor, end: activeDrink.textColor),
                                        builder: (context, color, child) => Icon(Icons.arrow_forward, color: color),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  // Nutritional Info
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: _isPurchasing ? 0.0 : 1.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildStat("25", "G", "of Protein", activeDrink.textColor),
                          buildStat("15", "kcal", "Per 100G", activeDrink.textColor),
                          buildStat("100", "%", "Plant-Based", activeDrink.textColor),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Buttons
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: _isPurchasing ? 0.0 : 1.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 600),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: activeDrink.textColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: TweenAnimationBuilder<Color?>(
                                duration: const Duration(milliseconds: 600),
                                tween: ColorTween(begin: activeDrink.bgColor, end: activeDrink.bgColor),
                                builder: (context, color, child) => Icon(Icons.arrow_outward, color: color, size: 28),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPurchasing = true;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 600),
                                height: 60,
                                decoration: BoxDecoration(
                                  color: activeDrink.accentColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 600),
                                    style: TextStyle(
                                      color: activeDrink.buttonTextColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: GoogleFonts.inter().fontFamily,
                                    ),
                                    child: const Text("Buy for \$25.00"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- OVERLAY LAYER --- //

          // Glass Blur Filter
          Positioned.fill(
            child: IgnorePointer(
              ignoring: !_isPurchasing,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                opacity: _isPurchasing ? 1.0 : 0.0,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    color: Colors.black.withOpacity(0.15),
                  ),
                ),
              ),
            ),
          ),

          // Digital Receipt Popup Card
          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutBack,
            bottom: _isPurchasing ? 0 : -MediaQuery.of(context).size.height,
            left: 0,
            right: 0,
            child: SafeArea(
              child: ReceiptCard(
                activeDrink: activeDrink,
                onClose: () {
                  setState(() {
                    _isPurchasing = false;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
