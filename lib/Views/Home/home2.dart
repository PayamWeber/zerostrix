import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zerostrix/Helpers/session.dart';

class LandingPage extends StatefulWidget {
	@override
	_LandingPageState createState( ) => _LandingPageState( );
}

class _LandingPageState extends State<LandingPage> {
	final ScrollController scrollController = ScrollController( );
	bool isLoadingImages = false;

	@override
	void initState( ) {
		scrollController.addListener( ( ) {
			if ( scrollController.offset >= scrollController.position.maxScrollExtent - 300 && !scrollController.position.outOfRange && !this.isLoadingImages ) {
				this.isLoadingImages = true;
				setState( ( ) {
					List posts = Session( ).get( name: 'homeLatestPosts' );
					posts.add( Center(
						child: Padding(
							padding: EdgeInsets.only( top: 50, bottom: 150 ),
							child: CircularProgressIndicator( ),
						),
					) );
					Session( ).set( name: 'homeLatestPosts', value: posts );
				} );
//				return InstaPic( ).getImages( context ).then( ( value ) {
//					setState( ( ) {
//						this.isLoadingImages = false;
//					} );
//				} );
			}
		} );
		super.initState( );
	}

	@override
	Widget build( BuildContext context ) {
		Session( ).set(
			name: 'homeSlideContext',
			value: context
		);
		return SafeArea(
			child: ListView.builder(
				controller: scrollController,
				physics: AlwaysScrollableScrollPhysics( ),
				itemBuilder: ( c, i ) {
					if ( i == 0 ){
						return Padding(
							padding: const EdgeInsets.only( top: 30, right: 20, left: 20 ),
							child: Row(
								children: <Widget>[
									Text(
										'سلام رضا عزیز',
										style: TextStyle( fontSize: 30 ),
									),
									FloatingActionButton(
										child: FaIcon(
											FontAwesomeIcons.search,
											color: Theme
												.of( context )
												.scaffoldBackgroundColor,
										),
										mini: true,
									)
								],
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
							),
						);
					}else if( i == 1 ){
						return Padding(
							padding: const EdgeInsets.symmetric( vertical: 20 ),
							child: Container(
								height: 300.0,
								child: ListView.builder(
									physics: AlwaysScrollableScrollPhysics( ),
									scrollDirection: Axis.horizontal,
									itemCount: Session( ).get( name: 'homeFirstSliderItems', defaultValue: [] ).length,
									padding: EdgeInsets.symmetric( vertical: 20 ),
									itemBuilder: ( BuildContext context, int index ) {
										List items = Session( ).get( name: 'homeFirstSliderItems', defaultValue: [] );
										return items.length > 0 ? items[index] : SizedBox( width: 0, );
									},
								),
							),
						);
					}else if( i >= 2 ){
						List items = Session( ).get( name: 'homeLatestPosts', defaultValue: [] );
						return items.length > 0 ? items[i-2] : SizedBox( width: 0, );
					}
					return Container();
				},
				itemCount: Session( ).get( name: 'homeLatestPosts', defaultValue: [] ).length + 2,
			),
		);
	}
}
