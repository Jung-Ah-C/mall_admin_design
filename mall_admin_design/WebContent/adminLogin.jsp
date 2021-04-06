<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="gdu.mall.vo.*" %>
<%@ page import ="gdu.mall.dao.*" %>
<%@ page import ="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>adminLogin</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/bootstrap.css">
    <link rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/app.css">
    <link rel="stylesheet" href="assets/css/pages/auth.css">
</head>
<body>
<div id="auth">
	<div class="row h-100">
		<div class="col-lg-5 col-12">
			<div id="auth-left">
				<!-- 로고 사진을 누르면 adminIndex.jsp로 넘어가게 함 -->
				<div class="logo">
					<a href="<%=request.getContextPath()%>/adminIndex.jsp"><img src="<%=request.getContextPath()%>/img/logo1.jpg" alt="logo" width="200" height="100"></a>
	            </div>
	            <h1 class="auth-title">Log in</h1>
	            <p class="auth-subtitle mb-5">관리자 아이디와 패스워드를 입력하세요.</p>
	            
	            <!-- 아이디 패스워드 입력하면 Action으로 넘어가게 함 -->
	            <form action="<%=request.getContextPath()%>/manager/loginManagerAction.jsp" method="post">
	                <!-- 아이디 입력창 -->
	                <div class="form-group position-relative has-icon-left mb-4">
	                    <input type="text" name="managerId" class="form-control form-control-xl" placeholder="ManagerID">
	                    <div class="form-control-icon">
	                        <i class="bi bi-person"></i>
	                    </div>
	                </div>
	                
	                <!-- 패스워드 입력창 -->
	                <div class="form-group position-relative has-icon-left mb-4">
	                    <input type="password" name="managerPw" class="form-control form-control-xl" placeholder="Password">
	                    <div class="form-control-icon">
	                        <i class="bi bi-shield-lock"></i>
	                    </div>
	                </div>
	                <div class="form-check form-check-lg d-flex align-items-end">
	                    <input class="form-check-input me-2" type="checkbox" value="" id="flexCheckDefault">
	                    <label class="form-check-label text-gray-600" for="flexCheckDefault">
	                        Keep me logged in
	                    </label>
	                </div>
	                
	                <!-- 로그인 버튼 -->
	                <button type="submit" class="btn btn-primary btn-block btn-lg shadow-lg mt-5">Log in</button>
		            <div class="text-center mt-5 text-lg fs-4">
		                <!-- 매니저 등록 링크 -->
		                <p class="text-gray-600">Want to add a manager? <a href="<%=request.getContextPath()%>/manager/insertManagerForm.jsp" class="font-bold">Add a manager</a>.</p>
		            	<!-- 비밀번호 찾기 링크 -->
		            	<p><a class="font-bold" href="auth-forgot-password.html">Forgot password?</a>.</p>
		            </div>
	            </form>
	            <br>
	            <!-- 나중에 시간나면 토글 적용해보기! -->
	            <!-- 레벨이 0인 매니저가 로그인 할 시에 승인 대기중이라는 목록을 보여줌 -->
				<h2>Waiting For Authorization</h2>
				<div class="card-content">
					<table class="table table-lg">
						<thead>
							<tr>
								<th>managerID</th>
								<th>managerDate</th>
							</tr>
						</thead>
						<tbody>
			<%
							ArrayList<Manager> list = ManagerDao.selectManagerListByZero();
							for(Manager m : list) {
			%>
								<tr>
									<td><%=m.getManagerId()%></td>
									<td><%=m.getManagerDate().substring(0,10)%></td>
								</tr>
							
			<%
							}
			%>
						</tbody>
					</table>
	        	</div>
	    	</div>
		</div>
		<div class="col-lg-7 d-none d-lg-block">
			<div id="auth-right"></div>
		</div>
	</div>
</div>
</body>
</html>