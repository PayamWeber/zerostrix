import 'package:flutter/material.dart';
import 'package:zerostrix/Helpers/Options.dart';
import 'package:zerostrix/Helpers/session.dart';
import 'package:zerostrix/Models/InstaPic.dart';
import 'package:zerostrix/Views/Home/index.dart';

class Settings extends StatefulWidget {
	@override
	_SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
	List imagesPerColumn = [2, 3, 4, 5];

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Settings'),
			),
			body: Padding(
				padding: EdgeInsets.all(30),
				child: Column(
					children: <Widget>[
						Text(
							'General',
							style: TextStyle(
								fontSize: 30, fontWeight: FontWeight.w600),
						),
						Divider(
							height: 20,
							color: Colors.deepPurpleAccent,
						),
						Row(
							children: <Widget>[
								Wrap(
									children: <Widget>[
										Icon(
											Icons.apps,
											color: Colors.deepPurpleAccent,
										),
										Text(
											'Image per row: ',
											style: TextStyle(fontSize: 15),
										)
									],
									spacing: 5,
									crossAxisAlignment: WrapCrossAlignment
										.center,
								),
								PopupMenuButton(
									itemBuilder: (context) {
										return this.imagesPerColumn.map((value) {
											return PopupMenuItem(
												child: MaterialButton(
													child: Text(value.toString()),
												),
												value: value,
											);
										}).toList();
									},
									child: FlatButton(
										child: Text(Session().get(name: 'imagePerRow', defaultValue: 'Select').toString()),
									),
									onSelected: (value) {
										setState(() {
											Option().update('images_per_row', value);
											Session().set(
												name: 'imagePerRow',
												value: value
											);

											Session().set(
												name: 'homeImageSize',
												value: (MediaQuery
													.of(context)
													.size
													.width * (1 / value)) - (8 / value) - (value)
											);
											Session().set(
												name: 'homeBigImageSize',
												value: (MediaQuery
													.of(context)
													.size
													.width - Session().get(name: 'homeImageSize')) - (7) - (value * 2)
											);
										});
//										Session().get(name: 'homeContext', defaultValue: context).findAncestorStateOfType().initState();
									},
									key: Key('images_per_column'),
								)
							],
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
						)
					],
				),
			),
		);
	}
}
