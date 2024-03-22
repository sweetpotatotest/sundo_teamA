package servlet.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository("ServletDAO")
public class ServletDAO extends EgovComAbstractDAO {
	
	@Autowired
	private SqlSessionTemplate session;
	
	public List<EgovMap> selectAll() {
		return selectList("servlet.serVletTest");
	}

	public List<Map<String, Object>> sggList() {
		return selectList("servlet.sggList");
	}

	public List<Map<String, Object>> sdList() {
		return selectList("servlet.sdList");
	}

	public List<Map<String, Object>> bjdList() {
		return selectList("servlet.bjdList");
	}

}
