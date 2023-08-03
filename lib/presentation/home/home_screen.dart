// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/core/colors/app_color.dart';
import 'package:e_commerce_store/presentation/search/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/items_gride.dart';
import '../profile/profile.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHome();
}

class _ScreenHome extends State<ScreenHome> with TickerProviderStateMixin {
  late TabController _controller;
  late AnimationController _animationControllerOn;
  late AnimationController _animationControllerOff;
  late Animation<Color?> _colorTweenBackgroundOn;
  late Animation<Color?> _colorTweenBackgroundOff;
  late Animation<Color?> _colorTweenForegroundOn;
  late Animation<Color?> _colorTweenForegroundOff;
  int _currentIndex = 0;
  bool _buttonTap = false;
  int _prevControllerIndex = 0;
  double _aniValue = 0.0;
  double _prevAniValue = 0.0;

  final List<String> _categories = [
    'All',
    'Tv',
    'Watches',
    'Laptop',
  ];
  final Color _foregroundOn = Colors.white;
  final Color _foregroundOff = Colors.black;
  final Color _backgroundOn = AppConstantsColor.materialThemeColor;
  final Color _backgroundOff = Colors.white;
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _keys = [];

  @override
  void initState() {
    for (int index = 0; index < _categories.length; index++) {
      _keys.add(GlobalKey());
    }
    _controller = TabController(vsync: this, length: _categories.length);

    _controller.animation!.addListener(_handleTabAnimation);

    _controller.addListener(_handleTabChange);

    _animationControllerOff = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 75));

    _animationControllerOff.value = 1.0;
    _colorTweenBackgroundOff = _animationControllerOff
        .drive(ColorTween(begin: _backgroundOn, end: _backgroundOff));
    _colorTweenForegroundOff = _animationControllerOff
        .drive(ColorTween(begin: _foregroundOn, end: _foregroundOff));

    _animationControllerOn = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));

    _animationControllerOn.value = 1.0;
    _colorTweenBackgroundOn = _animationControllerOn
        .drive(ColorTween(begin: _backgroundOff, end: _backgroundOn));
    _colorTweenForegroundOn = _animationControllerOn
        .drive(ColorTween(begin: _foregroundOff, end: _foregroundOn));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationControllerOn.dispose();
    _animationControllerOff.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var respsize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: const HomeCustomAppBar(),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: .1,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Quibix.',
          style: TextStyle(fontSize: 35),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => const ScreenSearch(),
                    ),
                  ),
              icon: const Icon(
                CupertinoIcons.search,
                size: 30,
              )),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const ScreenProfile(),
              ),
            ),
            icon: CircleAvatar(
              radius: 17,
              backgroundImage: NetworkImage(
                  FirebaseAuth.instance.currentUser!.photoURL ?? ''),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: NotificationListener(
          onNotification: (OverscrollNotification notification) {
            if (notification.overscroll < 0 &&
                _scrollController.offset <=
                    (respsize.height * 0.02) - kToolbarHeight) {
              _scrollController.jumpTo(
                (_scrollController.offset + notification.overscroll).clamp(
                  0.0,
                  (respsize.height * 0.2) - kToolbarHeight,
                ),
              );
              return true;
            }
            return false;
          },
          child: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: respsize.height * 0.2,
                flexibleSpace: Material(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Colors.transparent,
                  elevation: 3,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/bannerimage.jpg'),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          key: _keys[index],
                          padding: const EdgeInsets.all(6.0),
                          child: ButtonTheme(
                            child: AnimatedBuilder(
                              animation: _colorTweenBackgroundOn,
                              builder: (context, child) => Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Material(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(18),
                                  elevation: 3,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(100, 50)),
                                      elevation: MaterialStateProperty.all(2),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              _getBackgroundColor(index)),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _controller.animateTo(index);
                                        _setCurrentIndex(index);
                                        _scrollTo(index);
                                      });
                                    },
                                    child: Text(
                                      _categories[index],
                                      style: TextStyle(
                                        color: _getForegroundColor(index),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
            body: TabBarView(
              controller: _controller,
              children: <Widget>[
                ItemsGrid(
                    products: FirebaseFirestore.instance
                        .collection('products')
                        .snapshots()),
                ItemsGrid(
                  products: FirebaseFirestore.instance
                      .collection('products')
                      .where('category', isEqualTo: 'Tv')
                      .snapshots(),
                ),
                ItemsGrid(
                    products: FirebaseFirestore.instance
                        .collection('products')
                        .where('category', isEqualTo: 'Watch')
                        .snapshots()),
                ItemsGrid(
                    products: FirebaseFirestore.instance
                        .collection('products')
                        .where('category', isEqualTo: 'LapTop')
                        .snapshots()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleTabAnimation() {
    _aniValue = _controller.animation!.value;
    if (!_buttonTap && ((_aniValue - _prevAniValue).abs() < 1)) {
      _setCurrentIndex(_aniValue.round());
    }
    _prevAniValue = _aniValue;
  }

  _handleTabChange() {
    if (_buttonTap) _setCurrentIndex(_controller.index);
    if ((_controller.index == _prevControllerIndex) ||
        (_controller.index == _aniValue.round())) _buttonTap = false;
    _prevControllerIndex = _controller.index;
  }

  _setCurrentIndex(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
      _triggerAnimation();
      _scrollTo(index);
    }
  }

  _triggerAnimation() {
    _animationControllerOn.reset();
    _animationControllerOff.reset();
    _animationControllerOn.forward();
    _animationControllerOff.forward();
  }

  _scrollTo(int index) {
    double screenWidth = MediaQuery.of(context).size.width;

    RenderBox? renderBox =
        _keys[index].currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      double size = renderBox.size.width;
      double position = renderBox.localToGlobal(Offset.zero).dx;
      double offset = (position + size / 2) - screenWidth / 2;

      if (offset < 0) {
        renderBox = _keys[0].currentContext?.findRenderObject() as RenderBox?;
        position = renderBox?.localToGlobal(Offset.zero).dx ?? 0.0;

        if (position > offset) {
          offset = position;
        }
      } else {
        renderBox = _keys[_categories.length - 1]
            .currentContext
            ?.findRenderObject() as RenderBox?;
        position = renderBox?.localToGlobal(Offset.zero).dx ?? 0.0;

        size = renderBox?.size.width ?? 0.0;
        if (position + size < screenWidth) {
          screenWidth = position + size;
        }
        if (position + size - offset < screenWidth) {
          offset = position + size - screenWidth;
        }
      }
      _scrollController.animateTo(
        offset + _scrollController.offset,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
      );
    }
  }

  Color? _getBackgroundColor(int index) {
    if (index == _currentIndex) {
      return _colorTweenBackgroundOn.value;
    } else if (index == _prevControllerIndex) {
      return _colorTweenBackgroundOff.value;
    } else {
      return _backgroundOff;
    }
  }

  Color? _getForegroundColor(int index) {
    if (index == _currentIndex) {
      return _colorTweenForegroundOn.value;
    } else if (index == _prevControllerIndex) {
      return _colorTweenForegroundOff.value;
    } else {
      return _foregroundOff;
    }
  }
}
