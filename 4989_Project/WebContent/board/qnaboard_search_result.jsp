<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>사구팔구 > Q&A > 검색결과</title>
		<style>
		.board {
			margin : 0 auto;
			width : 1000px;
		}
		
		.board table {
			border : 2px solid lightgrey;
			border-collapse : collapse;
			width : 99%;
			margin : 0 auto;
		}
		
		.board table th, .board table td {
			border : 1px solid lightgrey;
			text-align: center;
		}
		</style>
		
		<script>
		// 게시물 검색
		function searchcontent ( f ) {
			var col  = f.col.value;	 // 검색조건
			var word = f.word.value; // 검색란에 입력한 값
			
			if ( col == "none" || col == null ) { 
				alert("검색조건을 선택하세요");
				f.col.value.focus();
				return;
			}
			
			if ( word == "" || word == null ) {
				alert("검색어를 입력하세요");
				f.word.value.focus();
				return;
			}
			
			location.href = "qnaboard_search.do?col=" + col + "&word=" + word;
		}
		</script>
		
		<style>
		
		</style>
	</head>
	
	<body>
		<jsp:include page="../shop/main.jsp"/>
		
		<h2 style="text-align: center; color: orange;">Q&A 게시판 검색결과</h2>
		
		<!-- 검색결과 폼 -->
		<div class="board">
			검색된 게시물 : ${ total }
			<br><br>
			<table>
				<tr height="35">
					<th width="40">번호</th>
					<th width="80">분류</th>
					<th width="320">제목</th>
					<th width="100">작성자</th>
					<th width="170">작성일</th>
					<th width="60">조회수</th>
					<th width="70">공개여부</th>
					<th width="70">답변여부</th>
				</tr>
				
				<!-- 검색된 게시물이 하나도 없을때 -->
				<c:if test="${ empty search_list }">
		    		<tr height="40">
		      			<td colspan="8">검색된 게시물이 없습니다.</td>
		    		</tr>
				</c:if>
				
				<!-- 검색된 게시물이 하나 이상일 때 -->
				<c:forEach var="board" items="${ search_list }">
					<tr height="60">
							<td>${ board.qna_idx }</td>
							<td>${ board.qna_answertype }</td>
								<c:if test="${ board.qna_publictype eq '비공개'}">
									<td><a style="color:deeppink" href="javascript:viewcontent('${ board.qna_idx }','${ board.qna_publictype }')">비공개</a></td>
								</c:if>
								<c:if test="${ board.qna_publictype eq '공개'}">
									<td><a style="color:black" href="javascript:viewcontent('${ board.qna_idx }','${ board.qna_publictype }')">${ board.qna_title }</a></td>
								</c:if>
							<td>${ board.qna_register }</td>
							<td>${ board.qna_regidate }</td>
							<td>${ board.qna_views }</td>
							<td>${ board.qna_publictype }</td>
								<c:if test="${ board.qna_status eq '미답변' }">
									<td style="color:red">${ board.qna_status }</td>
								</c:if>
								<c:if test="${ board.qna_status eq '답변완료' }">
									<td style="color:blue">${ board.qna_status }</td>
								</c:if>
						</tr>
				</c:forEach>
			</table>
			
			<br>
			
  			<div style="text-align:center;">		
			<input class="pbtn" type="button" value="글쓰기" onclick="location.href='qnaboard_write_input.do'">
		</div>			
		
		<div style="text-align:center; margin-top:10px;">
			<form method="GET">
			    <select name="col"> 
			    	<option value="none">검색조건</option>
			    	<option value="register">작성자</option>
			        <option value="title">제목</option>
			        <option value="publictype">공개여부</option>
			        <option value="answertype">질문유형</option>
			        <option value="text">내용</option>
			    </select>
		       <input style="border:none; background-color: #e2e2e2;" type="text" name="word" placeholder="특수문자 사용불가" >
		       <input class="pbtn" type="button" value="검색" onclick="searchcontent(this.form)">
		   </form>
	    </div>
	   </div>
	</body>
</html>