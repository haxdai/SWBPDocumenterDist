<%@page import="org.semanticwb.portal.SWBFormMgr"%>
<%@page import="org.semanticwb.model.SWBComparator"%>
<%@page import="org.semanticwb.portal.resources.sem.forum.Post"%>
<%@page import="org.semanticwb.SWBUtils"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.semanticwb.SWBPlatform"%>
<%@page import="org.semanticwb.platform.SemanticObject"%>
<%@page import="org.semanticwb.model.User"%>
<%@page import="org.semanticwb.portal.resources.sem.forum.Thread"%>
<%@page import="org.semanticwb.portal.api.SWBResourceURL"%>
<%@page import="org.semanticwb.model.WebSite"%>
<%@page import="org.semanticwb.SWBPortal"%>
<%@page import="org.semanticwb.portal.resources.sem.forum.SWBForum"%>
<%@page import="org.semanticwb.model.Resource"%>
<%@page import="org.semanticwb.model.WebPage"%>
<%@page import="java.util.Comparator"%>
<jsp:useBean id="paramRequest" scope="request" type="org.semanticwb.portal.api.SWBParamRequest"/>
<!--
<style type="text/css">
* {
	margin: 0px;
	padding: 0px;
	font-size: 100%;
	vertical-align: baseline;
}

