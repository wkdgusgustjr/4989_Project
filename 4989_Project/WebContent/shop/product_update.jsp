<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>사구팔구 > 내 상품관리</title>
		<style>
		.update {
			text-align: center;
		}
		
		.update table {
			margin: 0 auto;
		    border: 2px solid gray;
		    width: 50%;
		    border-collapse:collapse;
		}
		
		.update th  {
			text-align: center;
			border: 1px solid gray;
			height: 40px;
		}
		
		 .update td {
		 	text-align: left;
		 	padding-left : 15px;
			border: 1px solid gray;
			outline: none;
			font-size: 13px;
		 }
		 
		 .update td input {
		 	background: none; 
		 	outline: none;
		 	border: none;
		 	font-family: Noto Sans KR;
		 }
		 
		.showimg img {
		 	width: 22px;
		 	height: 22px;
			transform: scale(1);
			-webkit-transform: scale(1);
			-moz-transform: scale(1);
			-ms-transform: scale(1);
			-o-transform: scale(1);
			transition: all 0.3s ease-in-out;
		}
		
		.showimg:hover img {
			transform: scale(12);
			-webkit-transform: scale(12);
			-moz-transform: scale(12);
		 	-ms-transform: scale(12);
			-o-transform: scale(12);
			overflow: hidden;
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
		function update ( f ) {
			if ( confirm("수정하시겠습니까?") ) {
				f.submit();	
			}
		}
		</script>
	</head>
	<body>
		<jsp:include page="../shop/main.jsp"/>
		
		<div style="text-align: center; font-size: 18px; color: red; padding-bottom: 20px;">* 희망매입가와 상세내용만 수정할 수 있습니다.</div>
		
		<div class="update">
		<form method="post" action="product_update_output.do" enctype="multipart/form-data">
			<table>
				<tr>
					<th>상품번호</th>
					<td>
						<input type="text" name="p_idx" value="${ myproduct.p_idx }" readonly>
					</td>	
				</tr>
				
				<tr>
					<th>판매자</th>
					<td style="color:orange">
						<input type="text" name="p_register" value="${ myproduct.p_register }" readonly>
					</td>
				</tr>
				
				
				<tr>
					<th>제조회사</th>
					<td>
						<input type="text" name="p_company" value="${ myproduct.p_company }" readonly>
					</td>
				</tr>
				
				<tr>
					<th>모델명</th>
					<td>
						<input type="text" name="p_name" value="${ myproduct.p_name }" readonly>
					</td>
				</tr>
				
				<tr>
					<th>희망매입가</th>
					<td>
						<input type="text" name="p_price" value="${ myproduct.p_price }">
					</td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td>
						<textarea cols="40" rows="10" name="p_text" >${ myproduct.p_text }</textarea>
					</td>
				</tr>
				
				<tr>
					<th rowspan="2">제품사진 (미리보기)</th>
					<td>현재 이미지 : 
						<span class="showimg"><img src="productimages/${ myproduct.p_image_s }"></span>
						<input style="border:none;" type="text" name="p_image_s" value="${ myproduct.p_image_s }" readonly>
					</td>
				</tr>
				
				<tr>
					<td>변경할 이미지 :  <input type="file" name="change_p_image_s"></td>
				</tr>
				
				<tr>
					<th rowspan="2">사진1</th>
					<td>현재 이미지 :
						<span class="showimg"><img src="productimages/${ myproduct.p_image_1 }"></span>
						<input style="border:none;" type="text" name="p_image_1" value="${ myproduct.p_image_1 }" readonly>
					</td>
				</tr>
				
				<tr>
					<td>변경할 이미지 : <input type="file" name="change_p_image_1"></td>
				</tr>
				
				<tr>
					<th rowspan="2">사진2</th>
					<td>현재 이미지 : 
						<span class="showimg"><img src="productimages/${ myproduct.p_image_2 }"></span>
						<input style="border:none;" type="text" name="p_image_2" value="${ myproduct.p_image_2 }" readonly>
					</td>
				</tr>
				
				<tr>
					<td>변경할 이미지 : <input type="file" name="change_p_image_2"></td>
				</tr>
				
				<tr>
					<th rowspan="2">사진3</th>
					<td>현재 이미지 : 
						<c:if test="${ myproduct.p_image_3 eq 'no_file' }">
							이미지가 없습니다.
						</c:if>
						<c:if test="${ myproduct.p_image_3 ne 'no_file' }">
							<span class="showimg"><img src="productimages/${ myproduct.p_image_3 }"></span>
							<input style="border:none;" type="text" name="p_image_3" value="${ myproduct.p_image_3 }" readonly>
						</c:if>	
					</td>
				</tr>
				
				<tr>
					<td>변경할 이미지 : <input type="file" name="change_p_image_3"></td>
				</tr>
				
				<tr>
					<th rowspan="2">사진4</th>
					<td>현재 이미지 : 
					<c:if test="${ myproduct.p_image_4 eq 'no_file' }">
						이미지가 없습니다.
					</c:if>
					<c:if test="${ myproduct.p_image_4 ne 'no_file' }">
						<span class="showimg"><img src="productimages/${ myproduct.p_image_4 }"></span>
						<input style="border:none;" type="text" name="p_image_4" value="${ myproduct.p_image_4 }" readonly>
					</c:if>	
					</td>
				</tr>
				
				<tr>
					<td>변경할 이미지 : <input type="file" name="change_p_image_4"></td>
				</tr>
			</table>
			<br>
			<input class="pbtn" type="button" value="수정완료" onclick="update(this.form)">
			<input class="pbtn" type="reset" value="초기화">
			<input class="pbtn" type="button" value="이전" onclick="javascript:history.go(-1)">
		</form>
		</div>
	</body>
</html>