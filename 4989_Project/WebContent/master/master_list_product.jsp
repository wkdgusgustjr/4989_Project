<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>관리자 > TRADING (거래내역) 목록</title>
		<style>
		.list {
			border : none;
			margin: 0 auto;
			margin-top : 30px;
		}
		
		.list table {
			border : 2px solid darkgrey;
			width : 99%;
			margin : 0 auto;
		}
		</style>
		<script>
		function p_delete(p_idx){
			if ( confirm("정말 탈퇴시키시겠습니까?") ) {
				location.href="phone_delete.do?p_idx=" + p_idx;
				alert("탈퇴완료");
				f.submit();
			}
		}
		</script>
	</head>
	<body>
		<jsp:include page="../shop/main.jsp"/>
		
		<div class="list">
			<table>
				<tr style="height: 40px;">
					<th>상품번호</th>
					<th>판매자</th>
					<th>제품사진</th>
					<th>제조회사</th>
					<th>모델명</th>
					<th>고객희망매입가</th>
					<th>등록일</th>
					<th>상태</th>
					<th>상세보기</th>
					<th>상품삭제</th>
				</tr>
				
				<!-- 제품이 없을경우 -->
				<c:if test="${ empty list }">
					<tr>
						<td colspan="8" align="center">
							상품이 없습니다.
						</td>
					</tr>
				</c:if>
				
				<c:forEach var="product" items="${ list }">
					<tr align="center">
						<td>
							${ product.p_idx }
						</td>
						
						<td>
							${ product.p_register }
						</td>
						
						<td>
							<a href="product_view.do?p_idx=${ product.p_idx }">
							<img src="productimages/${ product.p_image_s }" width="100" height="90">
							</a>
						</td>
					
						<td>
							${ product.p_company }
						</td>
					
						<td>
							<a href="product_view.do?p_idx=${ product.p_idx }">
							${ product.p_name }
							</a>
						</td>
					
						<td>
							<fmt:formatNumber value="${ product.p_price }"/>원<br>
						</td>
					
						<td>
							${ product.p_regidate }
						</td>
						
						<td>
							<c:if test="${ product.p_status == '완료'}">
							<span style="color:red">완료된 거래</span>
							</c:if>
							<c:if test="${ product.p_status == '대기'}">
							<span style="color:blue">거래 대기중</span>
							</c:if>
						</td>
						
						<td>
							<input type="button" value="상세보기" onclick="location.href='product_view.do?p_idx=${ product.p_idx }'">
						</td>
						
						<td>
							<input type="button" value="상품삭제" onclick="p_delete('${ product.p_idx }')">
						</td>
					</tr>
				</c:forEach>
			</table>
		<div style="text-align:center;">		
			<span>
				<!-- 첫 페이지로 이동하는 버튼. 그냥 파라미터로 1 넣으면 됨 -->
				<input type = "button" value = "처음" onclick = "loction.href='phone_list_action.do?page=1'">
				
				<!-- 이전 페이지로 이동하는 버튼.  현재 페이지-1-->
				<c:if test="${ paging.currentPage > 1 }">
					<input type = "button" value = "이전" onclick = "loction.href='phone_list_action.do?page=${paging.currengPage-1}'">
				</c:if>
				
				<!-- 현재 페이지가 1이면 '이전'은 비활성화 버튼으로 만든다 -->
				<c:if test="${ paging.currentPage <= 1 }">
					<input type = "button" value = "이전" disabled="disabled">
				</c:if>
				
				<!-- 1~10 각 페이지 버튼 만들기
						startPage, endPage 이런값들은 이미 Paging 객체 생성시 다 계산해놨다!! -->
				<c:forEach var="i" begin="${ paging.startPage }" end="${ paging.endPage }" step="1">
				
					<!-- 현재 페이지의 버튼이라면 클릭할 필요 없다. 비활성화  -->
					<c:if test="${ paging.currentPage == i }">
						<input type = "button" value = "${i}" disabled="disabled">
					</c:if>
					
					<c:if test="${ paging.currentPage != i }">
						<input type = "button" value = "${i}" onclick = "loction.href='phone_list_action.do?page=${i}'">
					</c:if>
										
				</c:forEach>
				
				<!-- 다음버튼(현재페이지+1) -->
				
				<c:if test="${ paging.currentPage < paging.totalPage }">
					<input type = "button" value = "다음" onclick = "loction.href='phone_list_action.do?page=${paging.currengPage+1}'">
				</c:if>
				
				<!-- 현재 페이지가 마지막페이지이면 '다음'은 비활성화 버튼으로 만든다 -->
				<c:if test="${ paging.currentPage >= paging.totalPage }">
					<input type = "button" value = "다음" disabled="disabled">
				</c:if>
				
				<!-- 마지막 페이지로 이동하는 버튼. -->
				<input type = "button" value = "끝" onclick = "loction.href='phone_list_action.do?page=${paging.totalPage}'">
			</span>
			<span>
				등록 제품 : ${ totalSize } 개
			</span>
			</div>
		</div>
	</body>
</html>




