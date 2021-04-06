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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/bootstrap.css">

    <link rel="stylesheet" href="assets/vendors/iconly/bold.css">

    <link rel="stylesheet" href="assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon">
<title>ebookList</title>
</head>
<body>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/adminMenu.jsp">
			<jsp:param name="current" value="ebook"/>
		</jsp:include>
	</div>
	
	<!-- 페이징을 위한 변수 초기화 -->
	<%
		// 현재 페이지
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage")); // 받아온 값 정수로 변환
		}
		
		// 페이지 당 행의 수
		int rowPerPage = 10;
		if(request.getParameter("rowPerPage") != null) {
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage")); // 받아온 값 정수로 변환
		}
		
		// 시작 행
		int beginRow = (currentPage - 1) * rowPerPage;
		
		// 전체 행의 개수
		int totalRow = EbookDao.totalCount();
		System.out.println(totalRow+"<-- EbookDao의 totalRow"); // 디버깅
		
		// 카테고리 변수 초기화
		String categoryName = null;
		
		// 카테고리별 목록 (카테고리 누른 값을 DAO로 넘겨줌)
       	if(request.getParameter("categoryName") != null){
          categoryName = request.getParameter("categoryName");
          }
		System.out.println(categoryName+"<-- ebookList의 categoryName"); // 디버깅
		
		// list 생성 (categoryName에 누른 값이 들어감)
		ArrayList<Ebook> ebookList = EbookDao.selectEbookListByPage(rowPerPage, beginRow, categoryName);
		ArrayList<String> CategoryList = CategoryDao.categoryNameList();
		
	%>
	
	<!-- 카테고리 눌렀을 때, 카테고리별로 Ebook 목록 나오게 함-->
	<div>
		<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">[전체]</a>
		<%
			for(String e : CategoryList) {
		%>
				<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=e%>">[<%=e%>]</a>
		<%
			}
		%>
	</div>
	
	<h1>ebookList</h1>
	<a href="<%=request.getContextPath()%>/ebook/insertEbookForm.jsp"><button type="button">ebook 추가</button></a>
			
	<!-- 한 페이지당 몇 개씩 볼건지 선택가능 -->
	<form action="<%=request.getContextPath()%>/ebook/ebookList.jsp" method="post">
		<select name="rowPerPage">
			<%
				for(int i=10; i<31; i+=5) {
					if(rowPerPage == i) {
			%>
					<!-- 옵션에서 선택한 개수만큼의 행이 보이게 함 -->
					<option value=<%=i%> selected="selected"><%=i%>개씩</option> 
			<%
					} else {
			%>
					<!-- 옵션 선택이 되어 있지 않으면 rowPerPage 설정 값으로 보이게 함 -->
					<option value=<%=i%>><%=i%>개씩</option>
			<%	
					}
				}
			%>
		</select>
		<button type="submit">보기</button>
	</form>
	
	<!-- ebook 목록 테이블 작성 -->
	<table border="1">
		<thead>
			<tr>
				<th>categoryName</th>
				<th>ebookISBN</th>
				<th>ebookTitle</th>
				<th>ebookAuthor</th>
				<th>ebookDate</th>
				<th>ebookPrice</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Ebook e : ebookList) {
			%>
					<tr>
						<td><%=e.getCategoryName()%></td>
						<td><%=e.getEbookISBN()%></td>
						<!-- ebookTitle을 누르면 상세정보로 넘어가게 링크 걸음 -->
						<!-- primary key를 안받아와서, 대신 ISBN으로 대체함 -->
						<td><a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=e.getEbookISBN()%>"><%=e.getEbookTitle()%></a></td>
						<td><%=e.getEbookAuthor()%></td>
						<td><%=e.getEbookDate().substring(0,11)%></td>
						<td><%=e.getEbookPrice()%></td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>
	
	<!-- 페이징 (이전, 다음) 버튼 만들기 -->
	<% 
		// 맨 첫 페이지에서 이전 버튼이 나오지 않게 함
		if(currentPage > 1) {
	%>
				<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">이전</a>
	<%
		}
	
		// 맨 마지막 페이지에서 다음 버튼이 보이지 않도록 함
		int lastPage = totalRow / rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1; // lastPage = lastPage+1; lastPage++;
		}
		
		if(currentPage < lastPage) {
	%>
			<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>&categoryName=<%=categoryName%>">다음</a>
	<%
		}
	%>
</body>
</html>