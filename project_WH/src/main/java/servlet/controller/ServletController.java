package servlet.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import servlet.service.ServletService;

@Controller
public class ServletController {
	@Resource(name = "ServletService")
	private ServletService servletService;
	
	@RequestMapping(value = "/main.do")
	public String mainTest(ModelMap model) throws Exception {
		System.out.println("sevController.java - mainTest()");
		
		String str = servletService.addStringTest("START! ");
		model.addAttribute("resultStr", str);
		
		return "main/main";
	}
	
	@RequestMapping(value = "/mapTest.do", method = RequestMethod.GET )
	public String mapTest(Model model) {
		List<Map<String, Object>> list = servletService.sggList();
		List<Map<String, Object>> list2 = servletService.sdList();
		List<Map<String, Object>> list3 = servletService.bjdList();
		model.addAttribute("sggList", list);
		model.addAttribute("sdList", list2);
		model.addAttribute("bjdList", list3);
		return "main/maptest";
	}
	
	@RequestMapping("/wfsMap.do")
	public String wfsMap() {
		return "main/wfsMap";
	}
	
}
