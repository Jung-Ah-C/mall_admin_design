<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 매니저인 사람들만 고객리스트에 접근할 수 있게 함
	// 매니저가 아니라면 다시 adminIndex로 보내버림
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
%>
<%
	//수집 코드 구현 (categoryNo, categoryWeight)
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo")); // 값을 받아올 때 String으로 받기 때문에 int로 변환해줘야 함
	int categoryWeight = Integer.parseInt(request.getParameter("categoryWeight")); // 값을 받아올 때 String으로 받기 때문에 int로 변환해줘야 함
	
	// 디버깅 코드 (categoryWeight 옵션 선택 값을 잘 받아왔는지 확인하기 위해서)
	System.out.println("categoryNo : "+categoryNo);
	System.out.println("categoryWeight : "+categoryWeight);
	
	// CategoryDao의 수정 메소드 호출 코드 구현
	CategoryDao.updateCategoryWeight(categoryNo, categoryWeight);
	
	// 수정 완료되면 categoryList에 완료된 값 표시하기 위해서 해당 페이지 재요청
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>
