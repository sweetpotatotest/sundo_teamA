<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script type="text/javascript" src="<c:url value='/js/ol.js' />"></script> <!-- OpenLayer 라이브러리 -->
<link href="<c:url value='/'/>css/ol.css" rel="stylesheet" type="text/css" > <!-- OpenLayer css -->
<script type="text/javascript" src="<c:url value='/js/mapTest.js' />"></script> <!-- 지도 맵객체 생성을 위한 js-->
<!-- 지도 크기 설정을 위한 css -->
<style>
    .map {
      height: 1060px;
      width: 100%;
    }
  </style>
</head>
<body>
<h1>레이어 이동</h1>
<div id="map" class="map">
	<!-- 실제 지도가 표출 될 영역 -->
</div>
</body>
<script type="text/javascript">
$( document ).ready(function() {
	let map = new ol.Map({ // OpenLayer의 맵 객체를 생성한다.
	    target: 'map', // 맵 객체를 연결하기 위한 target으로 <div>의 id값을 지정해준다.
	    layers: [ // 지도에서 사용 할 레이어의 목록을 정희하는 공간이다.
	      new ol.layer.Tile({
	        source: new ol.source.OSM({
	          url: "https://api.vworld.kr/req/wmts/1.0.0/A7310A01-5C02-3811-B583-DE851FC4C4C3/Base/11/793/1746.png" // vworld의 지도를 가져온다.
	        })
	      })
	    ],
	    view: new ol.View({ // 지도가 보여 줄 중심좌표, 축소, 확대 등을 설정한다. 보통은 줌, 중심좌표를 설정하는 경우가 많다.
	      center: ol.proj.fromLonLat([128.4, 35.7]),
	      zoom: 7
	    })
	});
});
</script>
</html>