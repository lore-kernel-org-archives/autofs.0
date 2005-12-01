From: Ian Kent <raven@themaw.net>
Subject: Re: auto.net gets a key with a path under SLES9.
Date: Fri, 2 Dec 2005 00:20:14 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0512020020010.6439@donald.themaw.net>
References: <4378ED9A.6090903@deragon.biz> <43877F6F.5000708@deragon.biz>
	<Pine.LNX.4.63.0511272135350.2462@donald.themaw.net>
	<438E01A0.8060205@deragon.biz>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <438E01A0.8060205@deragon.biz>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Deragon <hans@deragon.biz>
Cc: autofs@linux.kernel.org

On Wed, 30 Nov 2005, Hans Deragon wrote:

> Resending this email since it seams not to have made it to the mailing list.

My bad. Sorry.

> 
> -Hans
> 
> -------------------------->
> 
> Ian Kent wrote:
> > On Fri, 25 Nov 2005, Hans Deragon wrote:
> > 
> > 
> > > Greetings.
> > > 
> > > 
> > >  Well, I successfully reproduced the problem of a path sent to auto.net
> > > (see
> > > below for full description).  Attached, the debug output on syslogd.  From
> > > what I understand of the syslogd logs, the problem occurs before
> > > sun_mount()
> > > is called.
> > > 
> > >  What I did was:
> > > 
> > >  cd /net/asterix  # Everything is ok.  $key=asterix
> > >  cd asteris-07    # Bug:  $key=asterix/asterix-07
> > 
> > 
> > Yes. Undoubtably the problem and that will be in the kernel module.
> > 
> > 
> > >  What was passed to auto.net was asterix/asterix-07 at the second 'cd'.
> > 
> > 
> > I would like to see the output of auto.net run manually and with the
> > incorrect key please.
> > 
> > Do you have access to the source for for the kernel you are using so that we
> > may check the patch levels?
> > 
> > Ian
> 
> Greetings Ian.
> 
> 
>    Here is the output of auto.net.
> 
> [root@mysystem etc] auto.net asterix/asterix-07
> /usr/sbin/showmount: can't get address for asterix/asterix-07
> [root@mysystem etc] auto.net asterix
> -fstype=nfs,hard,intr,nodev,nosuid \
>          /asterix-00 asterix:/asterix-00 \
>          /asterix-01 asterix:/asterix-01 \
>          /asterix-02 asterix:/asterix-02 \
>          /asterix-03 asterix:/asterix-03 \
>          /asterix-04 asterix:/asterix-04 \
>          /asterix-05 asterix:/asterix-05 \
>          /asterix-06 asterix:/asterix-06
> 
>    Please note that in my previous email, when I reproduced
>    the problem, I used a patched auto.net which would remove
>    the path.  This is not the case above, since I wanted to
>    reproduce the problem for you.
> 
>    This said, I just realized that the recursive path problem
>    occurs when I try to 'cd' to an NFS share that does not
>    exist (I have not realized this earlier; my bad).  For
>    instance, with my patched auto.net,
>    /net/asterix/asterix-07 mounts with the content of
>    /net/asterix, which is wrong.  It should not mount.
> 
>    So I am starting to realize that maybe there is no bug...
>    If I leave auto.net untouched, I do get the proper error,
>    i.e.:
> 
>    [root@mysystem /net/asterix] cd asterix-07
>    -bash: cd: asterix-07: No such file or directory
> 
>    Yet... I think that auto.net should not receive a path.
>    So there might be a bug, but a minor one?
> 
>    I would need to find a case where a path is sent to
>    auto.net when trying to access a valid NFS share.
> 
>    Attached, the auto.net, unpatched (actually, my patch is
>    commented out).
> 
>    Also, I do have the kernel's source.
> 
> 
> Best regards,
> Hans Deragon
> --
> Consultant en informatique/Software Consultant
> Deragon Informatique inc.
> http://www.deragon.biz        Open source (contribution):
> mailto://hans@deragon.biz     http://autopoweroff.deragon.biz
> 
> 
