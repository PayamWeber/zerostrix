import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:zerostrix/Helpers/Helpers.dart';
import 'package:zerostrix/Helpers/Options.dart';
import 'package:zerostrix/Helpers/session.dart';
import 'package:zerostrix/Views/Home/loading.dart';
import 'package:http/http.dart' as http;

class InstaPic {

	int id;
	String title;
	String content;
	String img;
	String thumbnail;
	double width;
	double height;
	Function onTap;

	InstaPic( {
		this.id,
		this.title,
		this.content,
		this.onTap,
		this.img,
		this.height,
		this.width,
		this.thumbnail
	} );

	Future<Widget> createWidget( BuildContext context ) {
//		this.img = this.thumbnail = this.randomImages[rand(0, this.randomImages.length)];
		if ( this.width == null ) {
			this.width = Session( ).get( name: 'homeImageSize', defaultValue: 100.0 );
		}
		if ( this.height == null ) this.height = this.width;
		if ( this.onTap == null ) {
			this.onTap = ( ) {
				Session( ).set(
					name: 'currentInsta',
					value: {
						'id': this.id,
						'image': this.img,
						'thumbnail': this.thumbnail,
						'title': this.title,
					}
				);
				Navigator.pushNamed( Session( ).get( name: 'homeInstaContext', defaultValue: context ), '/instagram/show' );
			};
		}
//		return Container();
		return Future( ( ) async {
			return await DefaultCacheManager( ).getSingleFile( this.thumbnail ).then( ( value ) {
				return GestureDetector(
					child: Container(
						child: ClipRRect(
							borderRadius: BorderRadius.all( Radius.circular( 15 ) ),
							child: AnimatedContainer(
								child: CachedNetworkImage(
									imageUrl: this.thumbnail,
									fit: BoxFit.cover,
								),
								width: this.width,
								height: this.height,
								duration: Duration( milliseconds: 300 ),
							),
						),
						decoration: BoxDecoration(
							boxShadow: [
								BoxShadow(
									color: Colors.black.withOpacity( 0.3 ),
									blurRadius: 10,
									spreadRadius: 0,
								)
							],
							borderRadius: BorderRadius.all( Radius.circular( 15 ) ),
						),
					),
					onTap: this.onTap,
				);
			} );
		} );
	}

	getImages( BuildContext context ) async {
		int pageNumber = Session( ).get( name: 'pageNumber', defaultValue: 1 );
		return await http.get( 'http://aryanhemati.ir/api/test/?page_number=' + pageNumber.toString( ), headers: {
			'Accept': 'application/json'
		} ).timeout( Duration( seconds: 20 ) )
			.then( ( http.Response response ) async {
			if ( response.statusCode == 200 ) {
				dynamic _response = jsonDecode( response.body );

				if ( _response['status'] == true ) {
					List currentImages = Session( ).get( name: 'HomeImages', defaultValue: [] );
					int counter = 1;
					var imagePerRow = Session( ).get( name: 'imagePerRow' );
					var imagePerRefresh = (imagePerRow * 8) + (pageNumber.isEven ? imagePerRow : 0);
					int counterInit = pageNumber == 1 ? 1 : imagePerRefresh * (pageNumber - 1);
					List currentHelperImages = <Widget>[];
					List groupImages = [];

					if ( currentImages.length > 0 ) {
						currentImages.removeLast( );
					}

					if ( _response['data'].length > 0 ) {
						for ( Map _image in _response['data'] ) {
							if ( pageNumber.isEven && counter < imagePerRow ) {
								var widgetObject;
								double paddingBottom = currentHelperImages.length == 0 ? 10 : 0;
								widgetObject = Padding(
									padding: EdgeInsets.only( bottom: paddingBottom ),
									child: await InstaPic(
										title: _image['title'],
										img: _image['original'],
										thumbnail: _image['thumbnail'],
										height: Session( ).get( name: 'homeImageSize' ) - 2
									).createWidget( context ),
								);
								currentHelperImages.add( widgetObject );
								counter++;
								continue;
							}
							if ( counter >= counterInit + imagePerRefresh )
								break;

							Map<String, dynamic> isBig = {
								'isBig': pageNumber.isEven && counter == (imagePerRow),
								'helperImages': currentHelperImages
							};
							_image.addAll( isBig );

							var width = Session( ).get( name: _image['isBig'] == true ? 'homeBigImageSize' : 'homeImageSize', defaultValue: 100.0 );
							var height = width;
							var result;
							if ( _image['isBig'] == true ) {
								var bigRow = <Widget>[
									await InstaPic(
										img: _image['original'],
										thumbnail: _image['thumbnail'],
										width: width,
										height: height,
										title: _image['title'],
									).createWidget( context ),
								];
								var sideWidgets = Column(
									children: _image['helperImages'],
								);
								if ( Session( )
									.get( name: 'bigImageCounter', defaultValue: 1 )
									.isEven ) {
									bigRow.add( SizedBox( width: 0, height: 0 ) );
									bigRow.add( sideWidgets );
								} else {
									bigRow.insert( 0, SizedBox( width: 0, height: 0 ) );
									bigRow.insert( 0, sideWidgets );
								}
								Session( ).increment( name: 'bigImageCounter' );
//								result = Row(
//									children: bigRow,
//									mainAxisAlignment: MainAxisAlignment.spaceBetween,
//								);
								groupImages.add( bigRow );
							} else {
								result = await InstaPic(
									img: _image['original'],
									thumbnail: _image['thumbnail'],
									width: width,
									height: height,
									title: _image['title'],
								).createWidget( context );
								if ( groupImages.length > 0 && groupImages.last.length < 3 ) {
									groupImages.last.add( result );
								} else {
									groupImages.add( <Widget>[result] );
								}
							}

							counter++;
						}
					} else {
						Session( ).set( name: 'pageNumber', value: 1 );
						await getImages( context );
						return;
					}

					List _groupImages = <Widget>[];
					for ( List groupImage in groupImages ) {
						_groupImages.add( Padding(
							padding: EdgeInsets.only( top: 10 ),
							child: Row(
								children: groupImage,
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
							),
						) );
					}

					currentImages.addAll( _groupImages );

					Session( ).increment( name: 'pageNumber' );

					context.findAncestorStateOfType( ).setState( ( ) {
						Session( ).set(
							name: 'HomeImages',
							value: currentImages
						);
					} );
				}
			} else {

			}
		}, onError: ( object ) {

		} );
	}
}
