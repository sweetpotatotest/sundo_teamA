package servlet.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class DataInputController {

	@GetMapping("/dataInput.do")
	public String dataInput() {
		return "main/dataInput";
	}
	
	@PostMapping("/dataInput.do")
	public String dataInput(@RequestParam("file") MultipartFile upFile) {
		System.err.println(upFile.getOriginalFilename());
		System.err.println(upFile.getSize());
		return "dataInput";
	}
}
