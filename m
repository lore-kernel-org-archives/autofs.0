From: "Rajouri Jammu" <rajouri.jammu@gmail.com>
Subject: Re: wait_for_lock() in mount
Date: Sat, 19 Apr 2008 10:52:16 -0700
Message-ID: <3307cdf90804191052v194cc2bctb25b6aab612e903d@mail.gmail.com>
References: <3307cdf90804180939t42fed2d7k8fc96304f8d01455@mail.gmail.com>
	<1208576146.3090.5.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6145197287216573936=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1208576146.3090.5.camel@raven.themaw.net>
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

--===============6145197287216573936==
Content-Type: multipart/alternative; 
	boundary="----=_Part_8388_32949118.1208627536054"

------=_Part_8388_32949118.1208627536054
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you for the prompt response.
Yes, I'm using autofs4 which came with CentOS release 4.6

mount -V
mount: mount-2.12a

Is that version of mount OK or do I need a newer version to work with the
locking path?
If I need a newer version can you please let me know approximately which
one?

Lastly, does autofs5 not have this issue?


Thanks,

On Fri, Apr 18, 2008 at 8:35 PM, Ian Kent <raven@themaw.net> wrote:

>
> On Fri, 2008-04-18 at 09:39 -0700, Rajouri Jammu wrote:
> > Hi,
> >
> >
> > I'm trying to bring up a stacked file system on top of an NFS mount
> > point both via automount.
> >
> >
> > For example:
> > On my client system I have two directories /data1 and /data2
> > /data1/nfs_01
> > /data2/nfs_01
> >
> >
> > nfs_server:/data/nfs_01 is mounted on /data1/nfs_01 (type nfs)
> >
> >
> > /data1/nfs_01 is mounted on /data2/nfs_01
> >
> >
> > The automount config files look like:
> > /etc/auto.data1:
> > nfs_01   nfs_server:/data/nfs_01
> >
> >
> >
> > /etc/auto.data2:
> > nfs_01   -fstype=ecryptfs :/data1/nfs_01
> >
> >
> >
> >
> > The problem:
> >
> >
> > When I try to access /data2/nfs_01 it kicks in automount to
> > mount /data1/nfs_01, which in turn kicks in automount again to mount
> > nfs_server:/data/nfs_01 on /data1/nfs_01.
> >
> >
> > The second mount waits for 10secs for a lock file held by the first
> > mount in mount_nfs.c after mkdir_path().
>
> So you're running version 4?
>
> >
> >
> > Is there a way I can configure things such that the second mount
> > doesn't wait?
>
> There is a patch around to add a configure option
> "--disable-mount-locking" but you need to be sure you're mount(8) is at
> least reasonably up to date.
>
> You may want to look in
> http://www.kernel.org/pub/linux/daemons/autofs/v4/
>
> >
> >
> >
> > The lock file is a single global.
> >
> > Should the file be specific to the mount point?
>
> No, it is meant help prevent corruption of /etc/mtab as the locking in
> mount(8) was broken for a long time.
>
> Ian
>
>
>
>

------=_Part_8388_32949118.1208627536054
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you for the prompt response.<div><br></div><div>Yes, I&#39;m using autofs4 which came with CentOS release 4.6&nbsp;</div><div><br></div><div>mount -V</div><div>mount: mount-2.12a<br></div><div><br></div><div>Is that version of mount OK or do I need a newer version to work with the locking path?</div>
<div>If I need a newer version can you please let me know approximately which one?</div><div><br></div><div>Lastly, does autofs5 not have this issue?</div><div><br></div><div><div><br></div><div>Thanks,</div><div><br><div class="gmail_quote">
On Fri, Apr 18, 2008 at 8:35 PM, Ian Kent &lt;<a href="mailto:raven@themaw.net">raven@themaw.net</a>&gt; wrote:<br><blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"><div class="Ih2E3d">
<br>
On Fri, 2008-04-18 at 09:39 -0700, Rajouri Jammu wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt;<br>
&gt; I&#39;m trying to bring up a stacked file system on top of an NFS mount<br>
&gt; point both via automount.<br>
&gt;<br>
&gt;<br>
&gt; For example:<br>
&gt; On my client system I have two directories /data1 and /data2<br>
&gt; /data1/nfs_01<br>
&gt; /data2/nfs_01<br>
&gt;<br>
&gt;<br>
&gt; nfs_server:/data/nfs_01 is mounted on /data1/nfs_01 (type nfs)<br>
&gt;<br>
&gt;<br>
&gt; /data1/nfs_01 is mounted on /data2/nfs_01<br>
&gt;<br>
&gt;<br>
&gt; The automount config files look like:<br>
&gt; /etc/auto.data1:<br>
&gt; nfs_01 &nbsp; nfs_server:/data/nfs_01<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; /etc/auto.data2:<br>
&gt; nfs_01 &nbsp; -fstype=ecryptfs :/data1/nfs_01<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; The problem:<br>
&gt;<br>
&gt;<br>
&gt; When I try to access /data2/nfs_01 it kicks in automount to<br>
&gt; mount /data1/nfs_01, which in turn kicks in automount again to mount<br>
&gt; nfs_server:/data/nfs_01 on /data1/nfs_01.<br>
&gt;<br>
&gt;<br>
&gt; The second mount waits for 10secs for a lock file held by the first<br>
&gt; mount in mount_nfs.c after mkdir_path().<br>
<br>
</div>So you&#39;re running version 4?<br>
<div class="Ih2E3d"><br>
&gt;<br>
&gt;<br>
&gt; Is there a way I can configure things such that the second mount<br>
&gt; doesn&#39;t wait?<br>
<br>
</div>There is a patch around to add a configure option<br>
&quot;--disable-mount-locking&quot; but you need to be sure you&#39;re mount(8) is at<br>
least reasonably up to date.<br>
<br>
You may want to look in<br>
<a href="http://www.kernel.org/pub/linux/daemons/autofs/v4/" target="_blank">http://www.kernel.org/pub/linux/daemons/autofs/v4/</a><br>
<div class="Ih2E3d"><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; The lock file is a single global.<br>
&gt;<br>
&gt; Should the file be specific to the mount point?<br>
<br>
</div>No, it is meant help prevent corruption of /etc/mtab as the locking in<br>
mount(8) was broken for a long time.<br>
<font color="#888888"><br>
Ian<br>
<br>
<br>
<br>
</font></blockquote></div><br></div></div>

------=_Part_8388_32949118.1208627536054--


--===============6145197287216573936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6145197287216573936==--

