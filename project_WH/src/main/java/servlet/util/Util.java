package servlet.util;

import org.springframework.stereotype.Component;

@Component
public class Util {
	public int str2Int(String str) {
		try {
			return Integer.parseInt(str.trim());
		} catch (Exception e) {
			return 0;
		}
	}
}
