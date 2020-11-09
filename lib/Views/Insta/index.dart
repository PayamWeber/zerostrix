import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:zerostrix/Helpers/session.dart';
import 'package:zerostrix/Models/InstaPic.dart';

class InstaIndex extends StatefulWidget {
	@override
	_InstaIndexState createState( ) => _InstaIndexState( );
}

class _InstaIndexState extends State<InstaIndex> {
	final ScrollController scrollController = ScrollController( );
	bool isLoadingImages = false;

	@override
	void initState( ) {
		scrollController.addListener( ( ) {
			if ( scrollController.offset >= scrollController.position.maxScrollExtent - 300 && !scrollController.position.outOfRange && !this.isLoadingImages ) {
				this.isLoadingImages = true;
				setState( ( ) {
					List images = Session( ).get( name: 'HomeImages' );
					images.add( Center(
						child: Padding(
							padding: EdgeInsets.only( top: 50, bottom: 150 ),
							child: CircularProgressIndicator( ),
						),
					) );
					Session( ).set( name: 'HomeImages', value: images );
				} );
				return InstaPic( ).getImages( context ).then( ( value ) {
					setState( ( ) {
						this.isLoadingImages = false;
					} );
				} );
			}
		} );
		super.initState( );
	}

	@override
	Widget build( BuildContext context ) {
		Session( ).set( name: 'homeInstaContext', value: context );
		return SafeArea(
			child: Padding(
				padding: const EdgeInsets.all( 10 ).add( EdgeInsets.only( top: -10 ) ),
				child: RefreshIndicator(
					onRefresh: ( ) {
						Session( ).set( name: 'HomeImages', value: <Widget>[] );
						Session( ).set( name: 'pageNumber', value: 1 );
						return InstaPic( ).getImages( context ).then( ( value ) {
							setState( ( ) {} );
						} );
					},
					child: ListView.builder(
						physics: AlwaysScrollableScrollPhysics( ),
						itemBuilder: ( context, i ) {
							return Session( ).get( name: 'HomeImages', defaultValue: [] )[i];
						},
						itemCount: Session( )
							.get( name: 'HomeImages', defaultValue: [] )
							.length,
						controller: this.scrollController,
						padding: EdgeInsets.only( bottom: 5 ),
					),
					/*child: GridView.builder(
		  			gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
		  				crossAxisCount: Session().get(name: 'imagePerRow'),
		  				mainAxisSpacing: 2,
		  				crossAxisSpacing: 2
		  			),
		  			itemBuilder: (context, i) {
		  				return Session().get(name: 'HomeImages', defaultValue: <Widget>[])[i];
		  			},
		  			itemCount: Session()
		  				.get(name: 'HomeImages', defaultValue: <Widget>[])
		  				.length,
		  			controller: this.scrollController,
		  		),*/
				),
			),
		);
	}
}
