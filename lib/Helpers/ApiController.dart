import 'package:http/http.dart' as http;
import 'package:zerostrix/Helpers/session.dart';

class ApiController{
	static const String baseUrl = 'http://zerostrix.ir/api/v1/';

	get( String url, Map body, Map headers ){
		String queryString = '';

		if ( body.length > 0 ){
			int counter = 1;
			body.forEach((key, value) {
				queryString += '$key=$value';

				if ( counter != body.length ){
					queryString += '&';
				}
				counter++;
			});
		}

		if ( queryString.length > 0 ){
			queryString = '?' + queryString;
		}
		return http.get(url + queryString, headers: headers);
	}

	post( String url, Map body, Map headers ){
		return http.post(
			url,
			headers: headers,
			body: body,
		);
	}

	postAuthenticated( String url, Map body ){
		return http.post(
			url,
			headers: {
				'Accept': 'application/json',
				'Authorization': Session().get(name: "sadfasdf")
			},
			body: body,
		);
	}
}