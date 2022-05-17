<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//jQuery/test8_json.jsp
MemberDAO memberDAO=new MemberDAO();
// 리턴할형 List<MemberDTO>  getMemberList() 정의
// List<MemberDTO> memberList= getMemberList() 호출
List<MemberDTO> memberList=memberDAO.getMemberList();
// memberList 데이터 json데이터 변경
// WEB-INF - lib - json-simple-1.1.1.jar

// 배열 List =>JSONArray 
JSONArray jsonArray=new JSONArray();
for(int i=0;i<memberList.size();i++){
	MemberDTO dto=memberList.get(i);
	// MemberDTO => JSONObject
	JSONObject jsonObject=new JSONObject();
	jsonObject.put("id", dto.getId());
	jsonObject.put("pass",dto.getPass());
	jsonObject.put("name", dto.getName());
	// JSONArray 한칸에 JSONObject 저장
	jsonArray.add(jsonObject);
}
%>
<%=jsonArray%>