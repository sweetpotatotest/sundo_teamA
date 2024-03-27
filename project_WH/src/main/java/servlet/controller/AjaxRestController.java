package servlet.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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
	public List<Map<String, Object>> sggSelect(@RequestParam("sgg") String sgg, @RequestParam("sd") String sd) {
		System.err.println(sgg);
		System.err.println(sd);
		
		List<Map<String, Object>> bjdList = null;
		if (sgg == null || sgg == "") {
			//sd가 세종특별자치시일 경우(시군구가 없음)
			bjdList = restService.bjdListSd(sd);
		} else {
			//2개 값 묶어서 가져가기
			Map<String, String> param = new HashMap<>();
			param.put("sgg", sgg);
			param.put("sd", sd);
			
			bjdList = restService.bjdList(param);
		}
		System.err.println(bjdList);
		return bjdList;
	}
	
}