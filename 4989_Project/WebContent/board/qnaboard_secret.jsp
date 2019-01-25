<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>사구팔구 > QnA > 게시글 (비밀번호확인)</title>
		<style>
		.check {
			margin : 0 auto;
			width : 500px;
		}
		
		.check table {
			border : 2px solid lightgrey;
			border-collapse : collapse;
			width : 99%;
			margin : 0 auto;
		}
		
		.check table th {
			border : 1px solid lightgrey;
			text-align: center;
			height: 50px;
		}
		
		.check .button {
			text-align: center;
		}
		
		</style>
		<script>
			function check( f ) {
				var qna_idx  = 	f.qna_idx.value.trim();  // 게시물 번호
				var qna_pwd  = 	f.qna_pwd.value.trim();  // 게시물 원래 비밀번호
				var inputPwd = 	f.inputPwd.value.trim(); // 입력한 비밀번호
				
				if( qna_pwd != inputPwd ) {
					alert("비밀번호가 일치하지 않습니다.");
					return;
				}
				
				location.href = "qnaboard_info.do?qna_idx=" + qna_idx; 
			}
		</script>
	</head>
	
	<body>
		<jsp:include page="../shop/main.jsp"/>
		
		<div class="check">
			<h3 style="text-align: center; color: orange;">* 글 작성시 입력했던 비밀번호를 입력해주세요.</h3> 
			<form>
				<!-- 클릭한 게시글 번호 hidden -->
				<input type="hidden" name="qna_idx" value="${ board.qna_idx }"/>
				
				<!-- 클릭한 게시글 비밀번호 hidden -->
				<input type="hidden" name="qna_pwd" value="${ board.qna_pwd }"/>
				
				<table>
					<tr>
						<th>Password</th>
						<th><input style="boder:none; background-color: #e2e2e2;" type="password" name="inputPwd" placeholder="비밀번호를 입력해주세요"></th>
					</tr>
				</table>
				
				<br>
				
				<div class="button">
					<input class="pbtn" type="button" value="확인" onclick="check(this.form);"/>
					<input class="pbtn" type="button" value="이전" onclick="javascript:history.go(-1);"/>
				</div>
			</form>
		</div>
	</body>
</html>