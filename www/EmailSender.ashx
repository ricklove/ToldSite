<%@ WebHandler Language="C#" Class="EmailSender" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Net;
using System.Linq;
using System.IO;

using ICSharpCode.SharpZipLib.Zip;

public class EmailSender : IHttpHandler
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

        if (keys.Contains("email"))
        {
            var email = qs["email"];

            if (email.Where(c => c == '@').Count() == 1
               && email.Contains('.'))
            {
                var client = new System.Net.Mail.SmtpClient();
                client.Send("mailer@toldpro.com", "admin@toldpro.com", "Customer Request", "Interested Customer - Email: " + email);
            }
        }
    }

}