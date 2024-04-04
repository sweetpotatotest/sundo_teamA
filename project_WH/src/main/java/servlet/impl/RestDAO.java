package servlet.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("restDAO")
public class RestDAO extends EgovComAbstractDAO {
	
	@Autowired
	private SqlSessionTemplate session;

	public List<Map<String, Object>> sdSelect(String sd) {
		return session.selectList("rest.sdSelect", sd);
	}

	public List<Map<String, Object>> bjdList(String sgg_cd) {
		return session.selectList("rest.bjdList", sgg_cd);
	}

	public List<Map<String, Object>> bjdListSd(String sd) {
		return session.selectList("rest.bjdListSd", sd);
	}

	public Map<String, Object> getBjdGeometry(String bjd_cd) {
		return session.selectOne("rest.getBjdGeometry", bjd_cd);
	}

}
