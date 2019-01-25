<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!------------------------- 게시판 메인 페이지 ------------------------->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>사구팔구 > QnA</title>
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
		
		// 클릭한 게시물 상세보기
		function viewcontent( qna_idx, qna_publictype ) { // 파라미터로 게시물번호, 공개여부 받는다.
			if( qna_publictype == "비공개" ) {
				location.href = "qnaboard_secret.do?qna_idx=" + qna_idx;
			}
			else if( qna_publictype == "공개" ){
				location.href="qnaboard_info.do?qna_idx=" + qna_idx;
			}
			else {
				alert("잘못된 접근입니다");
				return;
			}
		}	
		</script>
	</head>
	
	<body>
		<jsp:include page="../shop/main.jsp"/>
		
		<h2 style="text-align: center; color: orange;">Q&A 게시판</h2>
		<div class="board">
			총 게시물 : ${ total }
			<br><br>
			<form>
				<table>
					<tr height="40">
						<th width="40">번호</th>
						<th width="80">분류</th>
						<th width="320">제목</th>
						<th width="100">작성자</th>
						<th width="170">작성일</th>
						<th width="60">조회수</th>
						<th width="70">공개여부</th>
						<th width="70">답변여부</th>
					</tr>
					
					<!-- 게시물이 하나도 없을 때 -->
					<c:if test="${ empty list }">
			    		<tr height="40">
			      			<td colspan="8">게시물이 존재하지 않습니다.</td>
			    		</tr>
					</c:if>
					
					<!-- 게시물이 1개 이상이면 forEach문으로 차례로 빼온다 -->
					<c:forEach var="board" items="${ list }">
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
			</form>
		</div>
		
		<br>
		
		<div style="text-align: center;">
			<input class="pbtn" type="button" value="처음" onclick="location.href='qnaboard_main.do?page=1'">
			
			<!-- 이전 페이지로 이동하는 버튼. 현재페이지-1 -->
			<c:if test="${ paging.currentPage > 1 }">
				<input class="pbtn" type="button" value="이전" onclick="location.href='qnaboard_main.do?page=${ paging.currentPage - 1 }'">
			</c:if>
			
			<!-- 현재 페이지가 1이면 '이전'은 비활성화 버튼으로 만든다. -->
			<c:if test="${ paging.currentPage <= 1 }">
				<input class="pbtn" type="button" value="이전" disabled="disabled">
			</c:if>
			
			<!-- 1~10 각 페이지 버튼 만들기
					startPage, endPage 이런 값들은 이미 Paging 객체 생성 시 다 계산해놨다!! -->
			<c:forEach var="i" begin="${ paging.startPage }" end="${ paging.endPage }" step="1">
				
				<!-- 현재 페이지의 버튼이라면 클릭할 필요 없다. 비활성화 -->
				<c:if test="${ paging.currentPage == i }">
					<input class="pbtn" type="button" value="${ i }" disabled="disabled">
				</c:if>
				
				<c:if test="${ paging.currentPage != i }">
					<input class="pbtn" type="button" value="${ i }" onclick="location.href='qnaboard_main.do?page=${ i }'">
				</c:if>
				
			</c:forEach>
			
			<!-- 다음 버튼 (현재페이지+1) -->
			<c:if test="${ paging.currentPage < paging.totalPage }">
				<input class="pbtn" type="button" value="다음" onclick="location.href='qnaboard_main.do?page=${ paging.currentPage + 1 }'">
			</c:if>
			
			<!-- 현재 페이지가 마지막페이지이면 '다음'은 비활성화 버튼으로 만든다. -->
			<c:if test="${ paging.currentPage >= paging.totalPage }">
				<input class="pbtn" type="button" value="다음" disabled="disabled">
			</c:if>
			
			<input class="pbtn" type="button" value="끝" onclick="location.href='qnaboard_main.do?page=${ paging.totalPage }'">				
		</div>
			
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
	</body>
</html>