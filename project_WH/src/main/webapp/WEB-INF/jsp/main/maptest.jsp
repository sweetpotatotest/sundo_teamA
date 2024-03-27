<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>브이월드 오픈API</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
<!-- OpenLayer -->
<script src="https://cdn.rawgit.com/openlayers/openlayers.github.io/master/en/v6.15.1/build/ol.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/ol@v6.15.1/ol.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
.map {
   height: 800px;
   width: 100%;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	zoomin = 8;
	
    let map = new ol.Map(
        { // OpenLayer의 맵 객체를 생성한다.
          target : 'map', // 맵 객체를 연결하기 위한 target으로 <div>의 id값을 지정해준다.
          layers : [ // 지도에서 사용 할 레이어의 목록을 정희하는 공간이다.
          new ol.layer.Tile(
              {
                source : new ol.source.OSM(
                    {
                     // url : 'http://api.vworld.kr/req/wmts/1.0.0/{key}/midnight/{z}/{y}/{x}.png'
                    url: 'https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png' // vworld의 지도를 가져온다.
                    })
              }) ],
          view : new ol.View({ // 지도가 보여 줄 중심좌표, 축소, 확대 등을 설정한다. 보통은 줌, 중심좌표를 설정하는 경우가 많다.
            center : ol.proj.fromLonLat([ 127.8, 36.2 ]),
            zoom : zoomin
          })
        });
    
    //? 왜 안되지 - 이름오류
    // 법정동 레이어
    var bjd = new ol.layer.Tile({
		source : new ol.source.TileWMS({
			url : 'http://localhost:8080/geoserver/project_sundo/wms', // 1. 레이어 URL
			params : {
				'VERSION' : '1.1.0', // 2. 버전
				'LAYERS' : 'project_sundo:tl_bjd', // 3. 작업공간:레이어 명
				'BBOX' : [1.3873946E7, 3906626.5, 1.4428045E7, 4670269.5], 
				'SRS' : 'EPSG:3857', // SRID
				'FORMAT' : 'image/png' // 포맷
			},
			serverType : 'geoserver',
		}),
		visible: false
	});
	
	map.addLayer(bjd); // 맵 객체에 레이어를 추가함
	
	//시도 레이어
    var sd = new ol.layer.Tile({
		source : new ol.source.TileWMS({
			url : 'http://localhost:8080/geoserver/project_sundo/wms', // 1. 레이어 URL
			params : {
				'VERSION' : '1.1.0', // 2. 버전
				'LAYERS' : 'project_sundo:tl_sd', // 3. 작업공간:레이어 명
				'BBOX' : [1.3871489341071218E7, 3910407.083927817, 1.4680011171788167E7, 4666488.829376997], 
				'SRS' : 'EPSG:3857', // SRID
				'FORMAT' : 'image/png' // 포맷
			},
			serverType : 'geoserver',
		}),
    	visible: false
	});
	
	//시군구 레이어
    var sgg = new ol.layer.Tile({
		source : new ol.source.TileWMS({
			url : 'http://localhost:8080/geoserver/project_sundo/wms', // 1. 레이어 URL
			params : {
				'VERSION' : '1.1.0', // 2. 버전
				'LAYERS' : 'project_sundo:tl_sgg', // 3. 작업공간:레이어 명
				'BBOX' : [1.386872E7, 3906626.5, 1.4428071E7, 4670269.5	], 
				'SRS' : 'EPSG:3857', // SRID
				'FORMAT' : 'image/png' // 포맷
			},
			serverType : 'geoserver',
		}),
    	visible: false
	});
	
	map.addLayer(sgg); // 맵 객체에 레이어를 추가함
	
	$('#sdSelect').change(function() {
	    var sdSelected = $(this).val();
	    $('#showSd').text("선택된 시도: " + sdSelected);
	    
	    // 시도 레이어 표시 여부를 결정합니다.
	    if (sdSelected != null) {
	        bjd.setVisible(false); // 서울특별시를 선택하면 시도 레이어를 보이도록 설정합니다.
	        sd.setVisible(false); // 다른 시도 레이어는 숨깁니다.
	        sgg.setVisible(true); // 다른 시도 레이어는 숨깁니다.
	    } else {
	    	 bjd.setVisible(false); // 시도를 선택하지 않으면 시도 레이어를 숨깁니다.
		     sd.setVisible(false); 
		}
	    
	    $.ajax({
	        url			: '/sdSelect.do', // 서버 URL 지정
	        type		: 'post', // HTTP 메서드 지정
	        dataType 	: 'json',
	        data		: {'sdSelect' : sdSelected}, // 전송할 데이터 설정
	        success		: function(data) {
	            console.log(data); // 데이터 확인
	            var sggSelect = $('#sggSelect');
	            sggSelect.empty(); // 시군구 선택 옵션 초기화
	            sggSelect.append("<option value='' selected disabled>시군구 선택</option>"); // 시도 변경 시 다시 기본값 설정
	            $('#bjdSelect').append("<option value='' selected disabled>법정동 선택</option>");
	            	
	            for (var i = 0; i < data.length; i++) {
	                  var option = $("<option>"+data[i].sgg_nm+"</option>");
	                  sggSelect.append(option);
	            };
	        },
	        error		: function(error) {
	            // 서버와의 통신 중 오류가 발생했을 때 실행되는 콜백 함수
	            console.log(error);
	            alert(error);
	        }
	    });
	});

	$('#sggSelect').change(function() {
		var sggSelected = $(this).val();
		var sdSelected = $('#sdSelect').val();
		$('#showSgg').text("선택된 시군구: " + sggSelected);
		
		$.ajax({
			url : '/sggSelect.do',
			type : 'post',
			datatype : 'json',
			data : {'sgg' : sggSelected, 'sd' : sdSelected},
			success : function(data) {
				console.log(data);
				var bjdSelect = $('#bjdSelect');
				bjdSelect.empty();
				bjdSelect.append("<option value='' selected disabled>법정동 선택</option>")
				
				for (var i = 0; i < data.length; i++) {
					var bjd = $("<option>"+data[i].bjd_nm+"</option>");
					bjdSelect.append(bjd);
				}
				
			},
			error : function(error) {
				console.log(error);
				alert(error);
			}
			
		});
	});
	
	$('#bjdSelect').change(function (){
		var bjdSelected = $(this).val();
		$('#showBjd').text("선택된 법정동: " + bjdSelected);
	});
	
	
});
</script>

</head>
<body>
	<div>
		<select id="sdSelect" name="sdSelect">
	    	<option>시도 선택</option>
		    <c:forEach items="${sdList }" var="sd">
		        <option value="${sd.sd_nm }">${sd.sd_nm }</option>
		    </c:forEach>
		</select>
		<select id="sggSelect" name="sggSelect">
    		<option>시군구 선택</option>
		</select>
		<select id="bjdSelect" name="bjdSelect">
			<option>법정동 선택</option>
		</select>
	</div>
	<div>
		<p id="showSd"></p>
		<p id="showSgg"></p>
		<p id="showBjd"></p>
	</div>
	<button onclick="location.href='/dataInput.do'">데이터 삽입</button>
	<button onclick="location.href='/main.do'">메인이동</button>
	<div id="map" class="map"></div>
</body>
</html>