body {
	font-family: Arial, Helvetica, sans-serif;
	background-repeat: no-repeat;
}
p {margin-bottom: 10px; color: #626262;	font-size: 0.7em;}
a {text-decoration: none;}
a:hover {text-decoration: underline;}
</style>
-->
<%
WebPage webpage = paramRequest.getWebPage();
WebSite website = webpage.getWebSite();
Resource base = paramRequest.getResourceBase();

SWBForum oforum=(SWBForum)SWBPortal.getResourceMgr().getResource(base);

SWBResourceURL urlthread = paramRequest.getRenderUrl();
SWBResourceURL url = paramRequest.getRenderUrl();
SWBResourceURL urlRemovePost = paramRequest.getRenderUrl();
SWBResourceURL actionURL = paramRequest.getActionUrl();

String lang = "es";
User user = paramRequest.getUser();
if (user != null && user.getLanguage() != null) lang = user.getLanguage();

boolean acceptguesscomments=false;
if(request.getAttribute("acceptguesscomments")!=null) acceptguesscomments=(Boolean)request.getAttribute("acceptguesscomments");

boolean isforumAdmin = user.hasRole(oforum.getAdminRole());
String action = paramRequest.getAction();

%>
<div class="container">
    <div class="col-lg-10 col-lg-offset-1">
        <!--div class="panel panel-default swbp-panel"-->
            <!--div class="panel-heading swbp-panel-title">
                <div class="panel-title">
                    <h1 class="panel-title">
                        <span class="fa fa-bullhorn"></span> Blog
                    </h1-->
                    <div class="row text-right">
                        <ul class="list-unstyled list-inline">
                            <li><a href="<%=webpage.getParent().getUrl(lang)%>" class="btn btn-default swbp-btn-action" title="Herramientas de colaboración"><span class="fa fa-reply fa-fw"></span>Herramientas de colaboración</a></li>
                            <%
                            if(!oforum.isOnlyAdminCreateThreads() || isforumAdmin){
                                if(user!=null && user.isRegistered()){
                                    urlthread.setMode("addThread");
                                    %>
                                        <li><a href="<%=urlthread%>" class="btn btn-default swbp-btn-action" title="Agregar entrada"><span class="fa fa-plus fa-fw"></span>Agregar entrada</a></li>
                                    <%
                                }
                            }
                            %>
                        </ul>
                    </div>
                <!--/div-->
            <!--/div-->
            <!--div class="panel-body"-->
                <%
                if (action != null && action.equals("viewPost")) {
                    String autor = "";
                    Thread thread = (Thread) SWBPlatform.getSemanticMgr().getOntology().getGenericObject(request.getParameter("threadUri"));
                    if(request.getParameter("addView")!=null) thread.setViewCount(thread.getViewCount() + 1);
                    
                    url.setParameter("threadUri", thread.getURI());
                    urlRemovePost.setParameter("threadUri", thread.getURI());
                    urlthread.setParameter("threadUri", thread.getURI());
                    urlthread.setMode("addThread");
                    boolean isTheAuthor=false;
                    if (thread.getCreator() != null) {
                        autor = thread.getCreator().getFullName();
                        if(thread.getCreator().getURI().equals(user.getURI())) isTheAuthor=true;
                    }
                    %>
                    <div class="row">
                        <div class="panel panel-default swbp-panel">
                            <div class="panel-heading swbp-panel-title">
                                <div class="panel-title">
                                    <h1 class="panel-title">
                                        <strong><%=thread.getDisplayTitle(lang)%></strong>
                                        <%
                                        if (isTheAuthor || isforumAdmin) {
                                            actionURL.setAction("removeThread");
                                            actionURL.setParameter("threadUri", thread.getURI());
                                            %>
                                            <div class="pull-right">
                                                <a href="<%=paramRequest.getRenderUrl().setMode("view")%>" class="btn btn-success fa fa-reply" title="Volver al blog"></a>
                                                <a href="<%=urlthread.setMode("editThread")%>" class="btn btn-success fa fa-pencil" title="Editar"></a>
                                                <a onclick="if (!confirm('¿Está seguro de querer eliminar la entrada?')) return false;" href="<%=actionURL%>" class="btn btn-success fa fa-trash-o" title="Eliminar"></a>
                                            </div>
                                            <%
                                        }
                                        %>
                                    </h1>
                                </div>
                            </div>
                            <div class="panel-body">
                                <ul class="list-group">
                                    <li class="list-group-item">
                                        <%=SWBUtils.TEXT.replaceAll(thread.getBody(),"\n","<br>")%>
                                    </li>
                                </ul>
                                <%
                                
                                if ((user != null && user.isRegistered()) || acceptguesscomments) {
                                    SWBFormMgr mgr = new SWBFormMgr(Post.frm_Post, thread.getSemanticObject(), null);
                                    actionURL.setParameter("threadUri", thread.getURI());
                                    actionURL.setAction("replyPost");
                                    %>
                                    <div class="row">
                                        <h5><strong>Deje un comentario</strong></h5><br>
                                        <hr>
                                        <form class="form-horizontal" method="post" action="<%=actionURL%>" id="formSavePost">
                                        <%=mgr.getFormHiddens()%>
                                            <div class="form-group" id="div<%=Post.frm_pstBody.getName()%>">
                                                <label for="" class="col-lg-2 control-label"><%=Post.frm_pstBody.getDisplayName()%> *:</label>
                                                <div class="col-lg-10">
                                                    <%
                                                    String inputfm = mgr.renderElement(request, Post.frm_pstBody, SWBFormMgr.MODE_CREATE);
                                                    inputfm = inputfm.replaceFirst(">", " required class=\"form-control\">");
                                                    inputfm = inputfm.replace(inputfm.substring(inputfm.indexOf("style"), (inputfm.indexOf("px;\"") + 4)), "");
                                                    out.println(inputfm);
                                                    %>
                                                </div>
                                            </div>
                                            <div class="panel-footer text-right">
                                                <button id="saveForm" class="btn btn-success" type="submit"><span class="fa fa-save fa-fw"></span><%=paramRequest.getLocaleString("send")%></button>
                                            </div>
                                        </form>
                                        <%
                                        out.print(SWBForum.getScriptValidator("saveForm", "formSavePost"));
                                        %>
                                    </div>
                                    <%
                                }
                                
                                if (thread.getReplyCount() > 0) {
                                    String photo=SWBPlatform.getContextPath()+"/swbadmin/images/defaultPhoto.png";
                                    %>
                                    <br>
                                    <ul class="list-group">
                                        <li class="list-group-item active">
                                            <span class="fa fa-comment fa-fw"></span><strong>Comentarios (<%=thread.getReplyCount()%>)</strong>
                                        </li>
                                            <%
                                            Iterator<Post> itPost = SWBComparator.sortByCreated(thread.listPosts(),false);
                                            while (itPost.hasNext()) {
                                                Post post = itPost.next();
                                                url.setParameter("postUri", post.getURI());
                                                urlRemovePost.setParameter("postUri", post.getURI());

                                                User userPost = null;
                                                String postCreator = "Anonimo";
                                                isTheAuthor=false;
                                                if (post.getCreator() != null) {
                                                    userPost = post.getCreator();
                                                    postCreator = post.getCreator().getFullName();
                                                    if(post.getCreator().getPhoto()!=null) photo=SWBPortal.getWebWorkPath()+post.getCreator().getPhoto();
                                                    if(post.getCreator().getURI().equals(user.getURI())) isTheAuthor=true;
                                                }
                                                %>
                                                <li class="list-group-item">
                                                    <div class="row">
                                                        <p class="text-right">
                                                            <strong><%=postCreator%></strong> - <%=SWBUtils.TEXT.getTimeAgo(post.getUpdated(), lang)%>
                                                        </p>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-1">
                                                            <span class="fa fa-user fa-3x img_ReplyForo"></span>
                                                        </div>
                                                        <div class="col-lg-11">
                                                            <p>
                                                                <%=post.getBody()%>
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <%
                                                    if (isTheAuthor || isforumAdmin) {
                                                        urlthread.setParameter("postUri", post.getURI());
                                                        actionURL.setAction("removePost");
                                                        actionURL.setParameter("threadUri", thread.getURI());
                                                        actionURL.setParameter("postUri", post.getURI());
                                                        %>
                                                        <div class="row text-right">
                                                            <a href="<%=urlthread.setMode("editPost")%>" class="btn btn-default"><span class="fa fa-pencil fa-fw"></span>Editar</a>
                                                            <a onclick="if (!confirm('¿Está seguro de querer eliminar el comentario?')) return false;" href="<%=actionURL%>" class="btn btn-default"><span class="fa fa-trash-o fa-fw"></span>Eliminar</a>
                                                        </div>
                                                        <%
                                                    }
                                                    %>
                                                </li>
                                                <%
                                            }
                                            %>
                                    </ul>
                                    <%
                                }
                                %>
                            </div>
                        </div>
                    </div>
                    <%
                } else {
                    url.setMode(url.Mode_VIEW);
                    url.setAction("viewPost");
                    url.setParameter("addView", "1");
                    String autor = "";
                    
                    TreeSet<Thread> treeSet=new TreeSet(new Comparator() {
                        public int compare(Object o1, Object o2) {
                            Thread ob1 = (Thread) (o1);
                            Thread ob2 = (Thread) (o2);
                            int ret=-1;
                            if(ob1.getLastPostDate()!=null && ob2.getLastPostDate()!=null) {
                                ret=ob1.getLastPostDate().after(ob2.getLastPostDate())? -1 : 1;
                            }
                            return ret;
                        }
                    });
                    
                    Iterator<WebPage> itThreads = webpage.listChilds(lang, null, false, null, null, false);
                    if (itThreads.hasNext()) {
                        while (itThreads.hasNext()) {
                            WebPage wp = itThreads.next();
                            //System.out.println("treeSet:"+treeSet+" "+wp);
                            if(wp!=null && wp instanceof Thread)
                            {
                                treeSet.add((Thread)wp);
                            }
                        }
                        
                        Iterator<Thread> itThreads2 = treeSet.iterator();
                        while (itThreads2.hasNext()) {
                            Thread thread = itThreads2.next();
                            SWBForum forum = thread.getForum();
                            if (forum.getId().equals(base.getId())) {
                                url.setParameter("threadUri", thread.getURI());
                                if (thread.getCreator() != null) {
                                    autor = thread.getCreator().getFullName();
                                }
                                
                                String title = thread.getDisplayTitle(lang);
                                if (title == null) title = "--";
                                %>
                                <div class="row">
                                    <div class="panel panel-default swbp-panel">
                                        <div class="panel-heading swbp-panel-title">
                                            <div class="panel-title">
                                                <h1 class="panel-title"><strong><%=title%></strong></h1>
                                            </div>
                                            <div class="pull-right">
                                                <span class="visible-lg visible-md">Por <strong><%=autor%></strong> el <%=SWBUtils.TEXT.getStrDate(thread.getCreated(),lang, "dd/mm/yyyy - hh:mm:ss")%></span>
                                            </div>
                                        </div>
                                        <div class="panel-body">
                                            <%
                                            if(oforum.isShowThreadBody()){
                                                String body = SWBUtils.TEXT.replaceAll(thread.getBody(),"\n","<br>");
                                                if (body.length() > 300) {
                                                    body = SWBUtils.TEXT.cropText(body, 600);
                                                }
                                                %>
                                                <p><%=body%></p>
                                                <%
                                                if (body.length() > 600) {
                                                    %>
                                                    <a class="swbp-blog-continuar" href="<%=url%>" title="Continuar leyendo">Continuar leyendo</a>
                                                    <%
                                                }
                                            }
                                            %>
                                        </div>
                                        <div class="panel-footer text-right">
                                            <%
                                            String cssClass = "fa fa-comments-o";
                                            if (thread.getReplyCount() > 0) {
                                                cssClass = "fa fa-comments";
                                            }
                                            %>
                                            <a href="<%=url%>" title="Ver comentarios"><span class="<%=cssClass%> fa-fw"></span><%=thread.getReplyCount()%> comentarios</a> | <span class="fa fa-eye fa-fw"></span><%=thread.getViewCount()%> vistas
                                        </div>
                                    </div>
                                </div>
                                <%
                            }
                        }
                    } else {
                        %>
                        <div class="alert alert-warning">
                            No hay entradas en este blog
                        </div>
                        <%
                    }
                }
                %>
            <!--/div-->
        <!--/div-->
    </div>
</div>