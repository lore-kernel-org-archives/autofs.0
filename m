From: Ondrej Valousek <webserv@s3group.com>
Subject: autofs misbehaves when DNS RRs returns more ldap servers
Date: Mon, 27 Dec 2010 13:36:45 +0100
Message-ID: <4D18885D.6010601@s3group.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0108811326206583067=="
Return-path: <autofs-bounces@linux.kernel.org>
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
To: "autofs@linux.kernel.org" <autofs@linux.kernel.org>, Ian Kent <ikent@redhat.com>

This is a multi-part message in MIME format.
--===============0108811326206583067==
Content-Type: multipart/alternative;
 boundary="------------050603080409060606030103"

This is a multi-part message in MIME format.
--------------050603080409060606030103
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  Hi Ian,

I just found out that when using DNS RRs to find a suitable ldapserver to connect to, we do not handle correctly the situation where the 
multiple servers are found. We end up with something like this:

automount[2712]: find_server: trying server uri ldap://dccorka.dublin.ad.s3group.com:389 ldap://dclisaa.dublin.ad.s3group.com:389 
ldap://dcdub1.dublin.ad.s3group.com:389 ldap://dcduba.dublin.ad.s3group.com:389 ldap://dcdubb.dublin.ad.s3group.com:389 
ldap://dcpra1.dublin.ad.s3group.com:389 ldap://dcsjc1.dublin.ad.s3group.com:389 ldap://dcsjca.dublin.ad.s3group.com:389 
ldap://dcwro1.dublin.ad.s3group.com:389 ldap://dccork1.dublin.ad.s3group.com:389

Looking at the source code, this uri does not look valid to me.
Ok "man auto.master" says that LDAP_URI might contain "A space seperated list of server uris of the form <proto>://<server>[/]", but 
ldap_initialize() does not look like it actually supports this - a single server is assumed instead.

Can you clarify this?

In my case above, if connection to ldap://dccorka.dublin.ad.s3group.com:389 fails, autofs never tries the other servers in the list.

Many thanks & happy new year!

Ondrej


The information contained in this e-mail and in any attachments is confidential and is designated solely for the attention of the intended recipient(s). If you are not an intended recipient, you must not use, disclose, copy, distribute or retain this e-mail or any part thereof. If you have received this e-mail in error, please notify the sender by return e-mail and delete all copies of this e-mail from your computer system(s).
Please direct any additional queries to: communications@s3group.com.
Thank You.
Silicon and Software Systems Limited. Registered in Ireland no. 378073.
Registered Office: Whelan House, South County Business Park, Leopardstown, Dublin 18
--------------050603080409060606030103
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000066" bgcolor="#ffffff">
    Hi Ian,<br>
    <br>
    I just found out that when using DNS RRs to find a suitable
    ldapserver to connect to, we do not handle correctly the situation
    where the multiple servers are found. We end up with something like
    this:<br>
    <br>
    automount[2712]: find_server: trying server uri
    <a class="moz-txt-link-freetext" href="ldap://dccorka.dublin.ad.s3group.com:389">ldap://dccorka.dublin.ad.s3group.com:389</a>
    <a class="moz-txt-link-freetext" href="ldap://dclisaa.dublin.ad.s3group.com:389">ldap://dclisaa.dublin.ad.s3group.com:389</a>
    <a class="moz-txt-link-freetext" href="ldap://dcdub1.dublin.ad.s3group.com:389">ldap://dcdub1.dublin.ad.s3group.com:389</a>
    <a class="moz-txt-link-freetext" href="ldap://dcduba.dublin.ad.s3group.com:389">ldap://dcduba.dublin.ad.s3group.com:389</a>
    <a class="moz-txt-link-freetext" href="ldap://dcdubb.dublin.ad.s3group.com:389">ldap://dcdubb.dublin.ad.s3group.com:389</a>
    <a class="moz-txt-link-freetext" href="ldap://dcpra1.dublin.ad.s3group.com:389">ldap://dcpra1.dublin.ad.s3group.com:389</a>
    <a class="moz-txt-link-freetext" href="ldap://dcsjc1.dublin.ad.s3group.com:389">ldap://dcsjc1.dublin.ad.s3group.com:389</a>
    <a class="moz-txt-link-freetext" href="ldap://dcsjca.dublin.ad.s3group.com:389">ldap://dcsjca.dublin.ad.s3group.com:389</a>
    <a class="moz-txt-link-freetext" href="ldap://dcwro1.dublin.ad.s3group.com:389">ldap://dcwro1.dublin.ad.s3group.com:389</a>
    <a class="moz-txt-link-freetext" href="ldap://dccork1.dublin.ad.s3group.com:389">ldap://dccork1.dublin.ad.s3group.com:389</a><br>
    <br>
    Looking at the source code, this uri does not look valid to me.<br>
    Ok "man auto.master" says that LDAP_URI might contain "A space
    seperated list of server uris of the form
    &lt;proto&gt;://&lt;server&gt;[/]", but ldap_initialize() does not
    look like it actually supports this - a single server is assumed
    instead.<br>
    <br>
    Can you clarify this?<br>
    <br>
    In my case above, if connection to
    <a class="moz-txt-link-freetext" href="ldap://dccorka.dublin.ad.s3group.com:389">ldap://dccorka.dublin.ad.s3group.com:389</a> fails, autofs never tries
    the other servers in the list.<br>
    <br>
    Many thanks &amp; happy new year!<br>
    <br>
    Ondrej<br>
  <BR><HR>
The information contained in this e-mail and in any attachments is confidential and is designated solely for the attention of the intended recipient(s). If you are not an intended recipient, you must not use, disclose, copy, distribute or retain this e-mail or any part thereof. If you have received this e-mail in error, please notify the sender by return e-mail and delete all copies of this e-mail from your computer system(s).
Please direct any additional queries to: communications@s3group.com.
Thank You.
Silicon and Software Systems Limited. Registered in Ireland no. 378073.
Registered Office: Whelan House, South County Business Park, Leopardstown, Dublin 18
<BR><HR><BR></body>
</html>

--------------050603080409060606030103--


--===============0108811326206583067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0108811326206583067==--

