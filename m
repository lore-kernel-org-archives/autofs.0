From: Steve Linn <steve.linn@gmail.com>
Subject: Re: [patch] allow the automount daemon to dump core
Date: Sat, 20 Jun 2009 19:24:27 -0700
Message-ID: <3ddb09290906201924x5e7c5f9bv335995bbd3a7bf96@mail.gmail.com>
References: <x49prd0f3gx.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4828627739492333955=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49prd0f3gx.fsf@segfault.boston.devel.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, Charlie Wyse <cwyse@redhat.com>, raven@themaw.net

--===============4828627739492333955==
Content-Type: multipart/alternative; boundary=00163683222aeedaa9046cd27492

--00163683222aeedaa9046cd27492
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I came up with my own patch so I could kill -ABRT when I want
a core dump so I could debug at a later time.  It seemed to ignore
kill -SEGV and kill -ABRT.  If you are going make a change could
you make sure kill -ABRT makes it dump core and exit.

Here was the path that I was using:

% cat autofs-5.0.4-abortable
--- autofs-5.0.4/daemon/automount.c     2009-03-17 17:56:22.000000000 -0700
+++ autofs-5.0.4-hack1/daemon/automount.c       2009-03-17
17:56:57.000000000 -0700
@@ -1331,11 +1331,18 @@
                case SIGUSR1:
                        do_signals(master_list, sig);
                        break;
-
                case SIGHUP:
                        do_hup_signal(master_list, time(NULL));
                        break;

+               case SIGABRT:
+                       abort();
+                       break;
+
+               case SIGSEGV:
+                       abort();
+                       break;
+
                default:
                        logerr("got unexpected signal %d!", sig);
                        continue;


On Fri, Jun 19, 2009 at 12:06 PM, Jeff Moyer <jmoyer@redhat.com> wrote:

> Hi,
>
> Right now, the automount daemon blocks all signals.  We should at least
> unblock those that will cause us to dump core.  Otherwise, I think the
> behaviour could be, umm, interesting.
>
> I tested this by sending SIGBUS and SIGSEGV to the automount daemon.
>
> Cheers,
> Jeff
>
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
>
> diff --git a/daemon/automount.c b/daemon/automount.c
> index 80691fa..04fa304 100644
> --- a/daemon/automount.c
> +++ b/daemon/automount.c
> @@ -1324,6 +1324,10 @@ static void *statemachine(void *arg)
>        sigfillset(&signalset);
>        sigdelset(&signalset, SIGCHLD);
>        sigdelset(&signalset, SIGCONT);
> +       sigdelset(&signalset, SIGBUS);
> +       sigdelset(&signalset, SIGSEGV);
> +       sigdelset(&signalset, SIGILL);
> +       sigdelset(&signalset, SIGFPE);
>
>        while (1) {
>                sigwait(&signalset, &sig);
> @@ -1817,6 +1821,11 @@ int main(int argc, char *argv[])
>        };
>
>        sigfillset(&allsigs);
> +       /* allow for the dropping of core files */
> +       sigdelset(&allsigs, SIGBUS);
> +       sigdelset(&allsigs, SIGSEGV);
> +       sigdelset(&allsigs, SIGILL);
> +       sigdelset(&allsigs, SIGFPE);
>        sigprocmask(SIG_BLOCK, &allsigs, NULL);
>
>        program = argv[0];
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>

--00163683222aeedaa9046cd27492
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I came up with my own patch so I could kill -ABRT when I want<br>a core dum=
p so I could debug at a later time.=A0 It seemed to ignore<br>kill -SEGV an=
d kill -ABRT.=A0 If you are going make a change could<br>you make sure kill=
 -ABRT makes it dump core and exit.<br>
<br>Here was the path that I was using:<br><br>% cat autofs-5.0.4-abortable=
<br>--- autofs-5.0.4/daemon/automount.c=A0=A0=A0=A0 2009-03-17 17:56:22.000=
000000 -0700<br>+++ autofs-5.0.4-hack1/daemon/automount.c=A0=A0=A0=A0=A0=A0=
 2009-03-17 17:56:57.000000000 -0700<br>
