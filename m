From: Ian Kent <raven@themaw.net>
Subject: Re: [NFS] RE: umount fails with NFS mounts
Date: Mon, 27 Sep 2004 09:34:48 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0409270933130.3879@wombat.indigo.net.au>
References: <Pine.LNX.4.44.0409240925460.9368-100000@maggie.lkpg.cendio.se>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0409240925460.9368-100000@maggie.lkpg.cendio.se>
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
To: Peter Astrand <peter@cendio.se>
Cc: autofs@linux.kernel.org, Erik Forsberg <forsberg@cendio.se>, nfs@lists.sourceforge.net

On Fri, 24 Sep 2004, Peter Astrand wrote:

> 
> > > Of course, the question is why a umount triggers a mount in the first 
> > > place...
> > 
> > Let me guess: automount has to consult the map to know the exact hostname
> > and options used to mount the filesystem, some of which are needed for the
> > unmount.  (Well, I always do "umount /mount/point" and it works, but maybe
> > the automounter needs to do more, such as finding and clearing an entry in
> > the list of filesystems it is responsible for.)  In your case, the map is
> > programmatic and includes the test mount.  But under obscure circumstances
> > the necessary case conversion isn't happening.
> 
> Can anyone confirm that the automounter actually may call the programmatic 
> map upon umount? If so, can the programmatic map detect that a umount is 
> happening, rather than a mount?

The program specified in a program mount is not called during umount.

Ian
