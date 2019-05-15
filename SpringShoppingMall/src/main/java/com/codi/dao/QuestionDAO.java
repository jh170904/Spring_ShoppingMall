package com.codi.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.CommunityDTO;
import com.codi.dto.MemberDTO;
import com.codi.dto.QreplyDTO;
import com.codi.dto.QuestionDTO;
import com.codi.dto.ReplyDTO;

@Component("questionDAO")
public class QuestionDAO {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}
	
	//qnum가져옴
	public int getMaxNum(){
			
		int maxNum = 0;
			
		maxNum=sessionTemplate.selectOne("questionMapper.maxNum");
		
		return maxNum;
		
	}
	
	//question 테이블에 insert
	public void insertQuestion(QuestionDTO dto){

		sessionTemplate.insert("questionMapper.insertQuestion",dto);
	}
	
	//게시물 갯수 가져옴
	public int getDataCount(){
			
		int count = 0;
			
		count=sessionTemplate.selectOne("questionMapper.getDataCount");
		
		return count;
		
	}
	
	//list select
	public List<QuestionDTO> getLists(int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("end", end);
		
		List<QuestionDTO> lists = sessionTemplate.selectList("questionMapper.getLists",params);
		return lists;
		
	}
	
	//회원프로필 정보
	public MemberDTO getUserInfo(String userId){
		MemberDTO dto = sessionTemplate.selectOne("questionMapper.getUserInfo",userId);
		return dto;
	}
	
	//조회수 증가
	public void updateHitCount(int qNum) {
		sessionTemplate.update("questionMapper.updateHitCount", qNum);
	}

	//게시글 조회
	public QuestionDTO getReadOne(int qNum){
		return sessionTemplate.selectOne("questionMapper.getOne", qNum);	
	}
	
	//댓글
	//댓글최대카운트
	public int getReplyMaxNum(int qNum) {
		return sessionTemplate.selectOne("questionMapper.getReplyMaxNum", qNum);	
	}
	
	//댓글입력
	public void insertReplyData(QreplyDTO dto) {
		sessionTemplate.insert("questionMapper.insertReplyData", dto);	
	}
	
	//댓글삭제
	public void deleteReplyData(int replyNum) {
		sessionTemplate.delete("questionMapper.deleteReplyData", replyNum);	
	}
	
	//코디게시물 댓글카운트
	public int getReplyDataCount(int qNum) {
		return sessionTemplate.selectOne("questionMapper.getReplyDataCount", qNum);	
	}
	
	//댓글조회
	public List<QreplyDTO> getReplyListData(int qNum, int start, int end) {
		HashMap<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("qNum", qNum);
		hMap.put("start", start);
		hMap.put("end", end);
		return sessionTemplate.selectList("questionMapper.getReplyListData", hMap);	
	}
	

}
