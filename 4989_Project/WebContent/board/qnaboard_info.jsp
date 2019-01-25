<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>사구팔구 > QnA > 상세보기</title>
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
		
		.board table th {
		    width: 100px;
			height: 40px;
		}
		
		.board table tr {
			border : 1px solid lightgrey;
			text-align: center;
		}
		
		.board table td {
			border : 1px solid lightgrey;
			text-align: left;
			padding-left: 15px;
		}
		
		.comments {
			width: 1000px;
    		margin: 0 auto;
		}
		
		textarea {
			resize: none; 
			background-color: #e2e2e2; 
			width: 900px; 
			margin: 15px 0px 15px 0px;
		}
		
		</style>
		
		<script>
		// 게시물삭제
		function deletecontent( f ) {
			var boardPwd = f.boardpwd.value;		   // 게시글 비밀번호
			var inputPwd   = f.inputpwd.value; 			   // 입력한 비밀번호
			var qna_idx = f.qna_idx.value;				   // 게시물 번호
			
			if ( inputPwd == "" ) { 
				alert("글 수정/삭제시 비밀번호는 필수입력항목입니다.");
				return;
			}
			
			if ( boardPwd != inputPwd ) {
				alert("비밀번호가 틀렸습니다");
				return;
			}
			
			if ( confirm("정말 삭제하시겠습니까?") ) {
				alert("게시물이 삭제되었습니다.");
				location.href="qnaboard_delete.do?qna_idx=" + qna_idx;
			}
		}
		
		// 게시글 수정
		function updatecontent ( f ) {
			var boardPwd   = f.boardpwd.value;			   // 게시글 비밀번호
			var inputPwd   = f.inputpwd.value; 			   // 입력한 비밀번호
			var qna_idx    = f.qna_idx.value.trim();	   // 게시글 번호
			
			if ( inputPwd == "" ) { 
				alert("글 수정/삭제시 비밀번호는 필수입력항목입니다.");
				return;
			}
			
			if ( boardPwd != inputPwd ) {
				alert("비밀번호가 틀렸습니다");
				return;
			}
			
			if ( confirm("수정페이지로 이동하시겠습니까?") ) {
				location.href="qnaboard_update_input.do?qna_idx=" + qna_idx;
			}
		}
		
		// 댓글 불러오기
		function commentlist(f, qna_idx) {
			var qna_idx = f.qna_idx.value.trim();
			location.href = "qnaboard_commentlist.do?qna_idx=" + qna_idx;
		}
		
		// 댓글 작성
		function com_regi( f ) {
			var qna_idx 	 = f.qna_idx.value.trim();		// 글 번호
			var com_register = f.com_register.value.trim(); // 댓글 작성자
			var com_text 	 = f.com_text.value.trim();     // 댓글 내용
			
			if ( com_text == "" || com_text == null) {
				alert("댓글을 입력하세요.");
				f.com_text.focus();
				return;
			}
			
			if ( com_register == "비회원" || com_register == null ) {
				alert("로그인 후 작성 가능합니다.");
				f.com_register.focus();
				return;
			}
			
			location.href = "qnaboard_comment_regi.do?qna_idx=" + qna_idx +
											 	 	"&com_register=" + com_register +
											  		"&com_text=" + com_text;
		}
		
		// 댓글 삭제
		function deleteComment( f ) {
			var qna_idx		 = f.qna_idx.value.trim();				// 원 글 번호
			var com_idx		 = f.com_idx.value.trim();				// 댓글 번호
			var com_register = f.com_register.value.trim(); 		// 댓글 작성자
			var memberId 	 = "${ sessionScope.memberId }";		// 현재 로그인한 아이디 (비회원일경우 '비회원')

			// 댓글 작성자 != 현재 로그인한 아이디
			if ( com_register != memberId || com_register == null || memberId == null ) {
				alert("권한이 없습니다.")
				f.com_register.focus();
				return;
			}

			if ( confirm("댓글을 삭제하시겠습니까?") ) {
				location.href = "qnaboard_comment_delete.do?qna_idx=" + qna_idx + 
														  "&com_idx=" + com_idx;				
			}
		}
		</script>
	</head>
	
	<body>
		<jsp:include page="../shop/main.jsp"/>
		<h2 style="text-align: center; color: orange;">- Q&A 게시글 상세보기 -</h2>
			
		<!-- 게시글 폼 -->
		<div class="board">
			<form method="post">
				<table>
					<tr>
						<th>번호</th>
						<td>${ board.qna_idx }</td>
					</tr>
			
					<tr>
						<th>질문유형</th>
						<td>[ ${ board.qna_answertype } ]</td>
					</tr>
			
					<tr>
						<th>제목</th>
						<td>${ board.qna_title }</td>
					</tr>
					
					<tr>
						<th>작성자</th>
						<td style="color:orange">${ board.qna_register }</td>
					</tr>
			
					<tr>
						<th>작성일</th>
						<td>${ board.qna_regidate }</td>
					</tr>
					
					<tr>
						<th style="width:30px; height:300px;">내용</th>
						<td>${ board.qna_text }</td>
					</tr>
					
					<tr>
						<th>Password</th>
						<td><input style="border:none; background-color: #e2e2e2;" type="password" name="inputpwd" placeholder="수정, 삭제시 필수입력"></td>
					</tr>
					
					<!-- 글 번호 hidden -->	
					<input type="hidden" name="qna_idx" value="${ board.qna_idx }">
					
					<!-- 글 비밀번호 hidden -->
					<input type="hidden" name="boardpwd" value="${ board.qna_pwd }">
				</table>
				
				<br>
				
				<div style="text-align:center;">
					<input class="pbtn" type="button" value="수정" onclick="updatecontent(this.form)" />
					<input class="pbtn" type="button" value="삭제" onclick="deletecontent(this.form)"/>
					<input class="pbtn" type="button" value="이전" onclick="location.href='qnaboard_main.do'"/>
				</div>
			</form>
		</div>
		
		<br>
		
		<hr style="width: 1000px; border: 1px solid darkgrey;">
		
		<!-- 댓글 폼 -->
		<div class="comments">
                     작성자 : <strong style="color:orange">${ sessionScope.memberId }</strong>
	        <form method="post">
	        	<!-- 게시글 번호 hidden -->
	        	<input type="hidden" name="qna_idx" value="${ board.qna_idx }">
	        	<!-- 댓글 작성자 hidden -->
	            <input type="hidden" name="com_register" value="${ sessionScope.memberId }">
	            
	            <textarea rows="3" name="com_text" placeholder="댓글을 입력하세요"></textarea>
	            <input style="float: right; margin-top: 15px; width: 90px; height: 51px;" class="pbtn" type="button" value="등록" onclick="com_regi(this.form)">
	        </form>
        	
        	<hr style="width: 1000px; border: 1px solid darkgrey;">
        	<strong style="color:coral">Comments : ${Total}</strong>
        	<hr style="width: 1000px; margin: 8px 0px 0px 0px;">
        	
        	<!-- 댓글이 없을 때 -->
	       	<c:if test="${ empty comment }">
	  			<h3 style="text-align: center; color:orange;">댓글이 없습니다.</h3>
	       	</c:if>      
       	
       		<!-- 댓글이 있을 때 -->
	       	<c:forEach var="com" items="${ comment }">
		   		<form method="post">
	       			<strong>${ com.com_register }</strong> (${ com.com_regidate })
	       			<br>
	       			<span style="margin:10px 0px 20px">
		       			${ com.com_text }
		       		</span>
		       		<span style="float: right;">
		       			<input class="pbtn" type="button" value="x" onclick="deleteComment(this.form)">
		       		</span>
	       			<hr style="width: 1000px; margin: 8px 0px 0px 0px;">
					
	      		  	<!-- 댓글 작성자 hidden -->
	      		  	<input type="hidden" name="com_register" value="${ com.com_register }">
	      		  	
	      		  	<!-- 원 글 번호 hidden -->
	      		  	<input type="hidden" name="qna_idx" value="${ board.qna_idx }">
	      		  	
	      		  	<!-- 댓글 번호 hidden -->
		        	<input type="hidden" name="com_idx" value="${ com.com_idx }">
		   		</form>  
			</c:forEach>
		</div>
	</body>
</html>