package servlet.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import servlet.service.restService;

@Controller
public class AjaxRestController {
 
	@Resource(name = "restService")
	private restService restService;
	
	@RequestMapping(value = "/sdSelect.do", method = RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> sdSelect(@RequestParam("sdSelect") String sd) {
		System.err.println(sd);
		List<Map<String, Object>> sggList = restService.sdSelect(sd);
		System.err.println(sggList);
		//return sggList;
		return sggList;
	}
	
}