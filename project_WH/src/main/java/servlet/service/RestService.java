package servlet.service;

import java.util.List;
import java.util.Map;

public interface RestService {

	List<Map<String, Object>> sdSelect(String sd);

	List<Map<String, Object>> bjdList(Map<String, String> param);

	List<Map<String, Object>> bjdListSd(String sd);

}
