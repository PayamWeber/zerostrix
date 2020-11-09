import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:zerostrix/Helpers/Helpers.dart';
import 'package:zerostrix/Helpers/session.dart';
import 'package:zerostrix/Views/Auth/Signinup.dart';
import 'package:zerostrix/Views/Home/home.dart';
import 'package:zerostrix/Views/Insta/index.dart';

class HomeIndex extends StatefulWidget {
	@override
	_HomeIndexState createState() {
		var state = _HomeIndexState();
		Session().set(name: 'HomeState', value: state);
		return state;
	}
}

class _HomeIndexState extends State<HomeIndex> with TickerProviderStateMixin {
	String title = 'Zero Strix';
	int currentSlideIndex = 0;
	final PageController pageController = PageController(initialPage: 0);
	List bottomNavMenuItems = [
		{
			'icon': FontAwesomeIcons.home,
			'id': 0
		},
		{
			'icon': FontAwesomeIcons.images,
			'id': 1
		},
		{
			'icon': FontAwesomeIcons.userAlt,
			'id': 2
		},
	];
	List<AnimationController> menuAnimationController = [];
	List<Animation<double>> menuItemAnimation = [];

	@override
	void initState() {

		for ( Map menuItem in bottomNavMenuItems ){
			menuAnimationController.insert(
				menuItem['id'],
				AnimationController(duration: Duration(milliseconds: 150), value: 0.8, vsync: this)
			);
			menuItemAnimation.insert(
				menuItem['id'],
				CurvedAnimation(parent: menuAnimationController[menuItem['id']], curve: Curves.easeIn)
			);
		}
		super.initState();
	}

	@override
	void dispose() {
		pageController.dispose();
		for( dynamic animationController in menuAnimationController ){
			animationController.dispose();
		}
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		Session().set(name: 'homeContext', value: context);
		return Scaffold(
			body: Stack(
				children: <Widget>[
					PageView.builder(
						physics: NeverScrollableScrollPhysics(),
						itemBuilder: (context, index) {
							if (index == 0) {
								return LandingPage();
							} else if (index == 1) {
								return InstaIndex();
							} else {
								return Signinup();
							}
						},
						itemCount: 3,
						onPageChanged: (index) {
							setState(() {
								this.currentSlideIndex = index;
							});
						},
						controller: pageController,
					),
					Align(
						alignment: Alignment.bottomCenter,
						child: Container(
							decoration: BoxDecoration(
								borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
								boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 30, spreadRadius: -10, offset: Offset.fromDirection(11, 40))]),
							child: ClipRRect(
								borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
								child: Stack(
									children: <Widget>[
										Container(
											width: Session().getDouble(name: 'windowWidth'),
											height: 80,
										),
										Positioned(
											top: 1,
											child: BackdropFilter(
												filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
												child: Container(
													child: Row(
														children: bottomNavMenuItems.map((value) {
															double paddingRight = value['id'] == 0 ? 25 : 40;
															double paddingLeft = value['id'] == bottomNavMenuItems.length - 1 ? 25 : 40;
															return GestureDetector(
																child: Container(
																	padding: EdgeInsets.only(top: 15, bottom: 15, right: paddingRight, left: paddingLeft),
																	child: ScaleTransition(
																		scale: menuItemAnimation[value['id']],
																		alignment: Alignment.center,
																		child: FaIcon(
																			value['icon'],
																			size: 30,
																			color: this.currentSlideIndex == value['id'] ? Colors.white : Colors.white.withOpacity(0.4),
																			semanticLabel: 'hello',
																		),
																	),
																	decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0)),
																),
																onTap: () {
																	setState(() {
																		bool isBigJump = abs(this.currentSlideIndex - value['id']) > 1;
																		menuAnimationController[this.currentSlideIndex].animateTo(0.8,duration: Duration(milliseconds: 50));
																		menuAnimationController[value['id']].animateTo(1.2);
																		this.currentSlideIndex = value['id'];
																		if (isBigJump) {
																			pageController.jumpToPage(value['id']);
																		} else {
																			pageController.animateToPage(
																				value['id'],
																				duration: Duration(milliseconds: 400),
																				curve: Curves.fastLinearToSlowEaseIn,
																			);
																		}
																	});
																},
															);
														}).toList(),
														mainAxisAlignment: MainAxisAlignment.center,
													),
													width: Session().getDouble(name: 'windowWidth'),
													height: 80,
													foregroundDecoration: BoxDecoration(color: Colors.white.withOpacity(0.02), borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
												),
											),
										)
									],
								),
							),
						)
					),
				],
			),
			/*bottomNavigationBar: BottomNavigationBar(
				items: <BottomNavigationBarItem>[
					BottomNavigationBarItem(
						icon: Icon(Icons.home),
						title: Text('خانه'),
					),
					BottomNavigationBarItem(
						icon: Icon(Icons.camera_alt),
						title: Text('دوربین')
					),
					BottomNavigationBarItem(
						icon: Icon(Icons.account_box),
						title: Text('پروفایل'),
					),
				],
				type: BottomNavigationBarType.shifting,
				currentIndex: currentSlideIndex,
				onTap: (index) {
					setState(() {
						pageController.animateToPage(
							index,
							duration: Duration(milliseconds: 500),
							curve: Curves.ease
						);
					});
				},
			),*/
		);
	}
}
