<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.formssi.com/taglibs/froms" prefix="forms" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/platform-tags" prefix="p" %>


<!-- 审批弹出框DIV -->
<div id="auditDiv" style="display:none;">
		<form action="" method="post" id="auditForm">
		<p:token/>
			<table width="98%">
				<tr>
					<td align="left" colspan="2">
						<div id="hideSubIds"></div>
						<input type="hidden" id="cntNum" name="cntNum"/>
						<input type="hidden" id="dataFlag" name="dataFlag"/>
						<br>操作备注(<span id="authmemoSpan">0/200</span>)：
						<textarea class="base-textArea" onkeyup="$_showWarnWhenOverLen1(this,200,'authmemoSpan')" id="auditMemo" name="auditMemo" rows="7" cols="45" valid errorMsg="请输入审批意见。"></textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>