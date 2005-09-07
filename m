From: Ian Kent <raven@themaw.net>
Subject: Re: correct format for mounting cifs/smbfs shares
Date: Thu, 8 Sep 2005 00:03:36 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0509072358450.2552@donald.themaw.net>
References: <17182.62683.375367.892022@segfault.boston.redhat.com>
	<431F0527.5060701@int-evry.fr>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <431F0527.5060701@int-evry.fr>
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
To: Jehan PROCACCIA <Jehan.Procaccia@int-evry.fr>
Cc: autofs@linux.kernel.org

On Wed, 7 Sep 2005, Jehan PROCACCIA wrote:

> For automounting smb/cif I use this:
> 
> $ tail -3 /etc/auto.misc
> windowsshare
> -fstype=smbfs,username=mylogin,workgroup=myworkgroup,credentials=/etc/smbwindows.auth
> ://winserver/share1
> unixshare    -fstype=smbfs,username=mylogin,credentials=/etc/smbunix.auth
> ://sambaserver/mylogin
> 
> $ cat /etc/smbunix.auth
> username=mylogin
> password=secret
> 
> $ cat /etc/smbwindows.auth
> username=mylogin
> password=secret
> 
> $ cd /misc/windowsshare
> [root@calaz /misc/windowsshare]
> $ df .
> Filesystem           1K-blocks      Used Available Use% Mounted on
> //winserver/share1        858652672 122945536 735707136  15%
> /misc/windowsshare
> 
> 
> However, as you can see, I need two smb*.auth files because my password is
> diffrent on both shares (windows/unix)
> And the major problem is THE use of a smb.auth file where the password must be
> in clear text :-( . If someone knows how to automount cifs/smb FS without
> pre-entering the password ... The problem is that If I don't do that,
> autofs/mount won't prompt me to enter the password :-(
> pehaps there's something to do with pamcred ... ?

Mount doesn't know how to do this.
I agree that clear text passwords ar bad.
Aren't the permissions restrictive enough to protect them?

I don't know what pamcred could do. Let me know if you find a better 
method.

> 
> thanks .
> 
> Jeff Moyer wrote:
> 
> > Hi,
> > 
> > I had a user report a bug as follows:
> > 
> > ---
> > Description of problem:
> > automount does not understand //hostname in its config files, which is
> > needed by mount.cifs and mount.smbfs
> > I found a "solution", but I don't like it:
> > use \/\/hostname in /etc/auto.misc file
> > 
> > 
> > Version-Release number of selected component (if applicable):
> > autofs-4.1.3-114
> > samba-client-3.0.14a-2.1.fc3.kde
> > 
> > How reproducible:
> > Always
> > 
> > Steps to Reproduce:
> > 1. put following line in /etc/auto.misc file:
> > share  -fstype=cifs
> > //HOST/SHARE
> > (of course, I hope that you have host HOST with share SHARE and you can make
> > mount -t cifs //HOST/SHARE /misc/share)
> > 
> > 2. ls /misc/share  
> > Actual Results:  in /var/log/messages:
> > automount[1624]: mount(generic): failed to mount  (type cifs) on
> > /misc/share/HOST/share
> > 
> > Expected Results:  //HOST/SHARE mounted in /misc/share
> > ;-)
> > 
> > Additional info:
> > 
> > Same results with -fstype=smb
> > ---
> > 
> > I have no experience with this.  What is the expected configuration to get
> > this to work?
> > 
> > Thanks,
> > 
> > Jeff
> > 
> > _______________________________________________
> > autofs mailing list
> > autofs@linux.kernel.org
> > http://linux.kernel.org/mailman/listinfo/autofs
> >  
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 
