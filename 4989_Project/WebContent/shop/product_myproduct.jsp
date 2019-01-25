<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>사구팔구 > 상품관리</title>
		<style>
		.list {
			border : none;
			margin: 0 auto;
			margin-top : 30px;
		}
		
		.list table {
			border : 1px solid lightgrey;
			border-collapse : collapse;
			width : 99%;
			margin : 0 auto;
		}
		
		.list table th, .list table td, .category table th {
			border : 1px solid lightgrey;
		}
		</style>
		<script>
		function del( p_idx ) {
			if (confirm("삭제하시면 회원님의 상품에 매입신청 했던 회원들의 데이터도 삭제됩니다. 정말 삭제하시겠습니까? ")) {
				location.href = "product_delete.do?p_idx=" + p_idx;
			}
		}
		</script>
	</head>

	<body>
		<jsp:include page="../shop/main.jsp"/>
		<span style="font-size: 18px; color: red; padding-left: 30px;"> * 현재 거래 대기중인 상품만 수정할 수 있습니다. </span>
		<div class="list">
			<table>
				<tr style="height:40px;">
					<th>제품사진</th>
					<th>제조회사</th>
					<th>모델명</th>
					<th>나의 희망매입가</th>
					<th>등록일</th>
					<th>상품수정</th>
					<th>상품삭제</th>
				</tr>
				
				<!-- 제품이 없을경우 -->
				<c:if test="${ empty list }">
					<tr>
						<td colspan="7" align="center">
							수정할 수 있는 상품이 없습니다.
						</td>
					</tr>
				</c:if>
				
				<c:forEach var="myProduct" items="${ list }" varStatus="status">
					<tr align="center">
						<td>
							<a href="product_view.do?p_idx=${ myProduct.p_idx }">
							<img src="productimages/${ myProduct.p_image_s }" width="100" height="90">
							</a>
						</td>
						
						<td>
							${ myProduct.p_company }
						</td>
					
						<td>
							${ myProduct.p_name }
						</td>
					
						<td>
							<fmt:formatNumber value="${ myProduct.p_price }" type="currency"/><br>
						</td>
					
						<td>
							${ myProduct.p_regidate }
						</td>
					
						<td>
							<input class="btn" type="button" value="수정" onclick="location.href='product_update_input.do?p_idx=${ myProduct.p_idx }'">
						</td>
						
						<td>
						
							<input class="btn" type="button" value="삭제" onclick="del(${ myProduct.p_idx })">
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>	
	</body>
</html>