package servlet.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import servlet.service.RestService;

@Service("restService")
public class RestImpl extends EgovAbstractServiceImpl implements RestService{
	
	@Resource(name="restDAO")
	private RestDAO dao;

	@Override
	public List<Map<String, Object>> sdSelect(String sd) {
		return dao.sdSelect(sd);
	}

	@Override
	public List<Map<String, Object>> bjdList(String sgg_cd) {
		return dao.bjdList(sgg_cd);
	}

	@Override
	public List<Map<String, Object>> bjdListSd(String sd) {
		return dao.bjdListSd(sd);
	}

	@Override
	public Map<String, Object> getBjdGeometry(String bjd_cd) {
		return dao.getBjdGeometry(bjd_cd);
	}

	/*
	 * @Override public Geometry getBjdGeom(String bjd_cd) { return
	 * dao.getBjdGeom(bjd_cd); }
	 */
	
}
