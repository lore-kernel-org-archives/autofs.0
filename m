From: Ian Kent <raven@themaw.net>
Subject: RE: making the mountpoints visible all the time (fwd)
Date: Mon, 17 Nov 2003 00:05:36 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0311170005180.12952-100000@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>


---------- Forwarded message ----------
Date: 16 Nov 2003 23:56:22 +0800
From: Ian Kent <raven@themaw.net>
To: "Rigler, Steve" <SRigler@MarathonOil.com>
Subject: RE: [autofs] making the mountpoints visible all the time

On Sat, 2003-11-15 at 05:34, Rigler, Steve wrote:
> > -----Original Message-----
> > From: autofs-bounces@linux.kernel.org
> > [mailto:autofs-bounces@linux.kernel.org]On Behalf Of 
> > Alexander Macdonald
> > Sent: Friday, November 14, 2003 2:20 PM
> > To: autofs@linux.kernel.org
> > Subject: Re: [autofs] making the mountpoints visible all the time
> > 
> > 
> > I'm using kernel 2.6.0-test9, i could only see patches for 2.4 so i 
> > guess this has the latest autofs in it allready right? I've also 
> > upgraded my daemon to autofs-4.1.0-beta3. I then tried running this:-
> > 
> > automount -g /mnt/network/samba/computerA file /etc/autofs/samba
> > 
> > in the file /etc/autofs/samba I have this:-
> > 
> > download    -fstype=smbfs,username=guest,password=none 
> > ://computera/Download
> > upload        -fstype=smbfs,username=guest,rw,password=none 
> > ://computera/Upload
> > 
> > it works fine but it still doesnt do the "ghosting"
> > 
> > 

There is no port of these changes for 2.6 yet.

I'm working on it and hope to submit my changes within a week. Hopefully
I'll get something into the kernel.

In fact, I don't have a 2.6 environment other than what I use to test at
home so volenteers are needed for testing. We can't expect the changes
to be accepted without some testing other than my simple setup.

> 
> I haven't tried the 2.6 kernel yet, so anything I suggest would be
> based on experience with the 2.4 kernel.
> 
> One thing is to make sure you have an entry in /etc/modules.conf
> to force loading of the autofs4 module.
> 
> It should look like:
> alias autofs autofs4

Yes.

The 4.1.0 betas contain an init script which checks and loads the
autofs4 kernel module first (ie. before autofs) so this shouldn't be
needed however it can't hurt.
 
-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
