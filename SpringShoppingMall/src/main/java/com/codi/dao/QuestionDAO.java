package com.codi.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.codi.dto.CommunityDTO;
import com.codi.dto.MemberDTO;
import com.codi.dto.ProductDTO;
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

	//list select 한명의 User
	public List<QuestionDTO> getListsUser(int start, int end,String loginUserId){

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("end", end);
		params.put("userId", loginUserId);

		List<QuestionDTO> lists = sessionTemplate.selectList("questionMapper.getListsUser",params);
		return lists;

	}

	//list select 한명의 User
	public List<QuestionDTO> getListsUserReply(int start, int end,String loginUserId){

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("end", end);
		params.put("userId", loginUserId);

		List<QuestionDTO> lists = sessionTemplate.selectList("questionMapper.getListsUserReply",params);
		return lists;

	}

	//한명의 User 갯수 count
	public int countOneUser(String loginUserId){

		int count = 0;

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", loginUserId);

		count=sessionTemplate.selectOne("questionMapper.countOneUser",params);

		return count;
	}

	//한명의 User 갯수 count(내가 답변한)
	public int countOneUserReply(String loginUserId){

		int count = 0;

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", loginUserId);

		count=sessionTemplate.selectOne("questionMapper.countOneUserReply",params);

		return count;
	}

	//팔로워 : 나를 팔로우 한 사람 userId = myFreindId인 myId값
	public int follower(String userId){
		int result = 0;

		result = sessionTemplate.selectOne("mypageMapper.follower",userId);

		return result;
	}

	//팔로잉 : 내가 팔로우 한 사람 userId = myId인 myFreind인값
	public int following(String userId){
		int result = 0;

		result = sessionTemplate.selectOne("mypageMapper.following",userId);

		return result;
	}

	//list order에 맞게 정렬
	public List<QuestionDTO> getListOrder(int start, int end,String order){

		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("start", start);
		params.put("end",end);
		params.put("order",order);

		List<QuestionDTO> lists = 
				sessionTemplate.selectList("questionMapper.getListsOrder",params);

		return lists;
	}

	public List<QuestionDTO> getListNotyet(int start, int end,String order){

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("end", end);
		params.put("order",order);

		List<QuestionDTO> lists = sessionTemplate.selectList("questionMapper.getListNotyet",params);
		return lists;

	}

	//답변달리지않은 갯수 가져옴
	public int countNotyet(){

		int count = 0;

		count=sessionTemplate.selectOne("questionMapper.countNotyet");

		return count;

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

	//글 수정 
	public void updateData(QuestionDTO dto){
		sessionTemplate.update("questionMapper.updateData",dto);	
	}

	//글 삭제 
	public void deleteData(QuestionDTO dto){	
		sessionTemplate.update("questionMapper.deleteData",dto);
	}
	
	//qNum 정보
	public QuestionDTO getDtoQnum(int qNum){
		QuestionDTO dto = sessionTemplate.selectOne("questionMapper.getDtoQnum",qNum);
		
		return dto;
	}

	//작성자 팔로우 여부 확인
	public int followCheck(String followerId, String followingId) {
		HashMap<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("MyId", followerId);
		hMap.put("MyFriendId", followingId);	

		return sessionTemplate.selectOne("questionMapper.followCheck", hMap);	
	}

	//follow
	public void insertFollow(String myId,String myFriendId){

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("myId", myId);
		params.put("myFriendId",myFriendId);

		sessionTemplate.insert("questionMapper.insertFollow",params);

	}

	//follow
	public void deleteFollow(String myId,String myFriendId){

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("myId", myId);
		params.put("myFriendId",myFriendId);

		sessionTemplate.insert("questionMapper.deleteFollow",params);

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
