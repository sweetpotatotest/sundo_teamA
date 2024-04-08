package servlet.service;

import java.util.List;
import java.util.Map;

public interface RestService {

	List<Map<String, Object>> sdSelect(String sd);

	List<Map<String, Object>> bjdList(String sgg_cd);

	List<Map<String, Object>> bjdListSd(String sd);

	Map<String, Object> getBjdGeometry(String bjd_cd);
	
	Map<String, Object> getSggGeometry(String sgg_cd);

	List<Map<String, Object>> charData();

	List<Map<String, Object>> charDataSgg(String sd_nm);

}
