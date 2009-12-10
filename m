From: "Eric B." <ebenze@hotmail.com>
Subject: Re: How to make Autofs check if ldap server is back online
Date: Thu, 10 Dec 2009 15:55:15 -0500
Message-ID: <BLU135-W27268A9EEAD4CF84BBA96DC8D0@phx.gbl>
References: <BLU122-W39FFDD18BD2645CE96B6ADC9A0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0391845319263224523=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BLU122-W39FFDD18BD2645CE96B6ADC9A0@phx.gbl>
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

--===============0391845319263224523==
Content-Type: multipart/alternative;
	boundary="_5b0a59b9-e4ae-4826-8657-01fa74813344_"

--_5b0a59b9-e4ae-4826-8657-01fa74813344_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



"Ian Kent" <raven@themaw.net> wrote in message=20
news:4B18C1D7.7020703@themaw.net...
> Eric B. wrote:
>>
>> Hi=2C
>>
>> I'm using Autofs and LDAP for mounting my home directories via nfs.
>> In general=2C everything seems to work fine.  However=2C I have one smal=
l
>> problem.
>>
>> If I reboot my server using autofs while my LDAP server is down=2C I
>> get the following error message in my logs: automount[3358]:
>> bind_ldap_anonymous: lookup(ldap): Unable to bind to the LDAP server:
>> (default)=2C error Can't contact LDAP server
>>
>> which is understandable=2C since my ldap server is temporarily down.
>>
>> My problem=2C however=2C is that once my ldap server is back up=2C autof=
s
>> never seems to retry to connect to it=2C so all my /home mounts fail.
>> Basically=2C it means I have to make sure that my LDAP server is never
>> down while another server is rebooting.
>>
>> I figure there must be something in the configuration file that would
>> allow me to tweak this to indicate to autofs to recheck the ldap
>> server periodically to see if it has come back up=2C but can't seem to
>> find anything.
>
> Yeah=2C there are problems in that area.
>
> What does your nsswitch.conf have for the "automount:" entry?
> Is your master map also located on the LDAP server?
> Does sending a HUP signal to automount make things work again when the
> server is back?


nsswitch.conf:
automount:  files ldap

Restarting autofs will make things work again.  Similarly=2C issuing a HUP=
=20
signal will make things work again once the server is back online.

Thanks for any suggestions.

Eric


=20
 		 	   		 =20
_________________________________________________________________
Windows Live: Keep your friends up to date with what you do online.
http://go.microsoft.com/?linkid=3D9691815=

--_5b0a59b9-e4ae-4826-8657-01fa74813344_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
--></style>
</head>
<body class=3D'hmmessage'>
<BR>"Ian Kent" &lt=3B<A href=3D"wlmailhtml:{B830FD09-3349-4975-B212-7CE9F0F=
D2487}mid://00002792/!x-usc:mailto:raven@themaw.net">raven@themaw.net</A>&g=
t=3B wrote in message <BR><A href=3D"wlmailhtml:{B830FD09-3349-4975-B212-7C=
E9F0FD2487}mid://00002792/!x-usc:news:4B18C1D7.7020703@themaw.net">news:4B1=
8C1D7.7020703@themaw.net</A>...<BR>&gt=3B Eric B. wrote:<BR>&gt=3B&gt=3B<BR=
>&gt=3B&gt=3B Hi=2C<BR>&gt=3B&gt=3B<BR>&gt=3B&gt=3B I'm using Autofs and LD=
AP for mounting my home directories via nfs.<BR>&gt=3B&gt=3B In general=2C =
everything seems to work fine.&nbsp=3B However=2C I have one small<BR>&gt=
=3B&gt=3B problem.<BR>&gt=3B&gt=3B<BR>&gt=3B&gt=3B If I reboot my server us=
ing autofs while my LDAP server is down=2C I<BR>&gt=3B&gt=3B get the follow=
ing error message in my logs: automount[3358]:<BR>&gt=3B&gt=3B bind_ldap_an=
onymous: lookup(ldap): Unable to bind to the LDAP server:<BR>&gt=3B&gt=3B (=
default)=2C error Can't contact LDAP server<BR>&gt=3B&gt=3B<BR>&gt=3B&gt=3B=
 which is understandable=2C since my ldap server is temporarily down.<BR>&g=
t=3B&gt=3B<BR>&gt=3B&gt=3B My problem=2C however=2C is that once my ldap se=
rver is back up=2C autofs<BR>&gt=3B&gt=3B never seems to retry to connect t=
o it=2C so all my /home mounts fail.<BR>&gt=3B&gt=3B Basically=2C it means =
I have to make sure that my LDAP server is never<BR>&gt=3B&gt=3B down while=
 another server is rebooting.<BR>&gt=3B&gt=3B<BR>&gt=3B&gt=3B I figure ther=
e must be something in the configuration file that would<BR>&gt=3B&gt=3B al=
low me to tweak this to indicate to autofs to recheck the ldap<BR>&gt=3B&gt=
=3B server periodically to see if it has come back up=2C but can't seem to<=
BR>&gt=3B&gt=3B find anything.<BR>&gt=3B<BR>&gt=3B Yeah=2C there are proble=
ms in that area.<BR>&gt=3B<BR>&gt=3B What does your nsswitch.conf have for =
the "automount:" entry?<BR>&gt=3B Is your master map also located on the LD=
AP server?<BR>&gt=3B Does sending a HUP signal to automount make things wor=
k again when the<BR>&gt=3B server is back?<BR><BR><BR>nsswitch.conf:<BR>aut=
omount:&nbsp=3B files ldap<BR><BR>Restarting autofs will make things work a=
gain.&nbsp=3B Similarly=2C issuing a HUP <BR>signal will make things work a=
gain once the server is back online.<BR><BR>Thanks for any suggestions.<BR>=
<BR>Eric<BR><BR><BR>&nbsp=3B<BR> 		 	   		  <br /><hr />Windows Live: Keep =
your friends up to date <a href=3D'http://go.microsoft.com/?linkid=3D969181=
0' target=3D'_new'>with what you do online.</a></body>
</html>=

--_5b0a59b9-e4ae-4826-8657-01fa74813344_--


--===============0391845319263224523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0391845319263224523==--

