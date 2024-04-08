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
<script src="https://cdn.jsdelivr.net/npm/ol@v9.1.0/dist/ol.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/ol@v9.1.0/ol.css">
<!-- bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<style>
.map {
   height: 800px;
   width: 100%;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	var zoomin = 8;
	var khwBjdChoose = null;
	var bjdSelectedGeom = null;
	var sggSelectedGeom = null;
	
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
				'FORMAT' : 'image/png', // 포맷
				'CQL_FILTER' : "bjd_cd = '" + bjdSelectedGeom + "'" //원하는 레이어 필터걸기
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
				'FORMAT' : 'image/png', // 포맷
				'CQL_FILTER' : "sgg_cd = '" + sggSelectedGeom + "'" //원하는 레이어 필터걸기
			},
			serverType : 'geoserver',
		}),
    	visible: false
	});
	
	map.addLayer(sgg); // 맵 객체에 레이어를 추가함
	
	//전기사용량 레이어
	var kwh = new ol.layer.Tile({
		source : new ol.source.TileWMS({
			url : 'http://localhost:8080/geoserver/project_sundo/wms', // 1. 레이어 URL
			params : {
				'VERSION' : '1.1.0', // 2. 버전
				'LAYERS' : 'project_sundo:a1test_bjd', // 3. 작업공간:레이어 명
				'BBOX' : [1.3873946E7, 3906626.5, 1.4428045E7, 4670269.5], 
				'SRS' : 'EPSG:3857', // SRID
				'FORMAT' : 'image/png', // 포맷
				'CQL_FILTER' : "bjd_cd= '" + khwBjdChoose + "'" //원하는 레이어 필터걸기
			},
			serverType : 'geoserver',
		}),
    	visible: false
	});
	
	map.addLayer(kwh);
	
	$('#sdSelect').change(function() {
	    var sdSelected = $(this).val(); //이름값
	    $('#showSd').text("선택된 시도: " + sdSelected);
	    
	    // 시도 레이어 표시 여부를 결정합니다.
	    if (sdSelected != null) {
	        sd.setVisible(true); // 다른 시도 레이어는 숨깁니다.
	        sgg.setVisible(false); // 다른 시도 레이어는 숨깁니다.
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
					var sgg_nm = data[i].sgg_nm
					var sgg_cd = data[i].sgg_cd
					var option = $("<option value='" + sgg_cd + "'>" + sgg_nm + "</option>");
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
		var sggSelected = $(this).find('option:selected').text().trim();
		var sggSelectedCd = $(this).val();
		console.log(sggSelectedCd);
		var sdSelected = $('#sdSelect').val(); //이름값
		$('#showSgg').text("선택된 시군구: " + sggSelected);
		
		
		$.ajax({
			url : '/sggSelect.do',
			type : 'post',
			datatype : 'json',
			data : {'sgg' : sggSelected, 'sd' : sdSelected, 'sgg_cd' : sggSelectedCd},
			success : function(data) {
				
				var bjdSelect = $('#bjdSelect');
				bjdSelect.empty();
				bjdSelect.append("<option value='' selected disabled>법정동 선택</option>")
				
				for (var i = 0; i < data.length; i++) {
					var bjd_nm = data[i].bjd_nm
					var bjd_cd = data[i].bjd_cd
					var option = $("<option value='" + bjd_cd + "'>" + bjd_nm + "</option>");
					bjdSelect.append(option);
				}
				
		                updateLayerFilter(bjd, null);
				        bjd.setVisible(false);
		                sgg.setVisible(true);
		                
				$.ajax({
		            url: '/getSggGeometry.do', 
		            type: 'post',
		            dataType: 'json',
		            data: {'sgg_cd': sggSelectedCd},
		            success: function(data) {
		                var extent = [data.minx, data.miny, data.maxx, data.maxy]; // 좌표의 최소 및 최대값
		                var extentTransformed = ol.proj.transformExtent(extent, 'EPSG:3857', 'EPSG:3857'); // 좌표계 변환

		                map.getView().fit(extentTransformed, map.getSize()); // 해당 범위로 지도를 이동 및 확대/축소
		                
		                var cqlFilter = "sgg_cd= '" + sggSelectedCd + "'";
		                updateLayerFilter(sgg, cqlFilter); // 시군구 레이어 업데이트
		                
		            },
		            error: function(error) {
		                console.log(error);
		            }
		        });
				
				
			},
			error : function(error) {
				console.log(error);
				alert(error);
			}
			
		});
	});
	
	$('#bjdSelect').change(function (){
		var bjdSelectedCd = $(this).val();
		var bjdSelected = $(this).find('option:selected').text().trim();
		console.log(bjdSelectedCd);
		console.log(bjdSelected);
		$('#showBjd').text("선택된 법정동: " + bjdSelected);
		//해당 법정동의 레이어 띄우기
		var cqlFilter = "bjd_cd= '" + bjdSelectedCd + "'";
		updateLayerFilter(bjd, cqlFilter);
		updateLayerFilter(kwh, cqlFilter);
		
	        $.ajax({
	            url: '/getBjdGeometry.do', 
	            type: 'post',
	            dataType: 'json',
	            data: {'bjd_cd': bjdSelectedCd},
	            success: function(data) {
	                
	                // 가져온 법정동 좌표를 이용하여 해당 영역만 지도에 표시
	                var extent = [data.minx, data.miny, data.maxx, data.maxy]; // 좌표의 최소 및 최대값
	                var extentTransformed = ol.proj.transformExtent(extent, 'EPSG:3857', 'EPSG:3857'); // 좌표계 변환

	                map.getView().fit(extentTransformed, map.getSize()); // 해당 범위로 지도를 이동 및 확대/축소
	                
	                bjd.setVisible(true);
	                kwh.setVisible(true);
	            },
	            error: function(error) {
	                console.log(error);
	            }
	        });
		
	});
	
	//나중에 삭제할것(버튼클릭)
	$('#kwhuse').click(function (){
		 kwh.setVisible(true);
	});
	
	
	
	$('#chartModal').on('shown.bs.modal', function () {
	    // AJAX 요청 보내기
	    $.ajax({
	        url: '/charData.do', // 서버 URL 지정
	        type: 'get', // HTTP 메서드 지정
	        dataType: 'json',
	        success: function(data) {
	        	console.log(data);
	            // 데이터를 받아와 차트 그리기
	            drawChart(data);
	        },
	        error: function(error) {
	            console.log(error);
	            alert('데이터를 불러오는데 실패했습니다.');
	        }
	    });
	});
	
	$('#sdSelectChart').change(function (){
		var sdSelectedChar = $(this).val();
		
		$.ajax({
	        url: '/charDataSgg.do', // 서버 URL 지정
	        type: 'post', // HTTP 메서드 지정
	        dataType: 'json',
	        data: {'sd_nm': sdSelectedChar},
	        success: function(data) {
	        	console.log(data);
	            // 데이터를 받아와 차트 그리기
	        	drawChart(data);
	        },
	        error: function(error) {
	            console.log(error);
	            alert('데이터를 불러오는데 실패했습니다.');
	        }
		});
	});

	
});

