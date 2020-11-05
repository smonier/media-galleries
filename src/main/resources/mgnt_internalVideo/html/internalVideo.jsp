<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<c:set var="image" value="${currentNode.properties['videoPoster'].node}"/>
<template:module path='${image.url}' editable='false' view='hidden.contentURL' var="imageUrl"/>

<c:set var="caption" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="itemWidth" value="${currentNode.parent.properties['itemWidth'].string}"/>
<c:set var="rand">
    <%= java.lang.Math.round(java.lang.Math.random() * 10000) %>
</c:set>
<c:set var="modalId" value="modal-${rand}"/>
<template:module path='${currentNode.properties.video.node.path}' editable='false' view='hidden.contentURL'
                 var="videoURL"/>


<!-- Grid column -->

<!--Modal: Name-->
<div class="modal fade" id="${modalId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <!--Content-->
        <div class="modal-content">
            <!--Body-->
            <div class="modal-body mb-0 p-0">
                <video id="" class="img-fluid" width="100%" controls poster="${image.url}">
                    <source src="${currentNode.properties.video.node.url}" type="video/mp4">
                </video>
            </div>
            <!--Footer-->
            <div class="modal-footer justify-content-center">
                <span class="mr-4">Spread the word!</span>
                <a type="button" class="btn-floating btn-sm btn-fb"><i class="fa fa-facebook"></i></a>
                <!--Twitter-->
                <a type="button" class="btn-floating btn-sm btn-tw"><i class="fa fa-twitter"></i></a>
                <!--Google +-->
                <a type="button" class="btn-floating btn-sm btn-gplus"><i class="fa fa-google"></i></a>
                <!--Linkedin-->
                <a type="button" class="btn-floating btn-sm btn-ins"><i class="fa fa-linkedin"></i></a>

                <button type="button" class="btn btn-outline-primary btn-rounded btn-md ml-4" data-dismiss="modal">
                    Close
                </button>
            </div>
        </div>
        <!--/.Content-->
    </div>
</div>
<!--Modal: Name-->
<a class="video-thumbnail">
    <img class="img-fluid z-depth-1 rounded" src="${image.url}" itemprop="thumbnail" alt="${caption}"
         style="width: ${itemWidth}px" data-toggle="modal" data-target="#${modalId}"/>
    <figcaption class="figure-caption">${caption}</figcaption>
</a>

<!-- Grid column -->
