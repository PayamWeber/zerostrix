import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_shadow/icon_shadow.dart';
import 'package:zerostrix/Helpers/Helpers.dart';
import 'package:zerostrix/Helpers/session.dart';
import 'package:flutter/services.dart';

class InstaShow extends StatefulWidget {
	@override
	_InstaShowState createState( ) => _InstaShowState( );
}

class _InstaShowState extends State<InstaShow> {

	@override
	Widget build( BuildContext context ) {
		var currentImage = Session( ).get( name: 'currentInsta' );

		return Scaffold(
			body: Center(
				child: Stack(
//					fit: StackFit.expand,
					children: <Widget>[
						Container(
							child: CachedNetworkImage(
//							placeholder: 'images/loading.gif',
//							image: currentImage['image'],
								fit: BoxFit.cover,
								placeholder: ( context, str ) {
									return Center(
										child: CircularProgressIndicator( ),
									);
								},
								imageUrl: currentImage['image'],
							),
							height: 400,
							width: Session( ).getDouble( name: 'windowWidth' ),
						),
						ListView.builder(
							itemBuilder: ( context, index ) {
								if ( index == 0 ) {
									return Stack(
										children: <Widget>[
											SizedBox(
												height: 300,
											),
											Positioned(
												child: GestureDetector(
													child: IconShadowWidget(
														Icon( Icons.arrow_back_ios, color: Colors.white, ),
														shadowColor: Colors.black87,
													),
													onTap: (){
														Navigator.pop(context);
													},
												),
												top: 50,
												right: 30,
											),
										],
									);
								} else if ( index == 1 ) {
									return Container(
										decoration: BoxDecoration(
											color: Theme
												.of( context )
												.scaffoldBackgroundColor,
											borderRadius: BorderRadius.only(
												topLeft: Radius.circular( 50 ),
												topRight: Radius.circular( 50 )
											),
											boxShadow: [
												BoxShadow(
													color: Colors.black.withOpacity( 0.3 ),
													blurRadius: 10,
													spreadRadius: 0,
												)
											],
										),
										child: Column(
											children: <Widget>[
												Padding(
													padding: const EdgeInsets.only( left: 30, top: 20, right: 30 ),
													child: Row(
														children: <Widget>[
															Expanded(
																child: Text(
																	currentImage['title'],
																	style: TextStyle(
																		fontSize: 20,
																		fontWeight: FontWeight.bold,
																	),
																	maxLines: 3,
																	textAlign: TextAlign.justify,
																),
															)
														],
													),
												),
												Padding(
													padding: const EdgeInsets.symmetric( vertical: 10, horizontal: 30 ),
													child: Row(
														children: <Widget>[
															Padding(
																padding: EdgeInsets.only( left: 10 ),
																child: Container(
																	padding: EdgeInsets.symmetric( vertical: 5, horizontal: 10 ),
																	child: Text(
																		'بازی',
																		style: TextStyle(
																			fontSize: 12,
																			shadows: [
																				Shadow(
																					color: Colors.black,
																					blurRadius: 5
																				)
																			],
																			color: Colors.redAccent
																		),
																	),
																	decoration: BoxDecoration(
																		color: Colors.redAccent.withOpacity( 0.1 )
																	),
																),
															),
															Padding(
																padding: EdgeInsets.only( left: 10 ),
																child: Container(
																	padding: EdgeInsets.symmetric( vertical: 5, horizontal: 10 ),
																	child: Text(
																		'تکنولوژی',
																		style: TextStyle(
																			fontSize: 12,
																			shadows: [
																				Shadow(
																					color: Colors.black,
																					blurRadius: 5
																				)
																			],
																			color: Colors.blueAccent
																		),
																	),
																	decoration: BoxDecoration(
																		color: Colors.blueAccent.withOpacity( 0.1 )
																	),
																),
															),
															Padding(
																padding: EdgeInsets.only( left: 10 ),
																child: Container(
																	padding: EdgeInsets.symmetric( vertical: 5, horizontal: 10 ),
																	child: Text(
																		'سخت افزار',
																		style: TextStyle(
																			fontSize: 12,
																			shadows: [
																				Shadow(
																					color: Colors.black,
																					blurRadius: 5
																				)
																			],
																			color: Colors.yellow
																		),
																	),
																	decoration: BoxDecoration(
																		color: Colors.yellow.withOpacity( 0.1 )
																	),
																),
															),
														],
													),
												),
												Padding(
													padding: const EdgeInsets.symmetric( vertical: 5, horizontal: 30 ),
													child: Row(
														children: <Widget>[
															Row(
																children: <Widget>[
																	FaIcon(
																		FontAwesomeIcons.eye,
																		size: 15,
																		color: Colors.white60,
																	),
																	SizedBox( width: 5, ),
																	Text( '5.7 هزار', style: TextStyle( fontSize: 12, color: Colors.white60 ) )
																],
															),
															Row(
																children: <Widget>[
																	FaIcon(
																		FontAwesomeIcons.heart,
																		size: 15,
																		color: Colors.white60,
																	),
																	SizedBox( width: 5, ),
																	Padding(
																		padding: EdgeInsets.only( top: 3 ),
																		child: Text( '734', style: TextStyle( fontSize: 12, color: Colors.white60 ) ),
																	)
																],
															),
															Row(
																children: <Widget>[
																	FaIcon(
																		FontAwesomeIcons.calendarCheck,
																		size: 15,
																		color: Colors.white60,
																	),
																	SizedBox( width: 5, ),
																	Padding(
																		padding: EdgeInsets.only( top: 3 ),
																		child: Text( '1399/01/05', style: TextStyle( fontSize: 12, color: Colors.white60 ) ),
																	)
																],
															),
														],
														mainAxisAlignment: MainAxisAlignment.spaceBetween,
													)
												),
												Padding(
													padding: const EdgeInsets.symmetric( vertical: 10, horizontal: 30 ),
													child: Column(
														children: <Widget>[
															Text(
																'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد. کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد. در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها و شرایط سخت تایپ به پایان رسد وزمان مورد نیاز شامل حروفچینی دستاوردهای اصلی و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
																style: TextStyle(
																	color: Color.fromARGB(255, 182, 185, 198),
																	height: 2
																),
																textAlign: TextAlign.justify,
															),
															Text(
																'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد. کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد. در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها و شرایط سخت تایپ به پایان رسد وزمان مورد نیاز شامل حروفچینی دستاوردهای اصلی و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
																style: TextStyle(
																	color: Color.fromARGB(255, 182, 185, 198),
																	height: 2
																),
																textAlign: TextAlign.justify,
															)
														],
													)
												),
												Padding(
												  padding: const EdgeInsets.symmetric(vertical: 20),
												  child: roundedBigFlatButton(
												  	title: 'محل قرارگیری نظرات',
												  	onPressed: (){}
												  ),
												)
											],
										),
									);
								}
								return Container( );
							},
							itemCount: 2,
						),
					],
				),
			),
		);
	}
}
