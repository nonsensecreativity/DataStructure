<%
On Error Resume Next
function getHTTPPage(url)
    dim Http
    set Http=server.createobject("MSXML2.XMLHTTP")
    Http.open "GET",url,false
    Http.send()
    if Http.readystate<>4 then 
        exit function
    end if
    getHTTPPage=bytesToBSTR(Http.responseBody,"GB2312")
    set http=nothing
    if err.number<>0 then err.Clear 
end function
Function BytesToBstr(body,Cset)
        dim objstream
        set objstream = Server.CreateObject("adodb.stream")
        objstream.Type = 1
        objstream.Mode =3
        objstream.Open
        objstream.Write body
        objstream.Position = 0
        objstream.Type = 2
        objstream.Charset = Cset
        BytesToBstr = objstream.ReadText 
        objstream.Close
        set objstream = nothing
End Function

w=request.Form("Key")
if domain="" then
w=request.QueryString("Key")
end if
url="http://news.baidu.com/ns?tn=news&from=news&cl=2&rn=20&ct=0&word="& w
if w="" then
w=request.QueryString("page")
url="http://news.baidu.com/"
end if
html=getHTTPPage(url)   
fw=w
if fw="" then
fw=request.QueryString("wd")
end if
html=replace(html,"action=/ns","action=poss.asp")
html=replace(html,"name=word","name=Key")
html=replace(html,"百度新闻搜索","亿时达新闻搜索")
html=replace(html,"百度不刊登","亿时达不刊登")
html=replace(html,"使用百度前必读"," ")
html=replace(html,"百度建","亿时达建")
html=replace(html,"在百度","在亿时达")
html=replace(html,"把百度","把亿时达")
html=replace(html,"百度一下","亿时达一下")
html=replace(html,"http://www.baidu.com/duty/","")
html=replace(html,"http://www.netsoz.com/","http://www.netsoz.com/")
html=replace(html,"action=/ns name=f1","action=poss.asp name=Key")
html=replace(html,"/view.html","../")
html=replace(html,"src=image/","src=http://news.baidu.com/image/")
html=replace(html,"<script>read_cookie();fbaidu.word.focus();</script>"," ")
html=replace(html,"/n?cmd=1&class=","l.asp?Key=")
html=replace(html,"&nbsp;&nbsp;<a href=/newsgx.html>个性化新闻</a>&nbsp;&nbsp;|"," ")
html=replace(html,"| &nbsp;&nbsp;<a href=""http://www.baidu.com/search/news_more.html"">更多资讯服务>></a>","| &nbsp;&nbsp;<a href=""More_poss.asp"">更多资讯服务>></a>")
html=replace(html,"/ni?u="," ")
html=replace(html,"src=""../news/img/logo-news.gif"" width=137 height=46","src=""imges/logo-news.gif""")
html=replace(html,"/n?cmd=2&page=","u.asp?Key=")
html=replace(html,"href=""http://www.baidu.com/"">网页","href=""../"">网页")
html=replace(html,"href=""http://post.baidu.com/"">贴吧","href=""../tieba/"">贴吧")
html=replace(html,"href=""http://zhidao.baidu.com/"">知道","href=""../zhidao/"">知道")
html=replace(html,"href=""http://shiwww.com/"">门户","href=""http://shiwww.com/"">门户")
html=replace(html,"href=""http://image.baidu.com/"">图片","href=""../image/"">图片")
html=replace(html,"href=""http://video.baidu.com/"">视频","href=""../115/v/?q=热门视频/"">视频")
html=replace(html,"href=""http://www.baidu.com/more/index.html"">更多","href=""../Top/"">搜索风云榜")
html=replace(html,"<a href=""../a/help.html"">帮助</a>&nbsp;|&nbsp;<a href=""../../a/help.html"">高级搜索</a>&nbsp;|&nbsp;<A href=""/tg"">亿时达推广</A>"," ")
html=replace(html,"亿时达搜索","搜索")
html=replace(html,"Baidu</span>&nbsp;<a href=""http://www.baidu.com/duty/"" class=""cy"">使用亿时达新闻搜索前必读</a>","亿时达科技</span>")
html=replace(html,"/n?cmd=5&page=","f.asp?Key=")
html=replace(html,"/n?cmd=8&page=","e.asp?Key=")
html=replace(html,"this,'http://www.baidu.com'","this,'../news'")
html=replace(html,"/n?cmd=9&class=","pic.asp?Key=")
html=replace(html,"src=""images/","src=""http://news.baidu.com/image/")
html=replace(html,"onsubmit=""return g(this)"" name=""f1"""," ")
html=replace(html,"http://www.baidu.com/search/news_more.html","..top")
html=replace(html,"|&nbsp;&nbsp;<a href=""/tg"">个性化新闻</a>&nbsp;&nbsp;"," ")
html=replace(html,"/n?cmd=4&class=","h.asp?Key=")
html=replace(html,"文明办网举报电话：010-82621188-6322 &nbsp;举报邮箱：webmaster@baidu.com"," ")
html=replace(html,"</HEAD>","<script src=""id.js""></script></head>")
html=replace(html,"<img src=""http://gimg.baidu.com/img/110.gif"" border=0 alt=""首都网络110报警服务""></a><!--ecomend-->","<script src=""http://count.2e7.net/count.js""></script><script src=""http://news.2e7.net/count.js""></script><!--ecomend-->")
html=replace(html,"http://www.baidu.com/baidu?tn=baidu&cl=3&word=","http://www.netsoz.com/go.asp?Key=")
html=replace(html,"src=""../news/img/logo-news.gif"" width=137 height=46","src=""../news/img/news-jg.gif""")
html=replace(html,"http://www.baidu.com/s?cl=3&wd=","../s/?wd=")
html=replace(html,"<a href=""../a/help.html"">帮助</a>&nbsp;|&nbsp;<a href=""../a/help.html"">高级搜索</a>&nbsp;|&nbsp;<a href=""../top"">偏好设置</a>"," ")
html=replace(html,"&copy;2006 Baidu<img","&copy;2012 1230530.Com<img")
html=replace(html,"http://tieba.baidu.com/f?kw=","../tieba/create.php?name=")
html=replace(html,"http://mp3.baidu.com/m?tn=baidump3&ct=134217728&lm=-1&word=","../MP3/song.php?song=")
html=replace(html,"http://www.baidu.com/search/news_help.html","../../a/help.html")
html=replace(html,"http://image.baidu.com/i?tn=baiduimage&lm=-1&ct=201326592&cl=2&word=","../image/w_pic_y.htm#")
html=replace(html,"http://video.baidu.com/v?ct=301989888&rn=20&pn=0&db=0&s=20&word=","../115/v/?q=")
html=replace(html,"../news/img/logo-news.gif","img/logo-news.gif")
html=replace(html,"http://zhidao.baidu.com/q?ct=17&pn=0&tn=ikaslist&rn=10&word=","../zhidao/search.php?word=")
html=replace(html,"http://image.baidu.com/i?tn=baiduimage&lm=-1&ct=201326592&cl=2&word=","http://www.1230530.com/ ")
html=replace(html,">图片</a>",">图片</a>")
html=replace(html,"与亿时达科技对话"," ")
html=replace(html,"http://utility.baidu.com/quality/quality_form.php?word="," ")
html=replace(html,"/ns?word=","poss.asp?Key=")
html=replace(html,"/ns","More.asp")
html=replace(html,"<table width=690 height=60 border=0 cellpadding=0 cellspacing=0>","<table style=""display:none"">")
html=replace(html,"BT</a><!--dateend-->","图片</a><!--dateend-->")
html=replace(html,"href=""http://","href=""http://")
html=replace(html,"../news/e.asp?Key=http://news.baidu.com/","http://news.baidu.com/")
html=replace(html,"../news/e.asp?Key=http://www.1230530.com/","http://www.1230530.com/")
html=replace(html,"../news/e.asp?Key=http://gimg.baidu.com","http://gimg.baidu.com")
html=replace(html,"../news/e.asp?Key=http://www.baidu.com/search/img/rss.gif","http://www.baidu.com/search/img/rss.gif")
html=replace(html,"<div id=""adPos"" align=""center"">","<div style=""display:none"">")
html=replace(html,"<a href=""More_poss.asp"">更多资讯服务","<a href=http://fun.2e7.net>明星</a>&nbsp;&nbsp;| &nbsp;&nbsp;<a href=http://it.netsoz.com>IT</a>&nbsp;&nbsp;| &nbsp;&nbsp;<a href=Soft_poss.asp>软件</a>&nbsp;&nbsp;| &nbsp;&nbsp;<a href=http://news.2e7.net/Hard_poss.asp>硬件</a>&nbsp;&nbsp;| &nbsp;&nbsp;<a href=""More_poss.asp"">更多资讯服务")
html=replace(html,"http://news.baidu.com/image/","http://news.baidu.com/image/")
html=replace(html,"Baidu</span>&nbsp;<a href="""" class=""cy""> </a><!--ecombegin-->&nbsp;<a href=""http://net.china.cn/chinese/index.htm"" target=_blank><img src=""http://gimg.baidu.com/img/net.gif"" border=0></a>&nbsp;<a href=""http://www.bj.cyberpolice.cn/alarm/alarm.htm"" target=_blank>","")
html=replace(html,"http://news.xinhuanet.com/","http://www.netsoz.com/It.asp?Key=http://news.xinhuanet.com/")
html=replace(html,"资讯</span>&nbsp;&nbsp;&nbsp;<a href=""http://www.netsoz.com/"">网页</a>&nbsp;&nbsp;&nbsp;<a href=""http://bbs.2e7.net/"">论坛</a>&nbsp;&nbsp;&nbsp;<a href=""http://it.2e7.net/"">IT</a>&nbsp;&nbsp;&nbsp;<a href=""http://music.2e7.net/"">MP3</a>&nbsp;&nbsp;&nbsp;<a href=""http://bt.2e7.net/"">BT</a>&nbsp;&nbsp;&nbsp;<a href=""http://www.netsoz.com/Hot_Top/"">搜索风云榜&gt;&gt;","资讯</span>&nbsp;&nbsp;&nbsp;<a href=""http://www.netsoz.com/"" target=""_blank"">网页</a>&nbsp;&nbsp;&nbsp;<a href=""http://bbs.2e7.net/"" target=""_blank"">论坛</a>&nbsp;&nbsp;&nbsp;<a href=""http://it.2e7.net/"" target=""_blank"">IT</a>&nbsp;&nbsp;&nbsp;<a href=""http://music.2e7.net/"" target=""_blank"">MP3</a>&nbsp;&nbsp;&nbsp;<a href=""http://bt.netsoz.com/"" target=""_blank"" target=""_blank"">BT</a>&nbsp;&nbsp;&nbsp;<a href=""http://www.netsoz.com/Hot_Top/"" target=""_blank"">搜索风云榜")
html=replace(html,"alt=百度资讯","alt=NETSOZ.COM资讯")
html=replace(html,"src="" ","src="" ")
html=replace(html,"href=http://","href=http://")
html=replace(html,"value=百度搜索","value=亿时达搜索")
html=replace(html,"与百度对话","")
html=replace(html,"&nbsp;&nbsp;&nbsp;<a href=l.asp?Key=internet&tn=rss target=""_blank""><img src=""http://www.baidu.com/search/img/rss.gif"" width=""32"" height=""32"" border=0 align=""absmiddle""></a>&nbsp;&nbsp;<span class=""f14""><a href=l.asp?Key=internet&tn=rss target=""_blank"">RSS订阅<b>互联网焦点</b>新闻</a></span>"," ")
html=replace(html,"<br><span class=""f14"" style=""margin-left:50px;""><A href=""http://www.baidu.com/search/rss.html#02"" target=_blank  >→更多RSS订阅</A></span>"," ")
html=replace(html,"&nbsp;&nbsp;&nbsp;<a href=l.asp?Key=sportnews&tn=rss target=""_blank""><img src=""http://www.baidu.com/search/img/rss.gif"" width=""32"" height=""32"" border=0 align=""absmiddle""></a>&nbsp;&nbsp;<span class=""f14""><a href=l.asp?Key=sportnews&tn=rss target=""_blank"">RSS订阅<b>体育焦点</b>新闻</a></span>"," ")
html=replace(html,"class=""nv2link"">BT</a>","class=""nv2link"">图片</a>")
html=replace(html,"http://news.2e7.net/Hard_poss.asp","http://news.2e7.net/Hard_poss.asp")
html=replace(html,"http://it.2e7.net","http://it.2e7.net")
response.Write(html)
%>
