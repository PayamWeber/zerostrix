import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zerostrix/Helpers/Options.dart';
import 'package:zerostrix/Helpers/session.dart';
import 'package:zerostrix/Models/InstaPic.dart';
import 'package:zerostrix/Views/Home/index.dart';
import 'package:http/http.dart' as http;
import 'package:zerostrix/Helpers/Helpers.dart';
import 'package:zerostrix/Widgets/homeFirstSliderCard.dart';
import 'package:zerostrix/Widgets/homeLatestPostsCard.dart';

class Loading extends StatefulWidget {
	@override
	_LoadingState createState( ) => _LoadingState( );
}

class _LoadingState extends State<Loading> {

	@override
	void initState( ) {
		if ( Session( ).get( name: 'sessionLoaded' ) != true ) {
			this.loadData( );
		}
		super.initState( );
	}

	@override
	Widget build( BuildContext context ) {
		return Scaffold(
			body: Center(
				child: Image(
					image: AssetImage(
						'images/logo.png',
					),
					width: ( Session().getDouble(name: 'windowWidth') - 100 ).toDouble(),
				),
			),
		);
	}

	void loadData( ) async {
		var imagesPerRow = await Option( ).get( name: 'images_per_row', defaultValue: 3 );
		Session( ).set(
			name: 'imagePerRow',
			value: imagesPerRow
		);
		Session( ).set(
			name: 'homeImageSize',
			value: ((MediaQuery
				.of( context )
				.size
				.width * (1 / Session( ).get( name: 'imagePerRow', defaultValue: 3 ))) - (30 / imagesPerRow) - (imagesPerRow)).toDouble( )
		);
		Session( ).set(
			name: 'homeBigImageSize',
			value: ((MediaQuery
				.of( context )
				.size
				.width - Session( ).get( name: 'homeImageSize' )) - 30).toDouble( )
		);
		Session( ).set(
			name: 'windowWidth',
			value: MediaQuery
				.of( context )
				.size
				.width
				.toDouble( )
		);
		Session( ).set(
			name: 'windowHeight',
			value: MediaQuery
				.of( context )
				.size
				.height
				.toDouble( )
		);
		Session( ).increment( name: 'pageNumber' );

		///
		///
		/// get user data
		///
		///
		await this.authenticate( );

		///
		///
		/// get home images
		///
		///
		await InstaPic( ).getImages( context );

		await homeFirstSlider();

		await homeLatestPosts();

		Session( ).set(
			name: 'sessionLoaded',
			value: true
		);

		Navigator.pushNamedAndRemoveUntil( context, '/', ( route ) => false );
	}

	///
	///
	/// get user data
	///
	///
	authenticate( ) async {
		var currentUser = await Option( ).get( name: 'currentUser', defaultValue: false );
		Session( ).set( name: 'currentUser', value: currentUser );
	}

	homeFirstSlider( ) async {
		await http.get( 'http://aryanhemati.ir/api/test/', headers: {
			'Accept': 'application/json'
		} ).timeout( Duration( seconds: 20 ) )
			.then( ( http.Response response ) async {
			if ( response.statusCode == 200 ) {
				List homeFirstSliderItems = Session( ).get( name: 'homeFirstSliderItems', defaultValue: [] );
				Map _response = jsonDecode(response.body);

				if ( _response['data'].length > 0 ){
					int i = 1;
					for ( Map post in _response['data'] ){
						homeFirstSliderItems.add(homeFirstSliderCard(
							id: post['id'],
							imageLargeUrl: post['original'],
							title: post['title'],
							imageUrl: post['thumbnail'],
							isLast: i == _response['data'].length,
						));
						i++;
					}
					Session().set(
						name: 'homeFirstSliderItems',
						value: homeFirstSliderItems
					);
				}
			}
		} );
	}

	homeLatestPosts( ) async {
		return await homeLatestPostsCard().loadMore();
	}
}
