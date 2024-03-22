package servlet.service;

import java.util.List;
import java.util.Map;

public interface ServletService {
	String addStringTest(String str) throws Exception;

	List<Map<String, Object>> sggList();

	List<Map<String, Object>> sdList();

	List<Map<String, Object>> bjdList();
}
