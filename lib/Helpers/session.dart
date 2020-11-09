///
///
///
/// Session class for global variables and values
///
///
///
class Session {
	static final Session _singleton = Session._internal();

	factory Session() {
		return _singleton;
	}

	Session._internal();

	int imagesPerColumn = 3;
	bool sessionLoaded = false;
	Map<String, dynamic> values = {};

	///
	/// get the session variable
	///
	get({String name, dynamic defaultValue = ''}) {
		return Session().values[name].runtimeType == Null ? defaultValue : Session().values[name];
	}

	///
	/// get the session variable
	///
	getInt({String name, dynamic defaultValue = 1}) {
		return Session().get(name: name, defaultValue: defaultValue).toInt();
	}

	///
	/// get the session variable
	///
	getString({String name, dynamic defaultValue = ''}) {
		return Session().get(name: name, defaultValue: defaultValue).toString();
	}

	///
	/// get the session variable
	///
	getDouble({String name, dynamic defaultValue = 0.0}) {
		return Session().get(name: name, defaultValue: defaultValue).toDouble();
	}

	///
	/// set the session variable value
	///
	set({String name, dynamic value = ''}) {
		if (Session().values.containsKey(name)) {
			Session().values.update(name, (previousValue) {
				return value;
			});
		} else {
			Session().values.addEntries([
				MapEntry(name, value)
			]);
		}
	}

	///
	/// increment a variable integer value
	///
	increment({String name, int value = 1}) {
		this.set(
			name: name,
			value: this.get(name: name, defaultValue: 0) + value
		);
	}

	///
	/// decrement a variable integer value
	///
	decrement({String name, int value = 1}) {
		this.set(
			name: name,
			value: this.get(name: name, defaultValue: 1) - value
		);
	}
}
