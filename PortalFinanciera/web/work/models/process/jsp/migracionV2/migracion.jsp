<%-- 
    Document   : migracion
    Created on : 5/02/2015, 11:33:40 AM
    Author     : carlos.alvarez
--%>

<%@page import="org.semanticwb.process.documentation.model.DocumentSectionInstance"%>
<%@page import="org.semanticwb.model.SWBComparator"%>
<%@page import="org.semanticwb.process.documentation.model.DocumentationInstance"%>
<%@page import="org.semanticwb.platform.SemanticObject"%>
<%@page import="org.semanticwb.process.documentation.model.TemplateContainer"%>
<%@page import="org.semanticwb.SWBPlatform"%>
<%@page import="org.semanticwb.platform.SemanticProperty"%>
<%@page import="org.semanticwb.model.WebSite"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.semanticwb.process.documentation.model.DocumentTemplate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link href="/swbadmin/css/bootstrap/bootstrap.css" rel="stylesheet"/>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="panel-title">Migración de Plantillas</div>
        </div>
        <%
            WebSite model = WebSite.ClassMgr.getWebSite("process");
            if (model != null) {
                Iterator<DocumentTemplate> it = DocumentTemplate.ClassMgr.listDocumentTemplates(model);
        %>
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Plantilla</th>
                            <th>Container</th>
                            <th>Procesos asignados</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            while (it.hasNext()) {
                                DocumentTemplate dt = it.next();
                                //Obtener el TemplateContainer
                                TemplateContainer tc = dt.getTemplateContainer();
                                if (tc == null) {
                                    //Si no tiene TemplateContainer , crear.
                                    tc = TemplateContainer.ClassMgr.createTemplateContainer(model);
                                    tc.setTitle(dt.getTitle());
                                    tc.addTemplate(dt);
                                    tc.setActualTemplate(dt);
                                    tc.setLastTemplate(dt);
                                    dt.setTemplateContainer(tc); //Asignar a DocumentTemplate su TemplateContainer
                                }
                                //Listar los procesos asignados a DocumentTemplate
                                Iterator<SemanticObject> itso = dt.getSemanticObject().listObjectProperties(TemplateContainer.swpdoc_hasProcess);
                        %> <tr>
                            <td><%= dt%></td> 
                            <td><%= dt.getTemplateContainer()%></td> 
                            <td>
                                <%
                                    while (itso.hasNext()) {
                                        SemanticObject so = itso.next();
                                        String title = "";
                                        if (tc != null && so != null) {
                                            org.semanticwb.process.model.Process p = (org.semanticwb.process.model.Process) so.createGenericInstance();
                                            title = p != null ? p.toString() : "Error al obtener proceso";
                                            if (p != null && !tc.hasProcess(p)) {
                                                //Si existe el proceso y no ha sido asignado al TemplateContainer, se agrega.
                                                tc.addProcess(p);
                                                //Al agregar Process al TemplateContainer, Remover del DocumentTemplate.
                                                dt.getSemanticObject().removeProperty(TemplateContainer.swpdoc_hasProcess);
                                                //dt.getSemanticObject().removeObjectProperty(TemplateContainer.swpdoc_hasProcess, so);
                                            }
                                        }
                                %>
                                <br><%= title%>
                                <% } %>
                            </td> 
                        </tr> 
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        <%
            }
        %>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="panel-title">La estructura</div>
        </div>
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>TemplateContainer</th>
                            <th>DocumentTemplate</th>
                            <th>Procesos asignados</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Iterator<TemplateContainer> it = TemplateContainer.ClassMgr.listTemplateContainers(model);
                            while (it.hasNext()) {
                                TemplateContainer tc = it.next();
                        %>
                        <tr>
                            <td><%= tc%></td>
                            <td><%= tc.getActualTemplate() != null ? tc.getActualTemplate().getId() : "No tiene DocumentTemplate"%></td>
                            <td>
                                <%
                                    Iterator<org.semanticwb.process.model.Process> itp = tc.listProcesses();
                                    int i = 0;
                                    while (itp.hasNext()) {
                                        org.semanticwb.process.model.Process p = itp.next();
                                        out.print("<br>process : " + p);
                                        Iterator<TemplateContainer> ittc = TemplateContainer.ClassMgr.listTemplateContainerByProcess(p);
                                        if (ittc.hasNext()) {
                                            //Traer datos
                                            TemplateContainer tca = ittc.next();
                                            out.print("<br>tca : " + tca);
                                            DocumentationInstance di = DocumentationInstance.getDocumentationInstanceByProcess(p, tc);
                                            out.print("<br><br>di : " + di);
                                            out.print("<br>di : " + di.getCreated());
                                            out.print("<br>dt: " + di.getDocTypeDefinition().getId());
                                            Iterator<DocumentSectionInstance> itdsi = SWBComparator.sortSortableObject(di.listDocumentSectionInstances());//Regerar código para ordenamiento
                                            while (itdsi.hasNext()) {
                                                DocumentSectionInstance dsi = itdsi.next();
                                                out.print("<br>dsi : " + dsi);
                                                out.print("<br>dsi : " + dsi.getCreated());
                                            }
                                        }
                                        if (i > 4) {
                                            break;
                                        }
                                        i++;
                                    }
                                %>
                            </td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>