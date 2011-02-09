From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: autofs misbehaves when DNS RRs returns more
	ldap	servers
Date: Wed, 09 Feb 2011 17:40:18 +0100
Message-ID: <4D52C372.3010104@s3group.cz>
References: <4D18885D.6010601@s3group.cz>	<1293503090.5923.2.camel@perseus><4D21A19D.3050303@s3group.cz>	<1294297764.3010.8.camel@perseus><4D2581F0.8020607@s3group.cz>	<1294322864.2852.3.camel@perseus><4D27115A.9010805@s3group.cz>	<4D496CF9.5040001@s3group.cz><1297137397.10090.4.camel@perseus>	<4D5109EF.7040800@s3group.cz>
	<1297223424.2771.7.camel@perseus>
	<AE70589A6589BA448AC7222D2428F8DE792AE7@houmsmsgexg001.anadarko.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1800462807768316333=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <AE70589A6589BA448AC7222D2428F8DE792AE7@houmsmsgexg001.anadarko.com>
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
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--===============1800462807768316333==
Content-Type: multipart/alternative;
 boundary="------------020108040400050505090107"

This is a multi-part message in MIME format.
--------------020108040400050505090107
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  Ok,
LDAP URI can not contain spaces, Ian was right...
Ondrej

On 09.02.2011 15:57, Wolfe, Allan wrote:
> A copy of the RFC for LDAP URI formatting can be found at
> http://www.faqs.org/rfcs/rfc2255.html it documents how the URI should be
> constructed/interpreted.
>
> -----Original Message-----
> From: autofs-bounces@linux.kernel.org
> [mailto:autofs-bounces@linux.kernel.org] On Behalf Of Ian Kent
> Sent: Tuesday, February 08, 2011 9:50 PM
> To: Ondrej Valousek
> Cc: autofs@linux.kernel.org
> Subject: Re: [autofs] autofs misbehaves when DNS RRs returns more ldap
> servers
>
> On Tue, 2011-02-08 at 10:16 +0100, Ondrej Valousek wrote:
>>> Yes, and replied on the 11/01, did you miss it?
>>>
>> Ok I must have missed it - now I see you have taken a different
>> approach - you are constructing a single looong string with all ldap
>> uris and then you parse them again.
>> I must say I do not like it too much as:
>> a) it is wasted effort (merging together and then splitting again)
>> b) potentially can ldap uri contain spaces I think
> Don't think so, in this case anyway.
>
> The uris used here aren't full uris, they can only have the proto, host
> name and port. AFAIK, host names can't have spaces in them yet.
>
>> But if you like it more, I am fine with it, too.
> Yeah, your points above are well taken but had already been done and
> committed to the repo so to change would be more work with the potential
> for mistakes.
>
> Ian
>
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
> Anadarko Confidentiality Notice: This electronic transmission and any
> attached documents or other writings are intended only for the person
> or entity to which it is addressed and may contain information that is
> privileged, confidential or otherwise protected from disclosure. If you
> have received this communication in error, please immediately notify
> sender by return e-mail and destroy the communication. Any disclosure,
> copying, distribution or the taking of any action concerning the contents
> of this communication or any attachments by anyone other than the
> named recipient is strictly prohibited.
>
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs


--------------020108040400050505090107
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000066" bgcolor="#ffffff">
    Ok,<br>
    LDAP URI can not contain spaces, Ian was right...<br>
    Ondrej<br>
    <br>
    On 09.02.2011 15:57, Wolfe, Allan wrote:
    <blockquote
cite="mid:AE70589A6589BA448AC7222D2428F8DE792AE7@houmsmsgexg001.anadarko.com"
      type="cite">
      <pre wrap="">A copy of the RFC for LDAP URI formatting can be found at
<a class="moz-txt-link-freetext" href="http://www.faqs.org/rfcs/rfc2255.html">http://www.faqs.org/rfcs/rfc2255.html</a> it documents how the URI should be
constructed/interpreted.

-----Original Message-----
From: <a class="moz-txt-link-abbreviated" href="mailto:autofs-bounces@linux.kernel.org">autofs-bounces@linux.kernel.org</a>
[<a class="moz-txt-link-freetext" href="mailto:autofs-bounces@linux.kernel.org">mailto:autofs-bounces@linux.kernel.org</a>] On Behalf Of Ian Kent
Sent: Tuesday, February 08, 2011 9:50 PM
To: Ondrej Valousek
Cc: <a class="moz-txt-link-abbreviated" href="mailto:autofs@linux.kernel.org">autofs@linux.kernel.org</a>
Subject: Re: [autofs] autofs misbehaves when DNS RRs returns more ldap
servers

On Tue, 2011-02-08 at 10:16 +0100, Ondrej Valousek wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">
</pre>
        <blockquote type="cite">
          <pre wrap="">Yes, and replied on the 11/01, did you miss it?

</pre>
        </blockquote>
        <pre wrap="">Ok I must have missed it - now I see you have taken a different 
approach - you are constructing a single looong string with all ldap 
uris and then you parse them again.
I must say I do not like it too much as:
a) it is wasted effort (merging together and then splitting again)
b) potentially can ldap uri contain spaces I think
</pre>
      </blockquote>
      <pre wrap="">
Don't think so, in this case anyway.

The uris used here aren't full uris, they can only have the proto, host
name and port. AFAIK, host names can't have spaces in them yet.

</pre>
      <blockquote type="cite">
        <pre wrap="">
But if you like it more, I am fine with it, too.
</pre>
      </blockquote>
      <pre wrap="">
Yeah, your points above are well taken but had already been done and
committed to the repo so to change would be more work with the potential
for mistakes.

Ian


_______________________________________________
autofs mailing list
<a class="moz-txt-link-abbreviated" href="mailto:autofs@linux.kernel.org">autofs@linux.kernel.org</a>
<a class="moz-txt-link-freetext" href="http://linux.kernel.org/mailman/listinfo/autofs">http://linux.kernel.org/mailman/listinfo/autofs</a>

Anadarko Confidentiality Notice: This electronic transmission and any 
attached documents or other writings are intended only for the person 
or entity to which it is addressed and may contain information that is 
privileged, confidential or otherwise protected from disclosure. If you 
have received this communication in error, please immediately notify 
sender by return e-mail and destroy the communication. Any disclosure, 
copying, distribution or the taking of any action concerning the contents 
of this communication or any attachments by anyone other than the 
named recipient is strictly prohibited.


_______________________________________________
autofs mailing list
<a class="moz-txt-link-abbreviated" href="mailto:autofs@linux.kernel.org">autofs@linux.kernel.org</a>
<a class="moz-txt-link-freetext" href="http://linux.kernel.org/mailman/listinfo/autofs">http://linux.kernel.org/mailman/listinfo/autofs</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------020108040400050505090107--


--===============1800462807768316333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1800462807768316333==--

