From: Michael Coffman <michael.coffman@avagotech.com>
Subject: Re: Question/request about host mapping
Date: Thu, 7 Apr 2011 15:29:20 -0600
Message-ID: <BANLkTi=45=vB3TX7mMd9zdzjcS2YLEM4GA@mail.gmail.com>
References: <BANLkTimoD2yb7DBvNsrP014yxRaGywQVug@mail.gmail.com>
	<1302188176.2883.39.camel@perseus>
Reply-To: michael.coffman@avagotech.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0238966370040971762=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1302188176.2883.39.camel@perseus>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

--===============0238966370040971762==
Content-Type: multipart/alternative; boundary=00151747849e6fb96c04a05acd80

--00151747849e6fb96c04a05acd80
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Apr 7, 2011 at 8:56 AM, Ian Kent <raven@themaw.net> wrote:

> On Wed, 2011-04-06 at 12:52 -0600, Michael Coffman wrote:
> > Hello,
> >
> > I am trying to use the -host map for global access to servers in my
> > environment.
> >
> > I have noted on this list that after the first mount of a server via
> > host mapping, the server is never again probed for mount points.  This
> > seems like a major flaw in the host map functionality.   This is a
> > problem when adding new file systems to our NFS servers.   It means
> > systems have to be completely idled in order to get them to unmount
> > and re-mount the servers to see the new mount points (not possible
> > very often in my environment).
> >
> > Is the assumption that if you use host mapping, your server will
> > either never change, or you have the ability to 'reboot' your
> > environment when a new file system is added to a server?
>
> Neither.
>
> The problem is that exports can be nested and frequently are (think of
> the nohide export option).
>
> For example, with exports like:
>
> /export/vol1/data1
> /export/vol1/data2
>
> and then add:
>
> /export/vol1
>
> and update the map when either or both /export/vol1/data1
> and /export/vol1/data2 are mounted, /export/vol1 is accessed it will
> cover these mounts. Now that might not seem like a problem but when you
> end up with multiple layers of mounts mounted multiple times everything
> starts to get confused really fast.
>
>
First off, thanks for the reply and the details on the reasoning for not
automatically re-scanning servers that have been mounted via host
mapping.

I guess in my simple world I would never export a higher level directory if
sub-directories were already exported.   Do lots or people really nest
exports to the same sets of client systems?  I will have to think about some
scenarios and some possibilities of algorithms on how to deal with them and
get back with you...

In any case, it seems having a way to ping autofs and have it re-read would
imply that the admin would have some knowledge of what was being requested.



> >
> > Is there any way that functionality could be added that would allow
> > for sending a signal ( say USR2 ) that would cause the automounter to
> > re-run /etc/auto.net to re-query -host managed servers for new file
> > systems?
>
> Well, if you have sensible, realistic, workable ideas on how to handle
> the nesting problem then share. And I don't mean "just do this ...."
> type through away comments that have no workable basis in fact.
>
>

Hopefully this will not come across as me saying 'just do it' :)    We have
used AMD for years and I would really like to switch to autofs and was
planning on doing so until this issue came up.   I believe that some kind of
knob that could be used to refresh the maps on my clients so they see new
exports when added to the servers would be very useful.   Not an automatic
re-querying of the servers, but a signal that I can bump automount with when
I know what changes have been made on the other end and want to refresh.

Thanks again for taking the time to reply to my message.



> Ian
>
>
>


-- 
-MichaelC

--00151747849e6fb96c04a05acd80
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 7, 2011 at 8:56 AM, Ian Kent <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:raven@themaw.net">raven@themaw.net</a>&gt;</span> wrote:<br><div clas=
s=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">On Wed, 2011-04-06 at 12:52 -0600, Michael Coffman wrote:=
<br>
&gt; Hello,<br>
&gt;<br>
&gt; I am trying to use the -host map for global access to servers in my<br=
>
&gt; environment.<br>
&gt;<br>
&gt; I have noted on this list that after the first mount of a server via<b=
r>
&gt; host mapping, the server is never again probed for mount points. =A0Th=
is<br>
&gt; seems like a major flaw in the host map functionality. =A0 This is a<b=
r>
&gt; problem when adding new file systems to our NFS servers. =A0 It means<=
br>
&gt; systems have to be completely idled in order to get them to unmount<br=
>
&gt; and re-mount the servers to see the new mount points (not possible<br>
&gt; very often in my environment).<br>
&gt;<br>
&gt; Is the assumption that if you use host mapping, your server will<br>
&gt; either never change, or you have the ability to &#39;reboot&#39; your<=
br>
&gt; environment when a new file system is added to a server?<br>
<br>
</div>Neither.<br>
<br>
The problem is that exports can be nested and frequently are (think of<br>
the nohide export option).<br>
<br>
For example, with exports like:<br>
<br>
/export/vol1/data1<br>
/export/vol1/data2<br>
<br>
and then add:<br>
<br>
/export/vol1<br>
<br>
and update the map when either or both /export/vol1/data1<br>
and /export/vol1/data2 are mounted, /export/vol1 is accessed it will<br>
cover these mounts. Now that might not seem like a problem but when you<br>
end up with multiple layers of mounts mounted multiple times everything<br>
starts to get confused really fast.<br>
<div class=3D"im"><br></div></blockquote><div><br>First off, thanks for the=
 reply and the details on the reasoning for not automatically re-scanning s=
ervers that have been mounted via host mapping.=A0=A0=A0 <br><br>I guess in=
 my simple world I would never export a higher level directory if sub-direc=
tories were already exported.=A0=A0 Do lots or people really nest exports t=
o the same sets of client systems?=A0 I will have to think about some scena=
rios and some possibilities of algorithms on how to deal with them and get =
back with you...<br>
<br>In any case, it seems having a way to ping autofs and have it re-read w=
ould imply that the admin would have some knowledge of what was being reque=
sted.<br><br>=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-lef=
t: 1ex;">
<div class=3D"im">
&gt;<br>
&gt; Is there any way that functionality could be added that would allow<br=
>
&gt; for sending a signal ( say USR2 ) that would cause the automounter to<=
br>
&gt; re-run /etc/<a href=3D"http://auto.net" target=3D"_blank">auto.net</a>=
 to re-query -host managed servers for new file<br>
&gt; systems?<br>
<br>
</div>Well, if you have sensible, realistic, workable ideas on how to handl=
e<br>
the nesting problem then share. And I don&#39;t mean &quot;just do this ...=
.&quot;<br>
type through away comments that have no workable basis in fact.<br>=A0
<br></blockquote><div><br>Hopefully this will not come across as me saying =
&#39;just do it&#39; :)=A0=A0=A0 We have used AMD for years and I would rea=
lly like to switch to autofs and was planning on doing so until this issue =
came up.=A0=A0 I believe that some kind of knob that could be used to refre=
sh the maps on my clients so they see new exports when added to the servers=
 would be very useful.=A0=A0 Not an automatic re-querying of the servers, b=
ut a signal that I can bump automount with when I know what changes have be=
en made on the other end and want to refresh.<br>
<br>Thanks again for taking the time to reply to my message.<br><br>=A0<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex;=
 border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><font color=
=3D"#888888">
Ian<br>
<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>-MichaelC<br>

--00151747849e6fb96c04a05acd80--


--===============0238966370040971762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0238966370040971762==--

