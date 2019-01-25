<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<!------------------------- 게시글 작성 페이지 ------------------------->
<html>
	<head>
		<meta charset="UTF-8">
		<title>사구팔구 > Q&A게시판 > 글쓰기</title>
		<style>
		.regi {
			margin : 0 auto;
			width : 1000px;
		}
		
		.regi table {
			border : 2px solid lightgrey;
			border-collapse : collapse;
			width : 99%;
			margin : 0 auto;
		}
		
		.regi table th {
		    width: 100px;
			height: 40px;
		}
		
		.regi table tr {
			border : 1px solid lightgrey;
			text-align: center;
		}
		
		.regi table td {
			border : 1px solid lightgrey;
			text-align: left;
			padding-left: 15px;
		}
		
		.regi td input {
		 	background: none; 
		 	outline: none;
		 	border: none;
		 	font-family: Noto Sans KR;
		 }
		 
		.button {
			text-align: center;
		}
		
		textarea {
			width: 99%; 
			margin: 15px 0px 15px 0px;
			border: none;
			resize: none;
			outline: none;
		}
		
		</style>
		
		<script>
		function regi ( f ) {
			var memberType = "${ sessionScope.memberType }"; // 세션 회원타입
			var publicType = f.qna_publictype.value.trim();	 // 공개여부 선택값
			var answerType = f.qna_answertype.value.trim();	 // 항목 선택값
			var register   = f.qna_register.value.trim();	 // 작성자
			var title	   = f.qna_title.value.trim();		 // 게시글 제목
			var text 	   = f.qna_text.value;				 // 게시글 내용
			var pwd  	   = f.qna_pwd.value.trim();		 // 게시글 비밀번호
			
			if ( pwd == "" ) {
				alert("비밀번호는 필수입력 항목입니다.");
				f.qna_answertype.focus();
				return;
			}
			
			// 질문유형 유효성
			if ( answerType == '항목선택' ) {
				alert("항목을 선택하세요!");
				f.qna_answertype.focus();
				return;
			}
			
			// 작성자 유효성
			if ( register == "" || register == null ) {
				alert("작성자를 입력하세요");
				f.qna_register.focus();
				return;
			}
				
			// 글 제목 유효성
			if ( title == "" || title == null ) {
				alert("제목을 입력하세요");
				f.qna_title.focus();
				return;
			}
			
			// 내용 유효성
			if ( text == "" || text == null ) {
				alert("내용을 입력하세요");
				f.qna_title.focus();
				return;
			}
				
			if ( confirm("등록하시겠습니까?") ) {
				alert("게시물이 등록되었습니다.");
				f.submit();				
			}
		}
		</script>
	</head>
	
	<body>
		<jsp:include page="../shop/main.jsp"/>
		
		<h2 style="text-align: center; color: orange;">Q&A 게시글 작성</h2>
		
		<div class="regi">
			<form action="qnaboard_write_output.do" method="post">
				<table>
					<tr>
						<th>공개여부</th>
						<td>
							<select name="qna_publictype"> 
						    	<option style="border:none; background-color: #e2e2e2;" value="공개">공개</option>
						    	<option style="border:none; background-color: #e2e2e2;" value="비공개">비공개</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<th>질문유형</th>
						<td>
							<select name="qna_answertype"> 
						    	<option value="항목선택">항목선택</option>
						    	<option value="상품문의">상품문의</option>
						    	<option value="환불문의">환불문의</option>
						    	<option value="가격문의">가격문의</option>
						    	<option value="거래문의">거래문의</option>
						    	<option value="기타문의">기타문의</option>
					    	</select>
						</td>
					</tr>
					
					<tr>
						<th>제 목</th>
						<td>
							<input type="text" name="qna_title" placeholder="제목을 입력해주세요" style="border:none; background-color: #e2e2e2, width:400px"/>
					    </td>
					</tr>
						
					<tr>
						<th>작성자</th>
						<c:if test="${ sessionScope.memberType eq '일반' || sessionScope.memberType eq '사업자'}">
							<td><input type="hidden" name="qna_register" value="${ sessionScope.memberId }">${ sessionScope.memberId }</td>
						</c:if>
						<c:if test="${ sessionScope.memberType eq '비회원' }">
							<td><input type="text" name="qna_register" placeholder="작성자를 입력해주세요"></td>
						</c:if>
						
					</tr>
					
					<tr>	
						<th>내 용</th>
						<td><textarea cols="90" rows="20" name="qna_text"></textarea></td>
					</tr>
					
					<tr>
						<th>Password</th>					
						<td><input style="border:none; outline:none;" type="password" name="qna_pwd" placeholder="필수입력"></td>
					</tr>
				</table>
				<br>
				<div class="button">
					<input class="pbtn" type="button" value="등록" onclick="regi(this.form)"/>
					<input class="pbtn" type="reset" value="리셋"/>
					<input class="pbtn" type="button" value="이전" onclick="location.href='qnaboard_main.do'"/>
				</div>
			</form>
		</div>
	</body>
</html>