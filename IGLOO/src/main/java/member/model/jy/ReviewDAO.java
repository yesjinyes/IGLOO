package member.model.jy;

import java.util.List;

import member.domain.ReviewVO;

public interface ReviewDAO {

	
	//주문내역 조회해오기
	List<ReviewVO> reviewlist(String userid) throws Exception;

}