@@ -1331,11 +1331,18 @@<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ca=
se SIGUSR1:<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 do_signals(master_list, sig);<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;<br>-<br>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 case SIGHUP:<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 do_hup_signal(master_list, time(NUL=
L));<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break=
;<br><br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case SIGABRT:<br>+=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 abort();<br=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=
<br>+<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case SIGSEGV:<br>+=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 abort();<br=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=
<br>
+<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default:<br>=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 logerr(&quot;got =
unexpected signal %d!&quot;, sig);<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;<br><br><br><div class=3D"gmail_=
quote">On Fri, Jun 19, 2009 at 12:06 PM, Jeff Moyer <span dir=3D"ltr">&lt;<=
a href=3D"mailto:jmoyer@redhat.com">jmoyer@redhat.com</a>&gt;</span> wrote:=
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br>
<br>
Right now, the automount daemon blocks all signals. =A0We should at least<b=
r>
unblock those that will cause us to dump core. =A0Otherwise, I think the<br=
>
behaviour could be, umm, interesting.<br>
<br>
I tested this by sending SIGBUS and SIGSEGV to the automount daemon.<br>
<br>
Cheers,<br>
Jeff<br>
<br>
Signed-off-by: Jeff Moyer &lt;<a href=3D"mailto:jmoyer@redhat.com">jmoyer@r=
edhat.com</a>&gt;<br>
<br>
diff --git a/daemon/automount.c b/daemon/automount.c<br>
index 80691fa..04fa304 100644<br>
--- a/daemon/automount.c<br>
+++ b/daemon/automount.c<br>
@@ -1324,6 +1324,10 @@ static void *statemachine(void *arg)<br>
 =A0 =A0 =A0 =A0sigfillset(&amp;signalset);<br>
 =A0 =A0 =A0 =A0sigdelset(&amp;signalset, SIGCHLD);<br>
 =A0 =A0 =A0 =A0sigdelset(&amp;signalset, SIGCONT);<br>
+ =A0 =A0 =A0 sigdelset(&amp;signalset, SIGBUS);<br>
+ =A0 =A0 =A0 sigdelset(&amp;signalset, SIGSEGV);<br>
+ =A0 =A0 =A0 sigdelset(&amp;signalset, SIGILL);<br>
+ =A0 =A0 =A0 sigdelset(&amp;signalset, SIGFPE);<br>
<br>
 =A0 =A0 =A0 =A0while (1) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sigwait(&amp;signalset, &amp;sig);<br>
@@ -1817,6 +1821,11 @@ int main(int argc, char *argv[])<br>
 =A0 =A0 =A0 =A0};<br>
<br>
 =A0 =A0 =A0 =A0sigfillset(&amp;allsigs);<br>
+ =A0 =A0 =A0 /* allow for the dropping of core files */<br>
+ =A0 =A0 =A0 sigdelset(&amp;allsigs, SIGBUS);<br>
+ =A0 =A0 =A0 sigdelset(&amp;allsigs, SIGSEGV);<br>
+ =A0 =A0 =A0 sigdelset(&amp;allsigs, SIGILL);<br>
+ =A0 =A0 =A0 sigdelset(&amp;allsigs, SIGFPE);<br>
 =A0 =A0 =A0 =A0sigprocmask(SIG_BLOCK, &amp;allsigs, NULL);<br>
<br>
 =A0 =A0 =A0 =A0program =3D argv[0];<br>
<br>
_______________________________________________<br>
autofs mailing list<br>
<a href=3D"mailto:autofs@linux.kernel.org">autofs@linux.kernel.org</a><br>
<a href=3D"http://linux.kernel.org/mailman/listinfo/autofs" target=3D"_blan=
k">http://linux.kernel.org/mailman/listinfo/autofs</a><br>
</blockquote></div><br>

--00163683222aeedaa9046cd27492--


--===============4828627739492333955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============4828627739492333955==--

