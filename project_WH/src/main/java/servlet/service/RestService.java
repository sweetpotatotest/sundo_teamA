package servlet.service;

import java.util.List;
import java.util.Map;

import org.locationtech.jts.geom.Geometry;

public interface RestService {

	List<Map<String, Object>> sdSelect(String sd);

	List<Map<String, Object>> bjdList(String sgg_cd);

	List<Map<String, Object>> bjdListSd(String sd);

	Map<String, Object> getBjdGeometry(String bjd_cd);

	//Geometry getBjdGeom(String bjd_cd);

}
