import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zerostrix/Helpers/session.dart';
import 'package:http/http.dart' as http;


class homeFirstSliderCard extends StatelessWidget {

	String title;
	String imageUrl;
	int id;
	String imageLargeUrl;
	bool isLast;

	homeFirstSliderCard( {
		this.title,
		this.imageUrl,
		this.id,
		this.imageLargeUrl,
		this.isLast
	} );

	@override
	Widget build( BuildContext context ) {
		double boxWidth = (Session( ).getDouble( name: 'windowWidth' ) - 150).toDouble( );
		double leftPadding = this.isLast ? 20 : 0;
		return Padding(
			padding: const EdgeInsets.only( right: 20 ).add(EdgeInsets.only(left: leftPadding)),
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
				child: Container(
					child: ClipRRect(
						child: Stack(
							children: <Widget>[
								Container(
									child: CachedNetworkImage(
//									placeholder: kTransparentImage,
										imageUrl: imageUrl,
										fit: BoxFit.cover,
									),
									width: boxWidth,
									height: 300,
								),
								Align(
									alignment: Alignment.topLeft,
									child: Padding(
										padding: const EdgeInsets.all( 25.0 ),
										child: Row(
											children: <Widget>[
												Row(
													children: <Widget>[
														FaIcon(
															FontAwesomeIcons.heart,
															size: 15,
														),
														SizedBox(
															width: 5,
														),
														Padding(
															padding: const EdgeInsets.only( top: 5 ),
															child: Text(
																'1.3k',
																style: TextStyle( shadows: [
																	Shadow(
																		color: Colors.black,
																		blurRadius: 5,
																	)
																] ),
															),
														)
													],
													textDirection: TextDirection.ltr,
												),
											],
											mainAxisAlignment: MainAxisAlignment.end,
										),
									),
								),
								Align(
									child: ClipRRect(
										borderRadius: BorderRadius.only( topLeft: Radius.circular( 30 ), topRight: Radius.circular( 30 ) ),
										child: Stack(
											children: <Widget>[
												Container(
													width: boxWidth,
													height: 80,
												),
												Positioned(
													top: 1,
													child: BackdropFilter(
														filter: ImageFilter.blur( sigmaX: 0, sigmaY: 0 ),
														child: Container(
															width: boxWidth,
															height: 80,
															child: Padding(
																padding: const EdgeInsets.symmetric( vertical: 15, horizontal: 20 ),
																child: Row(
																	children: <Widget>[
																		Expanded(
																			child: Text(
																				title,
																				style: TextStyle(
																					fontSize: 15,
																					color: Colors.white
																				),
																				maxLines: 2,
																			),
																		)
																	],
																),
															),
															decoration: BoxDecoration(
																color: Colors.black.withOpacity( 0.6 ), borderRadius: BorderRadius.only( topLeft: Radius.circular( 30 ), topRight: Radius.circular( 30 ) )
															)
														)
													)
												)
											]
										)
									),
									alignment: Alignment.bottomCenter,
								),
							],
						),
						borderRadius: BorderRadius.all( Radius.circular( 30 ) ),
					),
					decoration: BoxDecoration(
						boxShadow: [
							BoxShadow(
								color: Colors.black.withOpacity( 0.5 ),
								blurRadius: 10,
								spreadRadius: 0,
							)
						],
						borderRadius: BorderRadius.all( Radius.circular( 30 ) ),
					),
					width: boxWidth,
				),
			),
		);
	}
}
