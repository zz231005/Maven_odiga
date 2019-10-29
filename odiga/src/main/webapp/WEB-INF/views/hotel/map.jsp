 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<?
	$address1      =   $_REQUEST["address"];
	$arr_address   =   explode("(",$address1);
	$address      =   $arr_address[0];
?>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDeRdmqoCvaWqdmH4aIzsgs6Pp6CIO6hZ0&callback=initialize"></script>

<style>
html, body, #map-canvas {
	height: 100%;
	margin: 0px;
	padding: 0px
}

#panel1 {
	position: absolute;
	top: 5px;
	left: 54%;
	margin-left: -180px;
	z-index: 5;
	background-color: #fff;
	padding: 5px;
	border: 1px solid blue;
}

#panel2 {
	position: absolute;
	top: 45px;
	left: 40%;
	margin-left: -180px;
	z-index: 5;
	background-color: #fff;
	padding: 5px;
	border: 1px solid blue;
}
</style>
<script>
	var map;

	function initialize() {
		var mapOptions = {
			zoom : 19,
			/*center : new google.maps.LatLng(37.5651, 126.98955), //서울
			mapTypeId : google.maps.MapTypeId.ROADMAP*/
		};

		map = new google.maps.Map(document.getElementById('map-canvas'),
				mapOptions);
		codeAddress();
	}
	google.maps.event.addDomListener(window, 'load', initialize);
	var geocoder;
	function codeAddress() {
		geocoder = new google.maps.Geocoder();
		var address = document.getElementById('address').value;
		/* alert(address) */
		geocoder.geocode({
			'address' : address
		}, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				var lat = results[0]['geometry']['location']['lat']();
				var lng = results[0]['geometry']['location']['lng']();
				$("#lat").val(lat)
				$("#lng").val(lng)
				map.setCenter(results[0].geometry.location);
				var marker = new google.maps.Marker({
					map : map,
					position : results[0].geometry.location,
					draggable : false,
					animation : google.maps.Animation.DROP,
					title : address
				});

			} else {
				alert('주소를 찾을 수 없습니다. ');
			}
		});
	}
</script>
	<input type = "hidden" id = "address" value = "${hotel.roadaddrpart1}">
	<div id="map-canvas"></div>
