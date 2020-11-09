import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zerostrix/Helpers/session.dart';
import 'package:http/http.dart' as http;


class homeLatestPostsCard extends StatelessWidget {

	String title;
	String imageUrl;
	int id;
	String imageLargeUrl;

	homeLatestPostsCard( {
		this.title,
		this.imageUrl,
		this.id,
		this.imageLargeUrl
	} );

	@override
	Widget build( BuildContext context ) {
		double boxWidth = (Session( ).getDouble( name: 'windowWidth' ) - 40).toDouble( );
		return Padding(
			padding: const EdgeInsets.only( right: 20, left: 20, bottom: 35 ),
			child: GestureDetector(
				onTap: ( ) {
					Session( ).set(
						name: 'currentInsta',
						value: {
							'id': id,
							'image': imageLargeUrl,
							'thumbnail': imageUrl,
							'title': title,
						}
					);
					Navigator.pushNamed( Session( ).get( name: 'homeSlideContext', defaultValue: context ), '/instagram/show' );
				},
				child: Column(
					children: <Widget>[
						Container(
							child: ClipRRect(
								child: Column(
									children: <Widget>[
										Container(
											height: 200,
											child: Stack(
												children: <Widget>[
													Container(
														child: CachedNetworkImage(
//														placeholder: kTransparentImage,
															imageUrl: imageUrl,
															fit: BoxFit.cover,
														),
														width: boxWidth,
														height: 200,
													),
												],
											),
										),
									],
								),
								borderRadius: BorderRadius.all( Radius.circular( 30 ) ),
							),
							decoration: BoxDecoration(
								boxShadow: [
									BoxShadow(
										color: Colors.black.withOpacity( 0.2 ),
										blurRadius: 10,
										spreadRadius: 0,
									)
								],
								borderRadius: BorderRadius.all( Radius.circular( 30 ) ),
							),
							width: boxWidth,
						),
						Container(
							width: boxWidth,
//								height: 80,
							child: Padding(
								padding: const EdgeInsets.only(top: 10),
								child: Row(
									children: <Widget>[
										Expanded(
											child: Text(
												title,
												style: TextStyle(
													fontSize: 15,
												),
												maxLines: 2,
											),
										)
									],
								),
							)
						)
					],
				),
			),
		);
	}

	loadMore() async{
		return await http.get( 'http://aryanhemati.ir/api/test/', headers: {
			'Accept': 'application/json'
		} ).timeout( Duration( seconds: 20 ) )
			.then( ( http.Response response ) async {
			if ( response.statusCode == 200 ) {
				List homeLatestPosts = Session( ).get( name: 'homeLatestPosts', defaultValue: [] );
				Map _response = jsonDecode(response.body);

				if ( homeLatestPosts.length > 0 ){
					homeLatestPosts.removeLast();
				}

				if ( _response['data'].length > 0 ){
					for ( Map post in _response['data'] ){
						homeLatestPosts.add(homeLatestPostsCard(
							id: post['id'],
							imageLargeUrl: post['original'],
							title: post['title'],
							imageUrl: post['thumbnail']
						));
					}
					Session().set(
						name: 'homeLatestPosts',
						value: homeLatestPosts
					);
				}
			}
		} );
	}
}
