<%@ WebHandler Language="C#" Class="UrlEcho" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Net;
using System.Linq;
using System.IO;

public class UrlEcho : IHttpHandler
{

    public bool IsReusable
    {
        get
        {
            return true;
        }
    }

    public void ProcessRequest(HttpContext context)
    {
        var qs = context.Request.QueryString;
        var keys = qs.AllKeys;

        if (keys.Contains("html") && qs["html"] == "true")
        {
            context.Response.ContentType = "text/html;charset=UTF-8";
            context.Response.Write(string.Format(HtmlTemplate, context.Request.RawUrl ));
        }
        else
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(string.Format(PlainTextTemplate, context.Request.RawUrl));
        }
    }

    public static string PlainTextTemplate = @"{0}";
    public static string HtmlTemplate = @"<!DOCTYPE html>
<html xmlns=""http://www.w3.org/1999/xhtml"">
<head>
    <title>Url Echo</title>
</head>
<body>
{0}
</body>
</html>
";
    
}