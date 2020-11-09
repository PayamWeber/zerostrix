import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:zerostrix/Helpers/session.dart';

int rand( int min, int max ) {
	Random rnd;
	rnd = new Random( );
	return min + rnd.nextInt( max - min );
}

Widget roundedBigFlatButton( {String title, double borderRadius: 50, Color color: null, onPressed: null} ) {
	return FlatButton(
		child: Text(
			title,
			style: TextStyle( fontSize: 20 ),
		),
		color: color == null ? Theme
			.of( Session( ).get( name: 'homeContext' ) )
			.primaryColorDark : color,
		onPressed: onPressed,
		shape: RoundedRectangleBorder(
			borderRadius: BorderRadius.all( Radius.circular( borderRadius ) ),
		),
		padding: EdgeInsets.symmetric( vertical: 15, horizontal: 50 ),
	);
}

Widget roundedBigTextInput( {
	String hint: '',
	String key: 'key',
	TextEditingController controller: null,
	FocusNode focusNode: null,
	keyboardType: TextInputType.text,
	hiddenCharacters: false,
	onSubmitted: null,
} ) {
	return TextField(
		controller: controller,
		focusNode: focusNode,
		onSubmitted: onSubmitted,
		key: Key( key ),
		keyboardType: keyboardType,
		obscureText: hiddenCharacters,
		autofocus: false,
		textAlign: TextAlign.center,
		style: TextStyle(
			fontSize: 22.0,
			color: Color( 0xFFbdc6cf ),
		),
		decoration: InputDecoration(
			filled: true,
			fillColor: Color.fromARGB( 20, 250, 250, 250 ),
			hintText: hint,
			contentPadding: EdgeInsets.symmetric( vertical: 10, horizontal: 20 ),
			focusedBorder: OutlineInputBorder(
				borderSide: BorderSide( color: Colors.black12 ),
				borderRadius: BorderRadius.circular( 50 ),
			),
			enabledBorder: UnderlineInputBorder(
				borderSide: BorderSide( color: Colors.black12 ),
				borderRadius: BorderRadius.circular( 50 ),
			),
			border: UnderlineInputBorder(
				borderSide: BorderSide( color: Colors.black12 ),
				borderRadius: BorderRadius.circular( 50 ),
			),
		),
	);
}

///
///
///convert negative number to positive
///
///
int abs( int number ) {
	if ( number < 0 ) return number *= -1;
	return number;
}

getRequest( String url, Map body, Map headers ){
	
}

