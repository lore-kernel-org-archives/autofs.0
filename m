From: Frank Cusack <fcusack@fcusack.com>
Subject: Re: [autofs] Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Thu, 18 Sep 2003 19:57:49 -0700
Sender: nfs-admin@lists.sourceforge.net
Message-ID: <20030918195749.A2273@google.com>
References: <Pine.LNX.4.44.0309151941550.18622-100000@moisil.badula.org> <Pine.LNX.4.44.0309151828050.1920-100000@fubar.phlinux.com>
Mime-Version: 1.0
Return-path: <nfs-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309151828050.1920-100000@fubar.phlinux.com>; from wago@phlinux.com on Mon, Sep 15, 2003 at 06:34:33PM -0700
Errors-To: nfs-admin@lists.sourceforge.net
List-Help: <mailto:nfs-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:nfs@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/nfs>,
	<mailto:nfs-request@lists.sourceforge.net?subject=subscribe>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/nfs>,
	<mailto:nfs-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=nfs>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>, autofs@linux.kernel.org, nfs@lists.sourceforge.net

On Mon, Sep 15, 2003 at 06:34:33PM -0700, Matt C wrote:
> On Mon, 15 Sep 2003, Ion Badulescu wrote:
> > On Mon, 15 Sep 2003, H. Peter Anvin wrote:
> > > Arun Sharma wrote:
> > > >>
> > > >> Oh yeah, easily. Kill the automounter while some things are mounted,
> > > >> unmount everything by hand but do not rmdir the mountpoints. When you
> > > >> unmount the autofs filesystem itself, you will get the self destruct
> > > >> message.
> > > > 
> > > > Thanks. This reproduces the problem I'm chasing very well. I think this
> > > > is clearly an unacceptable kernel bug.
> > > > 
> > > Indeed.  This is on autofs 3?
> > 
> > Both 3 and 4, at least as far as the "self-destruct" message goes.
>
> Don't know if it helps, but we also run a few hundred autofs4 clients, 
> with a mix of 2.4.21 and 2.4.18. The 2.4.21 machines are seeing quite a 
> few of these messages, but not on the 2.4.18 machines. We haven't seen any 
> of the oopses described below, though.

Same here, 2.4.22, autofs 3 and 4.  I'll be playing with 2.6.0 next week.

I haven't tried to reproduce it with your method, but I do see the bug;
no oops though.

/fc


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
NFS maillist  -  NFS@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/nfs
