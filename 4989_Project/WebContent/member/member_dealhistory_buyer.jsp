<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>거래진행상황</title>
		
		<style>
			fieldset {
				margin: 0 auto;
				text-align : center;
				width : 97%;
				margin-top:30px;
			}
			
			fieldset .tb {
				border : 2px solid darkgrey;
				border-collapse : collapse;
				width : 99%;
	    		height: 99%;
			}
			
			fieldset .tb tr, fieldset .tb th, fieldset .tb td {
				border : 1px solid darkgrey;
			}
		</style>
		
	</head>
	<body>
		<jsp:include page="../shop/main.jsp"/>
		
		<fieldset>
			<table class="tb">
				<tr style="height: 40px;">
					<th width="10%">판매자</th>
					<th width="10%">제품사진</th>
					<th width="10%">모델명</th>
					<th width="10%">매입희망가</th>
					<th width="10%">매입신청일</th>
					<th width="10%">결과</th>
				</tr>
			
				<c:if test="${ empty list }">
					<tr>
						<td colspan="6" align="center">
							거래내역이 없습니다.
						</td>
					</tr>
				</c:if>
			
				<c:forEach var="history" items="${ list }">
					<tr align="center">
						<td>
							${ history.seller_id }
						</td>
						
						<td>
							<img src="productimages/${ history.p_image_s }" width="100" height="90">
						</td>
					
						<td>
							${ history.p_name }
						</td>
						
						<td>
							<fmt:formatNumber value="${ history.seller_hopeprice }"/>원<br>
						</td>
										
						<td>
							${ history.t_regidate }
						</td>
						
						<td>
							<c:if test="${ history.t_status eq '완료' }">
								<span style="color:red">구매완료</span>
							</c:if>
							
							<c:if test="${ history.t_status eq '미체결' }">
								<span style="color:orange">미체결</span>
							</c:if>
							
							<c:if test="${ history.t_status eq '삭제됨' }">
								<span style="color:slategray">판매자가 삭제한 상품입니다</span>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</table>
		</fieldset>
	</body>
</html>

