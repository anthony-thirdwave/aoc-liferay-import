import com.liferay.journal.service.*

articles = com.liferay.portlet.journal.service.JournalArticleLocalServiceUtil.getArticles();
last = (articles.size() - 1);
out.println(
    """
    <p style="color: #37A9CC; font-size:smaller; margin-bottom: -80px">[</p>
    """
);
articles.eachWithIndex { article, index ->
    out.println(
        """
        <p style="color: #37A9CC; font-size:smaller; margin-bottom: -50px">&nbsp;&nbsp;{</p>
        <p style="color: #37A9CC; font-size:smaller; margin-bottom: -50px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"articleId":"${article.getArticleId()}",</p>
        <p style="color: #37A9CC; font-size:smaller; margin-bottom: -50px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"urlTitle":"${article.getUrlTitle()}"</p>
        <p style="color: #37A9CC; font-size:smaller; margin-bottom: -80px">&nbsp;&nbsp;}${index == last ? "" : ","}</p>
        """
    );
};
out.println(
    """
    <p style="color: #37A9CC; font-size:smaller; margin-bottom: -50px">]</p>
    """
);