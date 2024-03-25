package servlet.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import servlet.service.restService;

@Service("restService")
public class restImpl extends EgovAbstractServiceImpl implements restService{
	
	@Resource(name="restDAO")
	private restDAO dao;

	@Override
	public List<Map<String, Object>> sdSelect(String sd) {
		return dao.sdSelect(sd);
	}
	
}
