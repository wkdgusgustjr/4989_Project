<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 비회원일경우 세션값들 -->
<c:if test="${ empty sessionScope.memberId }">
	<% session.setAttribute("memberId", "비회원"); %>
</c:if>
<c:if test="${ empty sessionScope.memberType }">
	<% session.setAttribute("memberType", "비회원"); %>
</c:if>
<c:if test="${ empty sessionScope.memberWallet }">
	<% session.setAttribute("memberWallet", 0); %>
</c:if>

<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>사구팔구</title>
		
		<!-- 스타일시트와 웹폰트 링크 -->
		<link rel="stylesheet" type="text/css" href="css/css_main.css?var=<%=System.currentTimeMillis()%>">
		<link href="http://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet" type="text/css">
		
		<script>
		function check ( val ) {
			var memberType = '${ sessionScope.memberType }'; // 로그인한 회원 타입
			
			// 일반회원이 아닐경우 이용불가
			if ( memberType != '일반' || memberType == null ) {
				alert("일반회원만 이용가능합니다");
				return;
			}
			
			// val 값에 따라 이동하는 페이지가 다름
			switch( val ) {
				case "sell" :
					location.href = "product_regist_input.do";		// 내 폰 팔기 페이지로 이동
					break;
				case "myproduct" :
					location.href = "product_myproduct_input.do";	// 내 상품관리 페이지로 이동
					break;
				default :
					alert("잘못된 접근입니다.");
					location.href = "product_list_input.do";
			}
			
		}
		</script>
	</head>
	
	<!-- index file -->
	<body>
	
		<c:choose>
		
			<%-- 일반회원, 사업자회원일때 보여질 페이지 --%>
			<c:when test="${ sessionScope.memberType eq '일반' or sessionScope.memberType eq '사업자'}">
				<div class="bar">
					[${ sessionScope.memberType }회원]
					<strong>${ sessionScope.memberId }</strong> 님 안녕하세요 | 
					<a href="member_mypage_input.do">마이페이지</a> | 
					<a onclick="if( confirm('${ sessionScope.memberId }님 로그아웃 하시겠습니까?') ) { location.href='member_logout.do' }">로그아웃</a><br>
					내 사구머니 : <span style="color:blue; font-weight:400;"><fmt:formatNumber value="${ sessionScope.memberWallet }" /></span> |
					로그인시간 : ${ sessionScope.loginTime }
				</div>
				
				<div class="main">
					<span><a class="title" href="product_list_input.do">사구팔구</a></span>
					<span class="menu">
						<ul>
							<li><a href="shop_intro.do">서비스소개</a></li>
							<li><a href="javascript:check('sell')">내 폰 팔기</a></li>
							<li><a href="javascript:check('myproduct')">내 상품관리</a></li>
							<li><a href="product_deal_progress_input.do">거래진행상황</a></li>
							<li><a href="qnaboard_main.do">Q&A</a></li>
						</ul>
					</span>
				</div>
			</c:when>
			
			<%-- 관리자일때 보여질 페이지 --%>
			<c:when test="${ sessionScope.memberType eq '관리자' }">
				<div class="bar">
					<strong>[ 관리자로 로그인 중입니다 ]</strong> | 
					<a onclick="if( confirm('로그아웃 하시겠습니까?') ) { location.href='member_logout.do' }">로그아웃</a><br>
					<div class="main">
						<span><a class="title" href="product_list_input.do">사구팔구</a></span>
						<span class="menu">
							<ul>
								<li><a href="master.do?type=seller">일반회원목록</a></li>
								<li><a href="master.do?type=buyer">사업자회원목록</a></li>
								<li><a href="master.do?type=leaving">탈퇴회원목록</a></li>
								<li><a href="master.do?type=product">상품목록</a></li>	
								<li><a href="master.do?type=qnaboard">게시글목록</a></li>
							</ul>	
						</span>
					</div>
				</div>
			</c:when>
			
			<%-- 비회원일 때 보여질 페이지 --%>
			<c:otherwise>
				<div class="bar">
					<span>[${ sessionScope.memberType }]</span>
					<a href="member_join_typecheck.do">회원가입</a> | 
					<a href="member_login_input.do">로그인</a>
				</div>
				
				<div class="main">
					<span><a class="title" href="product_list_input.do?company=all&page=1">사구팔구</a></span>
					<span class="menu">
						<ul>
							<li><a href="shop_intro.do">서비스소개</a></li>
							<li><a href="javascript:alert('회원가입 후 이용해주세요.')">내 폰 팔기</a></li>
							<li><a href="javascript:alert('회원가입 후 이용해주세요.')">내 상품관리</a></li>
							<li><a href="javascript:alert('회원가입 후 이용해주세요.')">거래진행상황</a></li>
							<li><a href="qnaboard_main.do">Q&A</a></li>
						</ul>
					</span>
				</div>
			</c:otherwise>
			
		</c:choose>
		
	</body>
</html>