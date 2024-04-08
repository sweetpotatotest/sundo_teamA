package servlet.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import servlet.service.RestService;

@RestController
public class AjaxRestController {
 
	@Resource(name = "restService")
	private RestService restService;
	
	@PostMapping("/sdSelect.do")
	public List<Map<String, Object>> sdSelect(@RequestParam("sdSelect") String sd) {
		//System.err.println(sd);
		List<Map<String, Object>> sggList = restService.sdSelect(sd);
		//System.err.println(sggList);
		//return sggList;
		return sggList;
	}
	
	@PostMapping("/sggSelect.do")
	public List<Map<String, Object>> sggSelect(@RequestParam("sgg") String sgg, @RequestParam("sd") String sd, @RequestParam("sgg_cd") String sgg_cd) {
		//System.err.println(sgg);
		//System.err.println(sd);
		
		List<Map<String, Object>> bjdList = null;
		if (sgg == null || sgg == "") {
			//sd가 세종특별자치시일 경우(시군구가 없음)
			//이름으로 리스트 부르기
			bjdList = restService.bjdListSd(sd);
		} else {
			//2개 값 묶어서 가져가기 시군구 이름으로 부르기	
			//Map<String, String> param = new HashMap<>();
			//param.put("sgg", sgg);
			//param.put("sd", sd);
			
			//코드로만?
			bjdList = restService.bjdList(sgg_cd);
		}
		//System.err.println(bjdList);
		return bjdList;
	}
	
	@PostMapping("/getBjdGeometry.do")
	public Map<String, Object> getBjdGeometry(@RequestParam("bjd_cd") String bjd_cd){
		Map<String, Object> bjdGeometry = restService.getBjdGeometry(bjd_cd);
		return bjdGeometry;
	}
	
	@PostMapping("/getSggGeometry.do")
	public Map<String, Object> getSggGeometry(@RequestParam("sgg_cd") String sgg_cd){
		Map<String, Object> sggGeometry = restService.getSggGeometry(sgg_cd);
		System.err.println(sggGeometry);
		return sggGeometry;
	}
	
	@GetMapping("/charData.do")
	public List<Map<String, Object>> charData(){
		List<Map<String, Object>> charData = restService.charData();
		return charData;
	}
	
	@PostMapping("/charDataSgg.do")
	public List<Map<String, Object>> charDataSgg(@RequestParam("sd_nm") String sd_nm){
		List<Map<String, Object>> charDataSgg = restService.charDataSgg(sd_nm);
		return charDataSgg;
	}
	
	
}