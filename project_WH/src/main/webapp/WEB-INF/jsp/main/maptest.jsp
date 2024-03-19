<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>브이월드 WMTS 배경지도 사용하기 오픈레이어스 3버전 이상</title>  
<script src="../js/ol.js"></script>
<link rel="stylesheet" 	href="../js/ol.css" type="text/css">
<!--
https://openlayers.org/en/v6.4.3/build/ol.js
https://openlayers.org/en/v5.3.0/build/ol.js
https://openlayers.org/en/v4.6.5/build/ol.js
https://openlayers.org/en/v3.20.1/build/ol.js

https://openlayers.org/en/v6.4.3/css/ol.css
https://openlayers.org/en/v5.3.0/css/ol.css
https://openlayers.org/en/v4.6.5/css/ol.css
https://openlayers.org/en/v3.20.1/css/ol.css
-->

<script src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
</head>

<body>
<div id="map" style="width: 100%; height: 350px; left: 0px; top: 0px"></div>


<script type="text/javascript">
	let Base = new ol.layer.Tile({
		name : "Base",
		source: new ol.source.XYZ({
			url: 'http://api.vworld.kr/req/wmts/1.0.0/CEB52025-E065-364C-9DBA-44880E3B02B8/Base/{z}/{y}/{x}.png'  // WMTS API 사용
		})
	});
    let OSM = new ol.layer.Tile({
		name : "Base",
		source: new ol.source.OSM()
	});

    // var debug = new ol.layer.Tile({ 
	// 	name : "debug",
	// 	source: new ol.source.TileDebug() //ol 6버전에 생김
    // }); // 타일의 넘버링을 확인할 수 있음 z: 레벨  / y 위 아래 , x 좌 우    /{z}7/{y}47/{x}111.png
    
  
    let olView = new ol.View({
        center: ol.proj.transform([127.100616,37.402142], 'EPSG:4326', 'EPSG:3857'),//좌표계 변환
        zoom: 10
    })// 뷰 설정
    let map = new ol.Map({ 
        layers: [OSM,Base], //[OSM,Base,debug] 
        target: 'map',
        view: olView
    });//
</script>
</body>
</html>