//필터 설정값 변경(위에서 지정했기 때문에 수정하려면 별도의 함수가 필요함)
function updateLayerFilter(layer, cqlFilter) {
    var source = layer.getSource();
    
    if (cqlFilter) {
        if (source.updateParams) {
            source.updateParams({ 'CQL_FILTER': cqlFilter });
        } else {
            source.getParams()['CQL_FILTER'] = cqlFilter;
        }
    } else {
        // cqlFilter가 없는 경우에는 레이어의 파라미터에서 해당 필터를 제거
        if (source.updateParams) {
            source.updateParams({ 'CQL_FILTER': null });
        } else {
            delete source.getParams()['CQL_FILTER'];
        }
    }
}

//구글차트
google.charts.load('current', {'packages':['corechart']});

// Set a callback to run when the Google Visualization API is loaded.
google.charts.setOnLoadCallback(drawChart);

function drawChart(data) {

  var dataTable = new google.visualization.DataTable();
  dataTable.addColumn('string', '시도');
  dataTable.addColumn('number', '전기사용량(kwh)');
  
  for(var i = 0; i < data.length; i++){
	  dataTable.addRow([data[i].sd_nm, data[i].usekwh]);
  }

  // Set chart options
  var options = {'title':'전국 전기사용량',
                 'width':900,
                 'height':500};

  // Instantiate and draw our chart, passing in some options.
  var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
  chart.draw(dataTable, options);
}

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
	<button id="kwhuse">전기사용량</button>
	<button onclick="location.href='/dataInput.do'">데이터 삽입</button>
	<button onclick="location.href='/main.do'">메인이동</button>
	
	<!-- Button trigger modal -->
	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#chartModal">
	  Launch demo modal
	</button>
	
	<!-- Modal -->
	<div class="modal fade" id="chartModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered modal-xl">
	    <div class="modal-content">
	      <div class="modal-header">
	        <select class="form-select" aria-label="Default select example" id="sdSelectChart">
			  	<option>시도 선택</option>
		    		<c:forEach items="${sdList }" var="sd">
		        <option value="${sd.sd_nm }">${sd.sd_nm }</option>
		    </c:forEach>
			</select>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body" id="chart_div"></div>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	<div id="map" class="map"></div>
	
</body>
</html>