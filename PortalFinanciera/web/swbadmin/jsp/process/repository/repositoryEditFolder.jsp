<%-- 
    Document   : repositoryEditFolder
    Created on : 1/06/2015, 05:41:28 PM
    Author     : Ana Laura Garcia <ana.garcias@infotec.mx>
--%>

<%@page import="org.semanticwb.process.resources.ProcessFileRepository"%>
<%@page import="org.semanticwb.portal.api.SWBResourceURL"%>
<%@page import="org.semanticwb.model.Traceable"%>
<%@page import="org.semanticwb.model.Descriptiveable"%>
<%@page import="org.semanticwb.process.model.RepositoryDirectory"%>
<%@page import="org.semanticwb.model.GenericObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.semanticwb.model.VersionInfo"%>
<%@page import="org.semanticwb.process.model.RepositoryURL"%>
<%@page import="org.semanticwb.process.model.RepositoryFile"%>
<%@page import="org.semanticwb.model.WebSite"%>
<%@page import="org.semanticwb.process.model.RepositoryElement"%>
<%@page import="org.semanticwb.model.User"%>
<%@page import="org.semanticwb.portal.api.SWBParamRequest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    SWBParamRequest paramRequest = (SWBParamRequest) request.getAttribute("paramRequest");
    SWBResourceURL actionURL = paramRequest.getActionUrl().setCallMethod(SWBResourceURL.Call_DIRECT).setAction(ProcessFileRepository.ACT_EDITFOLDER);   
    User user = paramRequest.getUser();
    WebSite site = paramRequest.getWebPage().getWebSite();
    String lang = "es";
    String action = request.getParameter("action") != null ? request.getParameter("action") : "";
    if (user != null && user.getLanguage() != null) {
        lang = user.getLanguage();
    }

    String fid = request.getParameter("fid");
    String type = request.getParameter("type"); 
    GenericObject re = null;

    if (fid != null && type != null) {
        if ("file".equals(type)) {
            re = RepositoryFile.ClassMgr.getRepositoryFile(fid, site);
        } else if ("url".equals(type)) {
            re = RepositoryURL.ClassMgr.getRepositoryURL(fid, site);
        } else {
            re = RepositoryDirectory.ClassMgr.getRepositoryDirectory(fid, site);
        }
    }   

    if (!user.isSigned()) {
        if (paramRequest.getCallMethod() == SWBParamRequest.Call_CONTENT) {
%>

<div class="alert alert-block alert-danger fade in">
    <h4><span class="fa fa-ban"></span> <%=paramRequest.getLocaleString("msgNoAccessTitle")%></h4>
    <p><%=paramRequest.getLocaleString("msgNoAccess")%></p>
    <p>
        <a class="btn btn-default" href="/login/<%=site.getId()%>/<%=paramRequest.getWebPage().getId()%>"><%=paramRequest.getLocaleString("btnLogin")%></a>
    </p>
</div>
<%
    }
} else {
%>
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4><%=paramRequest.getLocaleString("msgAltRenDirectory")%></h4>
        </div>
        <div class="modal-body">
            <%
                if (re == null) {
            %><%                    } else {
            %>
            <form method="post" id="formEditRepository" action="<%=actionURL%>" class="form-horizontal" role="form">
                <div class="form-group">
                    <label class="col-lg-5 control-label"><%=paramRequest.getLocaleString("msgDirName")%></label>
                    <div class="col-lg-7">
                        <input required type="text" name="titleRep" id="titleRep" required errorMsg="Ingresar el título" value="<%=((Descriptiveable) re).getDisplayTitle(lang)%>" class="form-control"/>
                        <span class="help-block" id="sphtitletc"></span>
                    </div>
                        <div id="container">
                </div>
                </div>
                <input type="hidden" id="fid" name="fid" value="<%=fid%>">
                <div class="modal-footer"> 
                    <button type="submit" onclick="submitForm('formEditRepository', 'container', 'modalDialog');
                        return false;"  class="btn btn-success" id="savedtes"><span class="fa fa-save fa-fw"></span><%=paramRequest.getLocaleString("msgBTNSave")%></button>
                    <a href="#" class="btn btn-success" data-dismiss="modal"><%=paramRequest.getLocaleString("lblButtonClose")%></a>
                </div>
            </form>
            <%
                }
            %>
        </div>

    </div>
</div>
<%
    }
%>
<script type="text/javascript">
function submitForm(formid, tagid, tagmodal) {
        $.ajax({
            url: $('#' + formid).attr('action'),
            cache: false,
            data: $('#' + formid).serialize(),
            type: 'POST',
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            success: function(data) {
                $('#' + tagmodal).empty();
                $('#' + tagmodal).append(data);
                $('#'+tagmodal).modal('hide');
                window.location.reload(true);
            },
            error: function(e) {
                alert('error!');
                $('#' + tagid).html(error);
            }
        }); 
}
$(document).ready(function() {
        $('#modalDialog').on('shown.bs.modal', function() {
            $('#titleRep').focus();
        });
    });
</script>