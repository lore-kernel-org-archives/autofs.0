From: Ian Kent <raven@themaw.net>
Subject: Re: Simple direct mout problem
Date: Tue, 03 Oct 2006 01:11:02 +0800
Message-ID: <1159809062.2905.7.camel@raven.themaw.net>
References: <45196B1C.5040303@onsemi.com>
	<1159324405.2897.27.camel@raven.themaw.net>
	<451ABD74.7060908@onsemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <451ABD74.7060908@onsemi.com>
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
To: Dana Wellen <dana.wellen@onsemi.com>
Cc: autofs@linux.kernel.org

On Wed, 2006-09-27 at 14:05 -0400, Dana Wellen wrote:
> Ian,
>   Finally figured it out, simply put:
> 
> auto.master
> 
> /-      yp:auto.linux
> 
> auto.linux
> 
> /some_mount_directory/example                   server:/nfs_export
> 
> works.  However if the yp map is changed to
> 
> /example                  server:/nsf_export 

That's what I said before.

> 
> it fails.  The error in the messages file aren't very helpful in
> figuring this simple error out.  
> 
> Will the next version (5) work more like the Sun automounter? I know
> in our case we are moving off of standard 
> Unix to Linux due to support being dropped for our main platform
> (HP-UX) for our CAD software vendors.

Yes. It does.

> 
> What I am seeing with indirect mounts and ghosting is that the only
> directories visible in the mount directory
> are directories that are mounted or been mounted but won't show the
> directories never mounted, examples:

No. It only creates directories that it can know about in advance.

For example, what directories would you create for a map entry:

*	&:/server/&

> 
> Before any mounts:
> 
> ls -la /proj
> total 8
> drwxr-xr-x   2 root root    0 Sep 27 14:02 .
> drwxr-xr-x  29 root root 4096 Sep 27 14:01 ..
> 
> ls /proj/some_directory
> file1 file2 directory1 directory2 etc..
> 
> ls -la /proj
> total 12
> drwxr-xr-x   3 root   root    0 Sep 27 14:03 .
> drwxr-xr-x  29 root   root 4096 Sep 27 14:01 ..
> drwxrwxr-x   9 root root  4096 Nov  3  2005 some_directory
> 
> Well after the 60 second timeout
> ls -la /proj
> total 12
> drwxr-xr-x   3 root   root    0 Sep 27 14:03 .
> drwxr-xr-x  29 root   root 4096 Sep 27 14:01 ..
> drwxrwxr-x   9 root root  4096 Nov  3  2005 some_directory
> 
> This directory holds over 100 subdirectories that the user can't see
> and can only be accessed if
> they know the name of the subdirectory.
> 
> Thanks,
> Dana
> 
> 
> Ian Kent wrote: 
> > On Tue, 2006-09-26 at 14:02 -0400, Dana Wellen wrote:
> >   
> > > Hello,
> > > 
> > >    Trying to setup a simple direct map using nis and the autofs automounter:
> > > 
> > > automount -V
> > > Linux automount version 4.1.3-67
> > >     
> > 
> > This version is way to old.
> > Update it.
> > 
> >   
> > > /etc/auto.master
> > > 
> > > /-      yp:auto.linux
> > > 
> > > 
> > > ypcat -k auto.linux
> > > 
> > > /proj server2:/vol/proj/xx_proj
> > >     
> > 
> > Nop.
> > There are an number of limitations with direct mounts in version 4.
> > Single level direct mounts is one.
> > 
> >   
> > > This is documented in the readme file in 
> > > /usr/share/doc/aufofs-4.1.3/README.direct
> > > 
> > > When the autofs is started or restarted in the /var/log/messages I get :
> > > 
> > > automount[25461]: cache_ghost: entry in yp:auto.linux not valid map 
> > > format, key /proj
> > > 
> > > If I use indirect mounts it works however direct mounts would be a lot 
> > > easier for my users in that
> > > they will be able to see the directories in the mounted directory.  The 
> > > ghost function doesn't work
> > > well because it will only show the mounted directories or the 
> > > directories that have been mounted
> > > since the last restart of the autofs.
> > >     
> > 
> > That's not correct.
> > 
> >   
> > >   If I copy the file to the /etc directory it still has a similar error.
> > >     
> > 
> > Huh ????
> > 
> >   
> > > aufofs-4.1.3/README.direct
> > > -- For example if we were using NIS we might have something like
> > > the map entries below.
> > > 
> > > In the master map:
> > > 
> > > /-      autofs.global
> > > 
> > > and in autofs.global:
> > > 
> > > /nfs/apps/mozilla       bogus:/usr/local/moxilla
> > > /nfs/data/budgets       tiger:/usr/local/budgets
> > > /tst/sbin               bogus:/usr/sbin
> > > 
> > > and so on.
> > >     
> > 
> > Note that the RedHat package has a config entry that disables direct
> > mounts by default because of the limitations.
> > 
> > Change it if you wish to try using them (in /etc/sysconfig/autofs).
> > 
> > Ian
> > 
> > 
> > 
> >   
> 
> -- 
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
