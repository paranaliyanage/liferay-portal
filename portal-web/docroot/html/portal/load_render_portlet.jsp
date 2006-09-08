<%
/**
 * Copyright (c) 2000-2006 Liferay, LLC. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
%>

<%@ include file="/html/portal/init.jsp" %>

<%
Portlet portlet = (Portlet)request.getAttribute(WebKeys.RENDER_PORTLET);

String columnId = (String)request.getAttribute(WebKeys.RENDER_PORTLET_COLUMN_ID);
Integer columnPos = (Integer)request.getAttribute(WebKeys.RENDER_PORTLET_COLUMN_POS);
Integer columnCount = (Integer)request.getAttribute(WebKeys.RENDER_PORTLET_COLUMN_COUNT);

String namespace = PortalUtil.getPortletNamespace(portlet.getPortletId());
%>

<c:choose>
	<c:when test="<%= portlet.getRenderWeight() >= 1 %>">
		<liferay-util:include page="/html/portal/render_portlet.jsp" />
	</c:when>
	<c:otherwise>
		<div id="p_load<%= namespace %>">
		</div>

		<script type="text/javascript">
			var <%= namespace %>returnPortlet =
				function (xmlHttpReq) {
					var addDiv = document.createElement("div");

					addDiv.innerHTML = xmlHttpReq.responseText;

					var portletDiv = document.getElementById("p_load<%= namespace %>");

					portletDiv.insertBefore(addDiv, null);

					var portletBound = getElementByClassName(addDiv, "portlet-boundary");

					portletBound.portletId = "<%= portlet.getPortletId() %>";

					var handle = DragDrop.findHandle(portletBound);

					DragDrop.makeItemDragable(portletBound, handle);

					executeLoadedScript(portletBound);
				};

			function <%= namespace %>loadPortlet() {
				var path = "/c/portal/render_portlet";
				var queryString = "p_l_id=<%= plid %>&p_p_id=<%= portlet.getPortletId() %>&p_p_action=0&p_p_state=normal&p_p_mode=view&p_p_col_id=<%= columnId %>&p_p_col_pos=<%= columnPos %>&p_p_col_count=<%= columnCount %>";

				loadPage(path, queryString, <%= namespace %>returnPortlet);
			}

			<%= namespace %>loadPortlet();
		</script>
	</c:otherwise>
</c:choose>