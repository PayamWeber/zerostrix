import 'package:shared_preferences/shared_preferences.dart';

class Option {

	dynamic get({ String name, defaultValue = '' }) async {
		dynamic finalValue;
		await this.getAsync(name)
			.timeout(Duration(seconds: 10))
			.then((value) {
			finalValue = value.runtimeType == Null ? defaultValue : value;
		}).catchError((context) {
			finalValue = defaultValue;
		});

		return finalValue;
	}

	dynamic getAsync(String name) async {
		SharedPreferences prefs = await SharedPreferences.getInstance().timeout(Duration(seconds: 5));
		prefs = prefs ?? null;
		return prefs.get(name);
	}

	update(name, value) async {
		SharedPreferences prefs = await SharedPreferences.getInstance().timeout(Duration(seconds: 5));
		prefs = prefs ?? null;

		switch (value.runtimeType) {
			case (String):
				return prefs.setString(name, value);
				break;
			case (int):
				return prefs.setInt(name, value);
				break;
			case (bool):
				return prefs.setBool(name, value);
				break;
			case (double):
				return prefs.setDouble(name, value);
				break;
		}
		return false;
	}
}
