<%-- 
    Document   : versions
    Created on : 02/12/2015, 11:00:53 AM
    Author     : ana.garcia
--%>

<%@page import="org.semanticwb.process.documentation.resources.SWPDocumentationResource"%>
<%@page import="org.semanticwb.SWBPlatform"%>
<%@page import="org.semanticwb.model.User"%>
<%@page import="org.semanticwb.model.WebPage"%>
<%@page import="org.semanticwb.model.Resource"%>
<%@page import="org.semanticwb.model.SWBComparator"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="org.semanticwb.portal.api.SWBResourceURL"%>
<%@page import="org.semanticwb.process.documentation.model.Documentation"%>
<%@page import="org.semanticwb.portal.SWBFormMgr"%>
<%@page import="org.semanticwb.portal.api.SWBParamRequest"%>
<%@page import="org.semanticwb.process.model.Process"%>
<%@page import="org.semanticwb.model.WebSite"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    SWBParamRequest paramRequest = (SWBParamRequest) request.getAttribute("paramRequest");
    String idp = request.getParameter("idp") != null ? request.getParameter("idp") : "";
    String uriDoc = request.getParameter("uriDoc") != null ? request.getParameter("uriDoc") : "";
    WebSite site = paramRequest.getWebPage().getWebSite();
    Process process = Process.ClassMgr.getProcess(idp, site);
    String lang = "es";
    Locale loc = new Locale(lang);
    DateFormat sdf = new SimpleDateFormat("dd MMM yyyy hh:mm:ss", loc);
%>
<div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title"><i class="fa fa-check-square-o"></i><%= process.getTitle() != null ? process.getTitle() : ""%></h4>
        </div>
        <div class="modal-body">
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Descripción</th>
                            <th>Creación</th>
                        </tr>
                    </thead>
                    <tbody id="tbVersions"> 
                        <%
                            if (process != null) {
                                Documentation documentation = (Documentation) SWBPlatform.getSemanticMgr().getOntology().getGenericObject(uriDoc);
                                String desc = documentation.getDescription() != null ? documentation.getDescription() : "";
                                String created = documentation.getCreated() != null ? sdf.format(documentation.getCreated()) : "";
                        %>
                        <tr>
                            <td><%= desc%></td>
                            <td><%= created%></td>
                        </tr>   
                        <% }
                        %>
                    </tbody>
                </table>
            </div>
            <br>
        </div>
        <div class="modal-footer text-right">
            <button type="button" class="btn btn-default" data-dismiss="modal"><%=paramRequest.getLocaleString("btnClose")%></button>
        </div>
    </div>
</div>
