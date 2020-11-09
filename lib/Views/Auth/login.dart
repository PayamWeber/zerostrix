import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zerostrix/Helpers/Helpers.dart';
import 'package:zerostrix/Helpers/session.dart';

class LoginPage extends StatefulWidget {
	@override
	_LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
	final TextEditingController emailController = TextEditingController();
	final TextEditingController passwordController = TextEditingController();
	FocusNode emailFocusNode = FocusNode();
	FocusNode passwordFocusNode = FocusNode();
	String errorText = '';
	Widget loadingContainer = Container();
	Widget errorContainer = Container();

	@override
	void initState() {
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Stack(
				children: <Widget>[
					Center(
						child: Column(
							children: <Widget>[
								Text(
									'ورود',
									style: TextStyle(
										fontSize: 30
									),
								),
								SizedBox(
									height: 20,
								),
								this.errorContainer,
								SizedBox(
									height: 20,
								),
								Container(
									child: roundedBigTextInput(
										hint: 'ایمیل',
										key: 'email',
										controller: emailController,
										keyboardType: TextInputType.emailAddress,
										focusNode: emailFocusNode,
										onSubmitted: (value){
											passwordFocusNode.requestFocus();
										}
									),
									width: Session().get(name: 'windowWidth') - 50,
								),
								SizedBox(
									height: 20,
								),
								Container(
									child: roundedBigTextInput(
										hint: 'رمز عبور',
										key: 'password',
										controller: passwordController,
										hiddenCharacters: true,
										focusNode: passwordFocusNode,
										onSubmitted: ( value ){
											formSubmit();
										}
									),
									width: Session().get(name: 'windowWidth') - 50,
								),
								SizedBox(
									height: 20,
								),
								roundedBigFlatButton(
									title: 'ورود',
									onPressed: (){
										formSubmit();
									}
								)
							],
							mainAxisAlignment: MainAxisAlignment.center,
						),
					),
					this.loadingContainer
				]
			)
		);
	}

	showLoading() {
		this.loadingContainer = Stack(
			children: <Widget>[
				Container(
					child: new BackdropFilter(
						filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
						child: new Container(
							decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
						),
					),
					width: Session().get(name: 'windowWidth'),
					height: Session().get(name: 'windowHeight'),
				),
				Center(
					child: CircularProgressIndicator(),
				)
			],
		);
	}

	hideLoading() {
		this.loadingContainer = Container();
	}

	showError(String text) {
		setState(() {
			this.errorContainer = Container(
				child: Row(
					children: <Widget>[
						Icon(Icons.error),
						SizedBox(
							width: 10,
						),
						Expanded(
							child: Text(
								text,
								overflow: TextOverflow.ellipsis,
								maxLines: 3,
							),
						)
					],
				),
				width: Session().get(name: 'windowWidth') - 50,
				padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
				decoration: BoxDecoration(
					color: Colors.redAccent,
					borderRadius: BorderRadius.all(Radius.circular(50))
				),
			);
		});
	}

	hideError() {
		setState(() {
			this.errorContainer = Container();
		});
	}

	formSubmit(){
		if (emailController.value.text.length == 0) {
			showError('لطفا ایمیل را وارد کنید');
			return;
		}
		if (passwordController.value.text.length == 0) {
			showError('لطفا رمز عبور را وارد کنید');
			return;
		}
		emailFocusNode.unfocus();
		passwordFocusNode.unfocus();
		setState(() {
			this.showLoading();
		});
		Future.delayed(Duration(seconds: 2)).then((value) {
			setState(() {
				this.hideLoading();
			});
			Navigator.pushNamedAndRemoveUntil(context, '/', (context) => false);
		});
	}
}
