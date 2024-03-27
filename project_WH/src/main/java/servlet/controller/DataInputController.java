package servlet.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import servlet.service.ServletService;
import servlet.util.Util;

@Controller
public class DataInputController {
	
	@Autowired
	private Util util;
	
	@Resource(name="ServletService")
	private ServletService servletService;
	

	@GetMapping("/dataInput.do")
	public String dataInput() {
		return "main/dataInput";
	}
	
	//데이터 받아서 
	@PostMapping("/dataInputSql.do")
	public String dataInput(@RequestParam("file") MultipartFile upFile) throws IOException {
		System.err.println(upFile.getOriginalFilename());
		System.err.println(upFile.getSize());
		List<Map<String, Object>> list = new ArrayList<>();
		InputStreamReader isr = new InputStreamReader(upFile.getInputStream());
		BufferedReader br = new BufferedReader(isr);
		String line = null;
		while((line = br.readLine()) != null) {
			Map<String, Object> m = new HashMap<>();
			String[] lineArr = line.split("\\|");
			m.put("useym", lineArr[0]); // 사용_년월 
			m.put("location", lineArr[1]); // 대지_위치 
			m.put("adlocation", lineArr[2]); // 도로명_대지_위치 
			m.put("sgg_cd", lineArr[3]); // 시군구_코드 
			m.put("bjd_cd", lineArr[4]); // 법정동_코드 
			m.put("loc_cd", lineArr[5]); // 대지_구분_코드 
			m.put("bun", lineArr[6]); // 번 
			m.put("ji", lineArr[7]); // 지 
			m.put("newad", lineArr[8]); // 새주소_일련번호 
			m.put("newad_cd", lineArr[9]); // 새주소_도로_코드 
			m.put("newad_under_cd", lineArr[10]);// 새주소_지상지하_코드
			m.put("newad_main", util.str2Int(lineArr[11])); // 새주소_본_번 
			m.put("newad_sub", util.str2Int(lineArr[12])); // 새주소_부_번 
			m.put("usekwh", util.str2Int(lineArr[13])); // 사용_량(KWh) 
			list.add(m);
		}
		System.out.println("종료 : " + list);
		servletService.dataInput(list);
		br.close();
		isr.close();
		
		return "1";
	}
}
