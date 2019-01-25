<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>사구팔구 > Q&A > 게시글수정</title>
		
		<style>
		.board {
			margin : 0 auto;
			width : 1000px;
		}
		
		.board table {
			border : 2px solid darkgrey;
			border-collapse : collapse;
			width : 99%;
			margin : 0 auto;
		}
		
		.board table th {
			width: 100px;
			height: 40px;
			}
		
		.board table tr {
			border : 1px solid lightgrey;
			text-align: center;
		}
		
		.board table td {
			border : 1px solid darkgrey;
			text-align: left;
			padding-left: 10px;
		}
		
		.board table td input {
			font-family: Noto Sans KR;
			font-size: 14px;
		}
		
		.pbtn {
			border: 2px groove grey;
		    font-family: Noto Sans KR;
		    background: none;
		    font-size: 12px;
		}
		
		.button {
			text-align: center;
		}
		
		textarea {
			font-family: Noto Sans KR;
			border: none;
			outline: none;
			resize: none; 
			width: 99%; 
			margin: 15px 0px 15px 0px;
		}
			
		</style>
		
		<script>
		// 게시물수정
		function updateComplete ( f ) {
			var qna_title 	   = f.qna_title.value.trim(); 		// 제목
			var qna_answertype = f.qna_answertype.value; 	    // 질문유형
			var qna_text 	   = f.qna_text.value.trim();		// 내용
			
			if( qna_title == '' || qna_title == null ) {
				alert("제목을 입력하세요.");
				f.qna_title.focus();
				return;
			}
			
			if( qna_answertype == "항목선택" || qna_answertype == null ) {
				alert("항목을 선택하세요.");
				f.qna_answertype.focus();
				return;
			}
			
			if( qna_text == '' || qna_text == null ) {
				alert("내용을 입력하세요.");
				f.qna_text.focus();
				return;
			}
			
			alert("게시물이 수정되었습니다");
			f.submit();
		}
		</script>
	</head>
	<body>
		<jsp:include page="../shop/main.jsp"/>
		<h2 style="text-align: center; color: orange;">Q&A 게시글 수정</h2>
		
		<!-- 수정할 게시글 폼 -->			
		<div class="board">
			<form action="qnaboard_update_output.do" method="POST">
				<table>
					<tr>
						<th>번호</th>
						<td>
							<input style="border: none; outline: none;" type="text" name="qna_idx" value="${ board.qna_idx }" readonly>
						</td>
					</tr>
			
					<tr>
						<th>질문유형</th>
						<td>
							<select name="qna_answertype"> 
						    	<option value="${ board.qna_answertype }">${ board.qna_answertype }</option>
						    	
						    	<c:if test="${ board.qna_answertype eq '상품문의' }">
						    		<option value="환불문의">환불문의</option>
						    		<option value="가격문의">가격문의</option>
						    		<option value="거래문의">거래문의</option>
						    		<option value="기타문의">기타문의</option>
						    	</c:if>
						    	
						    	<c:if test="${ board.qna_answertype eq '환불문의' }">
						    		<option value="상품문의">상품문의</option>
						    		<option value="가격문의">가격문의</option>
						    		<option value="거래문의">거래문의</option>
						    		<option value="기타문의">기타문의</option>
						    	</c:if>
						    	
						    	<c:if test="${ board.qna_answertype eq '가격문의' }">
						    		<option value="상품문의">상품문의</option>
						    		<option value="가격문의">가격문의</option>
						    		<option value="거래문의">거래문의</option>
						    		<option value="기타문의">기타문의</option>
						    	</c:if>
						    	
						    	<c:if test="${ board.qna_answertype eq '거래문의' }">
						    		<option value="상품문의">상품문의</option>
						    		<option value="가격문의">가격문의</option>
						    		<option value="환불문의">환불문의</option>
						    		<option value="기타문의">기타문의</option>
						    	</c:if>
						    	
						    	<c:if test="${ board.qna_answertype eq '기타문의' }">	
						    		<option value="상품문의">상품문의</option>
						    		<option value="가격문의">가격문의</option>
						    		<option value="환불문의">환불문의</option>
						    		<option value="거래문의">거래문의</option>
						    	</c:if>
					    	</select>
						</td>
					</tr>
					
					<tr>
						<th>제목</th>
						<td>
							 <input style="border: none; outline: none; width: 800px;" type="text" name="qna_title" value="${ board.qna_title }">
						</td>
					</tr>
					
					<tr>
						<th>작성자</th>
						<td style="color:orange">${ board.qna_register }</td>
					</tr>
					
					<tr>
						<th>내용</th>
						<td>
							<textarea name="qna_text" cols="80" rows="22">${ board.qna_text }</textarea>
						</td>
					</tr>
					<!-- 게시판 번호 hidden (수정할 때 필요함) -->
					<input type="hidden" name="qna_idx" value="${ board.qna_idx }">
				</table>
				<br>
				<div class="button">
					<input class="btn" type="button" value="수정" onclick="updateComplete(this.form)"/>
					<input class="btn" type="button" value="이전" onclick="javascript:history.go(-1);"/>
				</div>
			</form>
		</div>
	</body>
</html>