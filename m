From: Ondrej Valousek <webserv@s3group.com>
Subject: Re: autofs misbehaves when DNS RRs returns more ldap
	servers
Date: Thu, 06 Jan 2011 09:48:48 +0100
Message-ID: <4D2581F0.8020607@s3group.cz>
References: <4D18885D.6010601@s3group.cz> <1293503090.5923.2.camel@perseus>	
	<4D21A19D.3050303@s3group.cz> <1294297764.3010.8.camel@perseus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6015437855217227309=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1294297764.3010.8.camel@perseus>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <ikent@redhat.com>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

This is a multi-part message in MIME format.
--===============6015437855217227309==
Content-Type: multipart/alternative;
 boundary="------------020008010707060504030603"

This is a multi-part message in MIME format.
--------------020008010707060504030603
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  On 06.01.2011 08:09, Ian Kent wrote:
>> LDAP_URI="ldap://server1 ldap://server2"
> You are supposed to be able to do this.
>
Ok I have found the problem. The construction above is working well, indeed.
The problem is, that you call get_dc_list() directly in the while loop in function find_server() where its output is not parsed (normally 
the LDAP_URI config parameter is parsed fine).

I think that to fix it we would need to:
1. call the get_dc_list() before the main "while" loop
2. fix get_dc_list() so it rather than strcatting ldap uris into a single string returns the pure list so that we do not have to parse it 
again. This way it can be directly processed in the main while loop.

But I do not know how would it behave if we had something like this:
LDAP_URI="ldap:///something ldap:///something_else".

Maybe two nested loops would be better - anyway I am sure you know where I am pointing now :-)

Ondrej



The information contained in this e-mail and in any attachments is confidential and is designated solely for the attention of the intended recipient(s). If you are not an intended recipient, you must not use, disclose, copy, distribute or retain this e-mail or any part thereof. If you have received this e-mail in error, please notify the sender by return e-mail and delete all copies of this e-mail from your computer system(s).
Please direct any additional queries to: communications@s3group.com.
Thank You.
Silicon and Software Systems Limited. Registered in Ireland no. 378073.
Registered Office: Whelan House, South County Business Park, Leopardstown, Dublin 18
--------------020008010707060504030603
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000066" bgcolor="#ffffff">
    On 06.01.2011 08:09, Ian Kent wrote:
    <blockquote cite="mid:1294297764.3010.8.camel@perseus" type="cite">
      <blockquote type="cite" style="font-size: large; color: rgb(0, 0,
        0);">
        <pre wrap="">LDAP_URI=<a moz-do-not-send="true" class="moz-txt-link-rfc2396E" href="ldap://server1ldap://server2">"ldap://server1 ldap://server2"</a>
</pre>
      </blockquote>
      <pre wrap="">You are supposed to be able to do this.

</pre>
    </blockquote>
    Ok I have found the problem. The construction above is working well,
    indeed.<br>
    The problem is, that you call get_dc_list() directly in the while
    loop in function find_server() where its output is not parsed
    (normally the LDAP_URI config parameter is parsed fine).<br>
    <br>
    I think that to fix it we would need to:<br>
    1. call the get_dc_list() before the main "while" loop<br>
    2. fix get_dc_list() so it rather than strcatting ldap uris into a
    single string returns the pure list so that we do not have to parse
    it again. This way it can be directly processed in the main while
    loop.<br>
    <br>
    But I do not know how would it behave if we had something like this:<br>
    LDAP_URI=<a class="moz-txt-link-rfc2396E" href="ldap:///somethingldap:///something_else">"ldap:///something ldap:///something_else"</a>.<br>
    <br>
    Maybe two nested loops would be better - anyway I am sure you know
    where I am pointing now <span class="moz-smiley-s1"><span> :-) </span></span><br>
    <br>
    Ondrej<br>
    <br>
  <BR><HR>
The information contained in this e-mail and in any attachments is confidential and is designated solely for the attention of the intended recipient(s). If you are not an intended recipient, you must not use, disclose, copy, distribute or retain this e-mail or any part thereof. If you have received this e-mail in error, please notify the sender by return e-mail and delete all copies of this e-mail from your computer system(s).
Please direct any additional queries to: communications@s3group.com.
Thank You.
Silicon and Software Systems Limited. Registered in Ireland no. 378073.
Registered Office: Whelan House, South County Business Park, Leopardstown, Dublin 18
<BR><HR><BR></body>
</html>

--------------020008010707060504030603--


--===============6015437855217227309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6015437855217227309==--

