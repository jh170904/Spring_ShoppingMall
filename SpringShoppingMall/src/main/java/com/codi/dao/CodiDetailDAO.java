package com.codi.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.CommunityDTO;
import com.codi.dto.MemberDTO;
import com.codi.dto.ProductDetailDTO;
import com.codi.dto.ReplyDTO;

@Component("codiDetailDAO")
public class CodiDetailDAO {
	@Autowired
	private SqlSessionTemplate sessionTemplate;

	//커뮤니티 게시글 조회
	public CommunityDTO getReadCodiData(int iNum){
		return sessionTemplate.selectOne("codiDetailMapper.getOneInstar", iNum);	
	}
	
	//조회수 증가
	public void updateHitCount(int iNum) {
		sessionTemplate.update("codiDetailMapper.updateHitCount", iNum);
	}
	
	//동일id 게시글 조회
	public List<CommunityDTO> getReadCodiData(String userId, int iNum){
		HashMap<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("userId", userId);
		hMap.put("iNum", iNum);
		return sessionTemplate.selectList("codiDetailMapper.getReadCodiLists", hMap);	
	}
	
	//동일id 게시글 갯수 조회
	public int getReadCodiDataCount(String userId, int iNum){
		HashMap<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("userId", userId);
		hMap.put("iNum", iNum);
		return sessionTemplate.selectOne("codiDetailMapper.getReadCodiDataCount", hMap);	
	}
	
	//개별상품id 상품정보 조회
	public ProductDetailDTO getCodiProductItem(String productId){
		return sessionTemplate.selectOne("codiDetailMapper.getCodiProductItem", productId);	
	}
	
	//개발상품 좋아요 조회
	public List<String> storeHeartList(String userId){
		return sessionTemplate.selectList("codiDetailMapper.storeHeartList", userId);	
	}
	
	//좋아요 명수 카운트
	public int getCodiHeartCount(int iNum){
		return sessionTemplate.selectOne("codiDetailMapper.getCodiHeartCount", iNum);	
	}
	
	//로그인 고객 좋아요 체크
	public int getMyCodiHeart(String userId,int iNum){
		HashMap<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("userId", userId);
		hMap.put("iNum", iNum);
		return sessionTemplate.selectOne("codiDetailMapper.myCodiHeart", hMap);	
	}
	
	//작성자 정보 조회
	public MemberDTO getUserInfo(String userId){
		MemberDTO dto = sessionTemplate.selectOne("instarMapper.getUserInfo",userId);
		return dto;
	}
	
	//댓글최대카운트
	public int getReplyMaxNum(int iNum) {
		return sessionTemplate.selectOne("codiDetailMapper.getReplyMaxNum", iNum);	
	}
	
	//댓글입력
	public void insertReplyData(ReplyDTO dto) {
		sessionTemplate.insert("codiDetailMapper.insertReplyData", dto);	
	}
	
	//댓글삭제
	public void deleteReplyData(int replyNum) {
		sessionTemplate.delete("codiDetailMapper.deleteReplyData", replyNum);	
	}
	
	//코디게시물 댓글카운트
	public int getReplyDataCount(int iNum) {
		return sessionTemplate.selectOne("codiDetailMapper.getReplyDataCount", iNum);	
	}
	
	//댓글조회
	public List<ReplyDTO> getReplyListData(int iNum, int start, int end) {
		HashMap<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("iNum", iNum);
		hMap.put("start", start);
		hMap.put("end", end);
		return sessionTemplate.selectList("codiDetailMapper.getReplyListData", hMap);	
	}
	
	//작성자 팔로우 여부 확인
	public int followCheck(String followerId, String followingId) {
		HashMap<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("followerId", followerId);
		hMap.put("followingId", followingId);	
		return sessionTemplate.selectOne("codiDetailMapper.followCheck", hMap);	
	}
}
