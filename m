From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: autofs misbehaves when DNS RRs returns more
	ldap	servers
Date: Wed, 02 Feb 2011 15:40:57 +0100
Message-ID: <4D496CF9.5040001@s3group.cz>
References: <4D18885D.6010601@s3group.cz>
	<1293503090.5923.2.camel@perseus>		<4D21A19D.3050303@s3group.cz>
	<1294297764.3010.8.camel@perseus>		<4D2581F0.8020607@s3group.cz>
	<1294322864.2852.3.camel@perseus> <4D27115A.9010805@s3group.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6268956503600185826=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4D27115A.9010805@s3group.cz>
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
--===============6268956503600185826==
Content-Type: multipart/alternative;
 boundary="------------050102070608010901060308"

This is a multi-part message in MIME format.
--------------050102070608010901060308
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  Hi Ian,

Did you have any chance to take a look at this patch yet?
Thanks,

Ondrej

On 07.01.2011 14:12, Ondrej Valousek wrote:
> On 06.01.2011 15:07, Ian Kent wrote:
>> Thanks for the suggestions.
>> I'm still on leave so things are still going slowly for now, but I'll
>> get to it.
> Hi Ian,
>
> Please find the attached patch which fixes the problem for me.
> I also changed the "dclist" structure definition from:
>
> struct dclist {
>         time_t expire;
>         const char *uri;
> };
>
> into:
>
> struct dclist {
>         time_t expire;
>         char **uri;
>         int cnt;
> };
>
> Hope you'll find it useful :-) .
> Ondrej
>
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs


--------------050102070608010901060308
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body text=3D"#000066" bgcolor=3D"#ffffff">
    Hi Ian,<br>
    <br>
    Did you have any chance to take a look at this patch yet?<br>
    Thanks,<br>
    <br>
    Ondrej<br>
    <br>
    On 07.01.2011 14:12, Ondrej Valousek wrote:
    <blockquote cite=3D"mid:4D27115A.9010805@s3group.cz" type=3D"cite">
      <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-=
Type">
      On 06.01.2011 15:07, Ian Kent wrote:
      <blockquote cite=3D"mid:1294322864.2852.3.camel@perseus" type=3D"ci=
te">
        <pre wrap=3D"">Thanks for the suggestions.
I'm still on leave so things are still going slowly for now, but I'll
get to it.
</pre>
      </blockquote>
      Hi Ian,<br>
      <br>
      Please find the attached patch which fixes the problem for me.<br>
      I also changed the "dclist" structure definition from:<br>
      <br>
      struct dclist {<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_t expire;<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *uri;<br>
      };<br>
      <br>
      into:<br>
      <br>
      struct dclist {<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_t expire;<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char **uri;<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int cnt;<br>
      };<br>
      <br>
      Hope you'll find it useful <span class=3D"moz-smiley-s1"><span> :-)=

        </span></span>.<br>
      Ondrej<br>
      <pre wrap=3D"">
<fieldset class=3D"mimeAttachmentHeader"></fieldset>
_______________________________________________
autofs mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:autofs@linux.kernel.=
org">autofs@linux.kernel.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"http://linux.kernel.org/mailma=
n/listinfo/autofs">http://linux.kernel.org/mailman/listinfo/autofs</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------050102070608010901060308--


--===============6268956503600185826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6268956503600185826==--

