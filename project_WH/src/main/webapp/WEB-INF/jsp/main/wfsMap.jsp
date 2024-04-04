<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WFS-T Background Map</title>
<script src="https://cdn.jsdelivr.net/npm/ol@v9.1.0/dist/ol.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/ol@v9.1.0/ol.css">

</head>
<body>
	<div id="map" style="width: 100%; height: 400px;"></div>

	<script>
		// OpenLayers 맵 객체 생성
		var map = new ol.Map({
			target : 'map',
			layers : [
			// OpenStreetMap 배경지도 레이어 추가
			new ol.layer.Tile({
				source : new ol.source.OSM()
			}) ],
			view : new ol.View({
				center : ol.proj.fromLonLat([ 127.0, 37.5 ]), // 중심 좌표 설정
				zoom : 8
			// 줌 레벨 설정
			})
		});

		// GeoServer의 WFS-T 서비스 URL
		var wfsUrl = 'http://localhost:8080/geoserver/project_sundo/wms';

		// WFS-T 피처 소스 생성
		var wfsSource = new ol.source.Vector(
				{
					format : new ol.format.GeoJSON(),
					url : function(extent) {
						return wfsUrl
								+ '?service=WFS&'
								+ 'version=1.1.0&request=GetFeature&typename=namespace:layername&'
								+ 'outputFormat=application/json&srsname=EPSG:3857&'
								+ 'bbox=' + extent.join(',') + ',EPSG:3857';
					},
					strategy : ol.loadingstrategy.bbox
				});

		// WFS-T 레이어 생성
		var wfsLayer = new ol.layer.Vector({
			source : wfsSource
		});

		// 맵에 WFS-T 레이어 추가
		map.addLayer(wfsLayer);
	</script>
</body>
</html>
