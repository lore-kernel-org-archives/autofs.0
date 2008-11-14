From: "Mike K" <mrkfact@gmail.com>
Subject: Re: Caching negative lookups
Date: Fri, 14 Nov 2008 08:27:56 -0500
Message-ID: <e28c2a430811140527g7fbfb49aj652a1bfc4df3e5e1@mail.gmail.com>
References: <e28c2a430811030703w654ffafcuf47a95b450e6de37@mail.gmail.com>
	<1226628492.2906.15.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1503715983376653597=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1226628492.2906.15.camel@zeus.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

--===============1503715983376653597==
Content-Type: multipart/alternative; 
	boundary="----=_Part_24136_25739439.1226669276899"

------=_Part_24136_25739439.1226669276899
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ian,

Sorry for the confusion.  Yes, auto_dev is a simple indirect map.  Since it
is a negative lookup, the entry we are looking up doesn't exist in the
auto_dev map, so I didn't bother showing any of its contents.

So for some reason it appears that negative caching does not work for the
example I previous described since there is one lookup for every "cd
/home/dev/example", not one lookup for every negative timeout seconds.

- Mike

On Thu, Nov 13, 2008 at 9:08 PM, Ian Kent <raven@themaw.net> wrote:

> On Mon, 2008-11-03 at 10:03 -0500, Mike K wrote:
> > Hello,
> >
> > Based on what I have found, autofs5 supports caching negative lookups,
> > but it doesn't appear to be working for me.  Although my understanding
> > of how it is supposed to work is very limited, so I may just be
> > mistaken.
> >
> > My client system:  Red Hat 5.2, autofs-5.0.1-0.rc2.88.x86_64,
> > kernel-2.6.18-92.el5.x86_64, with automounter maps in a NIS+ server
> > (client in niscompat mode).
> > NFS Server: A popular NAS appliance
> >
> > auto_master snippet:
> > /home/dev auto_dev
>
> Is this meant to convey meaningful information?
> Is auto_dev a simple indirect map?
>
> >
> > By default (and a recommended setting), the NAS appliance requires
> > that all mounts from uid 0 come from a reserved port (0-1024) on the
> > client.  On our client system, repeated yp lookups for entries which
> > don't exist will consume all ports in 0-1024, causing other legit
> > mount attempts to fail since they are denied by the NAS appliance.
> > This does not happen on Red Hat 4 or 3 systems.
> >
> > Reproducer: 'while true; do cd /home/dev/example; done'.  "watch -n 1
> > 'netstat -an | grep TIME_WAIT | wc -l'" will show the number of
> > sockets in TIME_WAIT increase rapidly.
> >
> > In this case, each 'cd /home/dev/example' causes a yp lookup for a
> > directory that doesn't exist in the NIS table, consuming a socket and
> > leaving it in TIME_WAIT for 60 seconds.
> >
> > Is this situation supposed to be prevented with caching negative
> > lookups?
>
> If auto_dev is a simple indirect map there should be one lookup every
> negative timeout seconds.
>
> >
> > Thanks,
> > Mike
> > _______________________________________________
> > autofs mailing list
> > autofs@linux.kernel.org
> > http://linux.kernel.org/mailman/listinfo/autofs
>
>

------=_Part_24136_25739439.1226669276899
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ian, <br><br>Sorry for the confusion.&nbsp; Yes, auto_dev is a simple indirect map.&nbsp; Since it is a negative lookup, the entry we are looking up doesn&#39;t exist in the auto_dev map, so I didn&#39;t bother showing any of its contents.<br>
<br>So for some reason it appears that negative caching does not work for the example I previous described since there is one lookup for every &quot;cd /home/dev/example&quot;, not one lookup for every negative timeout seconds.<br>
<br>- Mike<br><br><div class="gmail_quote">On Thu, Nov 13, 2008 at 9:08 PM, Ian Kent <span dir="ltr">&lt;<a href="mailto:raven@themaw.net">raven@themaw.net</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Mon, 2008-11-03 at 10:03 -0500, Mike K wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; Based on what I have found, autofs5 supports caching negative lookups,<br>
&gt; but it doesn&#39;t appear to be working for me. &nbsp;Although my understanding<br>
&gt; of how it is supposed to work is very limited, so I may just be<br>
&gt; mistaken.<br>
&gt;<br>
&gt; My client system: &nbsp;Red Hat 5.2, autofs-5.0.1-0.rc2.88.x86_64,<br>
&gt; kernel-2.6.18-92.el5.x86_64, with automounter maps in a NIS+ server<br>
&gt; (client in niscompat mode).<br>
&gt; NFS Server: A popular NAS appliance<br>
&gt;<br>
&gt; auto_master snippet:<br>
&gt; /home/dev auto_dev<br>
<br>
</div>Is this meant to convey meaningful information?<br>
Is auto_dev a simple indirect map?<br>
<div class="Ih2E3d"><br>
&gt;<br>
&gt; By default (and a recommended setting), the NAS appliance requires<br>
&gt; that all mounts from uid 0 come from a reserved port (0-1024) on the<br>
&gt; client. &nbsp;On our client system, repeated yp lookups for entries which<br>
&gt; don&#39;t exist will consume all ports in 0-1024, causing other legit<br>
&gt; mount attempts to fail since they are denied by the NAS appliance.<br>
&gt; This does not happen on Red Hat 4 or 3 systems.<br>
&gt;<br>
&gt; Reproducer: &#39;while true; do cd /home/dev/example; done&#39;. &nbsp;&quot;watch -n 1<br>
&gt; &#39;netstat -an | grep TIME_WAIT | wc -l&#39;&quot; will show the number of<br>
&gt; sockets in TIME_WAIT increase rapidly.<br>
&gt;<br>
&gt; In this case, each &#39;cd /home/dev/example&#39; causes a yp lookup for a<br>
&gt; directory that doesn&#39;t exist in the NIS table, consuming a socket and<br>
&gt; leaving it in TIME_WAIT for 60 seconds.<br>
&gt;<br>
&gt; Is this situation supposed to be prevented with caching negative<br>
&gt; lookups?<br>
<br>
</div>If auto_dev is a simple indirect map there should be one lookup every<br>
negative timeout seconds.<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Mike<br>
&gt; _______________________________________________<br>
&gt; autofs mailing list<br>
&gt; <a href="mailto:autofs@linux.kernel.org">autofs@linux.kernel.org</a><br>
&gt; <a href="http://linux.kernel.org/mailman/listinfo/autofs" target="_blank">http://linux.kernel.org/mailman/listinfo/autofs</a><br>
<br>
</blockquote></div><br>

------=_Part_24136_25739439.1226669276899--


--===============1503715983376653597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1503715983376653597==--

