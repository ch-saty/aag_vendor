import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final String address;
  final String name;
  final String packageType;

  const CustomCard({
    super.key,
    required this.address,
    required this.name,
    required this.packageType,
  });

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> with TickerProviderStateMixin {
  late AnimationController _stretchController;
  late AnimationController _percentageController;
  late AnimationController _shineController;
  late AnimationController _flameController;
  late Animation<double> _percentageAnimation;
  late AnimationController _floatController;
  late Animation<double> _gradientAnimation;
  late Animation<Color?> _buttonGradientAnimation;
  late Animation<Color?> _flameAnimation;

  Offset _dragOffset = Offset.zero;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  List<Color> _getGradientColors() {
    switch (widget.packageType.toLowerCase()) {
      case 'standard':
        return [
          const Color(0xFF1D1F33),
          const Color(0xFF4E4376),
          const Color(0xFF6A0572),
        ];
      case 'pro':
        return [
          const Color(0xFF1D1F33),
          const Color.fromARGB(255, 239, 38, 209),
          const Color.fromARGB(255, 118, 4, 92),
        ];
      case 'elite':
        return [
          const Color(0xFF000000),
          const Color.fromARGB(255, 200, 172, 12),
          const Color(0xFF222222),
        ];
      case 'enterprise':
        return [
          const Color.fromARGB(255, 30, 73, 30),
          const Color(0xFF000000),
          const Color.fromARGB(255, 30, 73, 30),
        ];
      default:
        return [
          const Color(0xFF1D1F33),
          const Color(0xFF4E4376),
          const Color(0xFF6A0572),
        ];
    }
  }

  void _initializeAnimations() {
    _stretchController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _floatController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _gradientAnimation = Tween<double>(begin: -1, end: 1).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _percentageController = AnimationController(
      duration: const Duration(seconds: 100),
      vsync: this,
    )..forward();

    _shineController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _flameController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _percentageAnimation =
        Tween<double>(begin: 0, end: 100).animate(_percentageController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _shineController.repeat(reverse: true);
            }
          });

    _buttonGradientAnimation = ColorTween(
      begin: _getButtonStartColor(),
      end: _getButtonEndColor(),
    ).animate(CurvedAnimation(
      parent: _percentageController,
      curve: const Interval(0.9, 1.0),
    ));

    _flameAnimation = ColorTween(
      begin: Colors.orange.withOpacity(0.6),
      end: Colors.deepOrange.withOpacity(0.8),
    ).animate(_flameController);
  }

  Color _getButtonStartColor() {
    switch (widget.packageType.toLowerCase()) {
      case 'standard':
        return Colors.purple.withOpacity(0.7);
      case 'pro':
        return Colors.pink.withOpacity(0.7);
      case 'elite':
        return Colors.amber.withOpacity(0.7);
      case 'enterprise':
        return Colors.green.withOpacity(0.7);
      default:
        return Colors.purple.withOpacity(0.7);
    }
  }

  Color _getButtonEndColor() {
    switch (widget.packageType.toLowerCase()) {
      case 'standard':
        return Colors.deepPurple;
      case 'pro':
        return Colors.deepOrangeAccent;
      case 'elite':
        return Colors.orange;
      case 'enterprise':
        return Colors.lightGreen;
      default:
        return Colors.deepPurple;
    }
  }

  @override
  void dispose() {
    _stretchController.dispose();
    _percentageController.dispose();
    _shineController.dispose();
    _flameController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  String shortenAddress(String address) {
    if (address.length <= 10) return address;
    return '${address.substring(0, 6)}...${address.substring(address.length - 4)}';
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
      _scale = 1.0 + (_dragOffset.distance * 0.0005).clamp(0.0, 0.1);
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    _stretchController.forward(from: 0).then((_) {
      setState(() {
        _dragOffset = Offset.zero;
        _scale = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _handlePanUpdate,
      onPanEnd: _handlePanEnd,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _stretchController,
          _floatController,
        ]),
        builder: (context, child) {
          return Transform.translate(
            offset: _dragOffset,
            child: Transform.scale(
              scale: _scale * (1 - _stretchController.value * 0.1),
              child: _buildCard(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 230,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment(_gradientAnimation.value, -1),
          end: Alignment(-_gradientAnimation.value, 1),
          colors: _getGradientColors(),
        ),
      ),
      child: _buildCardContent(),
    );
  }

  Widget _buildCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Hii there!!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
            _buildCustomButton(),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.white.withOpacity(0.2),
        ),
        const SizedBox(height: 8),
        _buildFooter(),
      ],
    );
  }

  Widget _buildCustomButton() {
    return AnimatedBuilder(
      animation: Listenable.merge([_percentageController, _flameController]),
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _buttonGradientAnimation.value ?? _getButtonStartColor(),
                _buttonGradientAnimation.value != null
                    ? Color.lerp(_buttonGradientAnimation.value!,
                        _getButtonEndColor(), 0.5)!
                    : _getButtonEndColor(),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: _percentageAnimation.value == 100
                    ? _flameAnimation.value!
                    : _getButtonStartColor().withOpacity(0.6),
                blurRadius: 12,
                spreadRadius: 2,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: TextButton(
            onPressed: () {
              // Handle Withdraw action
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Withdraw',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildProgressDots(),
        Text(
          widget.packageType.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoItem('Return',
                  '${_percentageAnimation.value.toStringAsFixed(1)}%'),
              Image.asset(
                'lib/images/aag_white.png',
                width: 50,
                height: 50,
              ),
              _buildInfoItem('Daily Limit', '4/5'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressDots() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: List.generate(10, (index) {
          final threshold = (index + 1) * 10;
          final isActive = _percentageAnimation.value >= threshold;
          final color = isActive
              ? Color.lerp(
                  const Color(0xFFAAAAAA),
                  const Color(0xFF00C853),
                  (_percentageAnimation.value - threshold + 10) / 10,
                )!
              : const Color(0xFFAAAAAA);

          return AnimatedBuilder(
            animation: _shineController,
            builder: (context, child) {
              return Transform.scale(
                scale: isActive && _percentageAnimation.value == 100
                    ? 1 + _shineController.value * 0.2
                    : 1,
                child: Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.5),
                        blurRadius:
                            isActive && _percentageAnimation.value == 100
                                ? 4 + _shineController.value * 4
                                : 2,
                        spreadRadius:
                            isActive && _percentageAnimation.value == 100
                                ? 1 + _shineController.value * 2
                                : 0,
                      ),
                    ],
                  ),
                  child: CustomPaint(
                    painter: _Dot3DPainter(color: color),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

class _Dot3DPainter extends CustomPainter {
  final Color color;

  _Dot3DPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw base circle
    canvas.drawCircle(center, radius, paint);

    // Draw highlight
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center.translate(-radius * 0.2, -radius * 0.2),
        radius * 0.4, highlightPaint);

    // Draw shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center.translate(radius * 0.2, radius * 0.2),
        radius * 0.4, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
