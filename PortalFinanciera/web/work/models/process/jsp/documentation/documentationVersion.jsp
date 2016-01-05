<%-- 
    Document   : versions
    Created on : 24/04/2014, 09:00:53 AM
    Author     : carlos.alvarez
--%>

<%@page import="org.semanticwb.process.documentation.resources.SWPDocumentationResource"%>
<%@page import="org.semanticwb.SWBPlatform"%>
<%@page import="org.semanticwb.SWBPortal"%>
<%@page import="org.semanticwb.model.User"%>
<%@page import="org.semanticwb.model.WebPage"%>
<%@page import="org.semanticwb.model.Resource"%>
<%@page import="java.util.Iterator"%>
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
    String uridi = request.getParameter("uridi") != null ? request.getParameter("uridi") : "";
    String idp = request.getParameter("idp") != null ? request.getParameter("idp") : "";
    WebSite site = paramRequest.getWebPage().getWebSite();
    Process process = Process.ClassMgr.getProcess(idp, site);
    String lang = "es";
    Locale loc = new Locale(lang);
    DateFormat sdf = new SimpleDateFormat("dd MMM yyyy hh:mm:ss", loc);
    SWBResourceURL urlRemove = paramRequest.getActionUrl().setCallMethod(SWBResourceURL.Call_DIRECT).setAction(SWPDocumentationResource.ACTION_REMOVE_VERSION).setParameter("idp", idp);
    SWBResourceURL urlActive = paramRequest.getActionUrl().setCallMethod(SWBResourceURL.Call_DIRECT).setAction(SWPDocumentationResource.ACTION_ACTIVE_VERSION).setParameter("idp", idp);
    String cont = request.getParameter("cont") != null ? request.getParameter("cont") : "";
    SWBResourceURL urlDesc = paramRequest.getRenderUrl().setCallMethod(SWBResourceURL.Call_DIRECT).setMode(SWPDocumentationResource.MODE_VIEW_DESCRIPTION).setParameter("uridi", uridi);
    urlDesc.setParameter("idp", idp);

    String remove = request.getParameter("remove") != null ? request.getParameter("remove") : "";
if (!cont.equals("1")){
%>
<div id="modalDialogDoc">
    <%}%>
<hr>
    <div class="panel panel-default swbp-panel-head">
        <div class="panel-heading text-center"><i class="fa fa-check-square-o"></i>Versiones de: <%= process.getTitle() != null ? process.getTitle() : ""%></div>
    </div>


                        <%
                            if (process != null) {
                                int i = 1;
                                Iterator<Documentation> it = SWBComparator.sortByCreated(Documentation.ClassMgr.listDocumentationByProcess(process), true);
                                while (it.hasNext()) {
                                    Documentation documentation = it.next();
                                    String desc = documentation.getDescription() != null ? documentation.getDescription() : "";
                                    String created = documentation.getCreated() != null ? sdf.format(documentation.getCreated()) : "";
                        %>
                        <div class="swbp-list-element">
                            <div class="col-lg-7 col-md-7 col-sm-9 col-xs-12 swbp-list-title">
                                <div class="col-lg-1 col-md-1 col-sm-1 col-xs-2 swbp-list-number"><%=i%></div>
                                <div class="col-lg-11  col-md-11 col-sm-11 col-xs-10 swbp-list-text">
                                 <%=created%>
                                </div>
                            </div>
                            
                            <div class="col-lg-5 col-md-5 col-sm-3 col-xs-12 swbp-list-action">
                                <a onclick="showModal('<%=urlDesc.setParameter("uriDoc", documentation.getURI())%>','<%=paramRequest.getLocaleString("btnAddElement")%>','<%=paramRequest.getLocaleString("msgLoadingElement")%>','<%=paramRequest.getLocaleString("msgLoadError")%>', 'modalDialog');"  
                                   class="col-lg-4 col-md-4 col-sm-4 col-xs-4 btn btn-default" role="button">
                                    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 fa fa-eye"></div>
                                    <div class="col-lg-8 col-md-8 hidden-sm hidden-xs swbp-list-action-text">VER</div>
                                </a>
                    
                                   <a class="col-lg-4 col-md-4 col-sm-4 col-xs-4 btn btn-default">
                                    <div class="col-lg-4 col-md-4 col-sm-12">
                                        <input <%if(documentation.isActualVersion()) {%> checked="checked"<%}%> onchange="submitUrl('<%= urlActive.setParameter("uridoc", documentation.getURI())%>', 'modalDialogDoc');" id="<%=i%>" type="radio" class="css-checkbox" 
                                             name=activar"> 
                                       <label class="css-label" for="<%=i%>">
                                        </label>
                                    </div>
                                    <div class="col-lg-8 col-md-8 hidden-sm hidden-xs swbp-list-action-text">ACTIVAR</div>
                                </a>
                                    <a <%if(documentation.isActualVersion()) {%> disabled="disabled" <%}%> onclick="if (!confirm('Eliminar versión?'))
                                                return false; 
                                                submitUrl('<%= urlRemove.setParameter("uridoc", documentation.getURI()).setParameter("cont","1")%>', 'modalDialogDoc');" 
                                       class="col-lg-4 col-md-4 col-sm-4 col-xs-4 btn btn-default">
                                        <div class="col-lg-4 col-md-4 col-sm-12 fa fa-trash-o"></div>
                                        <div class="col-lg-8 col-md-8 hidden-sm hidden-xs swbp-list-action-text">ELIMINAR</div>
                                    </a>
                            </div>  
                        </div>
                        <% i++;}
                            }
                        %>

                        <div class="form-group" id="guardaVersion"></div>

<script src="<%= SWBPortal.getWebWorkPath() %>/models/<%= site.getId() %>/js/documenter.js"></script>
<%if (!cont.equals("1")){%>
</div>
<%}%>