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
<c:if test="${! empty image}">
    <template:module path='${image.path}' editable='false' view='hidden.contentURL' var="imageUrl"/>
    <template:module path='${image.path}' editable='false' view='hidden.imageSize' var="imageSize"/>
</c:if>
<c:set var="caption" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="itemWidth" value="${currentNode.parent.properties['itemWidth'].string}"/>
<c:set var="videoID" value="${currentNode.properties['videoId'].string}"/>
<c:set var="videoSource" value="${currentNode.properties['videoService'].string}"/>
<c:set var="rand">
    <%= java.lang.Math.round(java.lang.Math.random() * 10000) %>
</c:set>
<c:set var="modalId" value="modal-${rand}"/>

<!-- Grid column -->

<!--Modal: Name-->
<div class="modal fade" id="${modalId}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <!--Content-->
        <div class="modal-content">
            <!--Body-->
            <div class="modal-body mb-0 p-0">
                <c:choose>
                    <c:when test="${fn:toLowerCase(videoSource) == 'vimeo'}">
                        <c:set var="videoURL" value="https://player.vimeo.com/video/${videoID}"/>
                    </c:when>
                    <c:when test="${fn:toLowerCase(videoSource) == 'wistia'}">
                        <c:set var="videoURL" value="https://fast.wistia.net/embed/iframe/${videoID}"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="videoURL" value="https://www.youtube.com/embed/${videoID}"/>
                    </c:otherwise>
                </c:choose>
                <div class="embed-responsive embed-responsive-16by9 z-depth-1-half">
                    <iframe class="embed-responsive-item" src="${videoURL}"
                            allowfullscreen></iframe>
                </div>

            </div>
            <!--Footer-->
            <div class="modal-footer justify-content-center">

                <button type="button" class="btn btn-outline-primary btn-rounded btn-md ml-4" data-dismiss="modal">
                    Close
                </button>
            </div>
        </div>
        <!--/.Content-->
    </div>
</div>
<!--Modal: Name-->
<div class="thumb">
    <a class="video-thumbnail ">
        <c:choose>
            <c:when test="${not empty image.url}">
                <img class="img-fluid thumb zoom"
                     src="${image.url}"
                     itemprop="thumbnail"
                     alt="${caption}"
                     style="width: ${itemWidth}px"
                     data-toggle="modal"
                     data-target="#${modalId}"/>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${fn:toLowerCase(videoSource) == 'vimeo'}">
                        <img class="img-fluid thumb zoom"
                             srcset="https://vumbnail.com/${videoID}.jpg 640w, https://vumbnail.com/${videoID}_large.jpg 640w, https://vumbnail.com/${videoID}_medium.jpg 200w, https://vumbnail.com/${videoID}_small.jpg 100w"
                             sizes="(max-width: 640px) 100vw, 640px"
                             src="https://vumbnail.com/${videoID}.jpg"
                             itemprop="thumbnail" alt="${caption}"
                             style="width: ${itemWidth}px"
                             data-toggle="modal"
                             data-target="#${modalId}"/>
                    </c:when>
                    <c:when test="${fn:toLowerCase(videoSource) == 'wistia'}">
                        <img class="img-fluid thumb zoom"
                             data-src="${videoID}"
                             id="wistia-thumbnail-${videoID}"
                             itemprop="thumbnail" alt="${caption}"
                             style="width: ${itemWidth}px"
                             data-toggle="modal"
                             data-target="#${modalId}"/>

                    </c:when>
                    <c:otherwise>

                        <img class="img-fluid thumb zoom"
                             src="https://img.youtube.com/vi/${videoID}/maxresdefault.jpg"
                             itemprop="thumbnail"
                             alt="${caption}"
                             style="width: ${itemWidth}px"
                             data-toggle="modal"
                             data-target="#${modalId}"/>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>

        </c:choose>
        <figcaption class="figure-caption">${caption}</figcaption>
    </a>
</div>
<!-- Grid column -->

<script>
    $(document).ready(function () {
        //https://wistia.com/support/developers/oembed
        const wistiaID = $("#wistia-thumbnail-${videoID}").data("src");
        const wistiaWidth = 640;
        // iframe, async, async_popover, playlist_iframe, playlist_api, playlist_popver, and open_graph_tag
        const wistiaType = "async_popover";
        const popoverWidth = 640;
        const popoverHeight = 350;
        $.get(
            "https://fast.wistia.net/oembed?url=http://home.wistia.com/medias/" +
            wistiaID + "?embedType="+wistiaType+"&videoWidth=900&popoverWidth="+popoverWidth+"&popoverHeight="+popoverHeight,
            function (data) {
                console.log(data); // HTML content of the jQuery.ajax page

                thumbnail_url =
                    data.thumbnail_url + "&" + "image_resize=" + wistiaWidth;
                $("#wistia-thumbnail-${videoID}").attr("src", thumbnail_url);
                $("#wistia-embed").html(data.html);
            }
        );
    });

    $(function(){
        $('#${modalId}').on('hidden.bs.modal', function (e) {
            $iframe = $(this).find("iframe");
            $iframe.attr("src", $iframe.attr("src"));
        });
    });
</script>