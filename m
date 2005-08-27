From: Ian Kent <raven@themaw.net>
Subject: Re: Cascading/recursive autofs mounts?
Date: Sat, 27 Aug 2005 11:44:55 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0508271135070.2069@donald.themaw.net>
References: <20050825201342.GB4935@neu.nirvana>
	<17166.11678.314365.509696@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0508261153330.2586@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0508261153330.2586@wombat.indigo.net.au>
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
To: Axel Thimm <Axel.Thimm@atrpms.net>
Cc: autofs mailing list <autofs@linux.kernel.org>


Of course this should have been a reply to Axel. Sorry Jeff.

On Fri, 26 Aug 2005, Ian Kent wrote:

> On Thu, 25 Aug 2005, Jeff Moyer wrote:
> 
> > ==> Regarding [autofs] Cascading/recursive autofs mounts?; Axel Thimm <Axel.Thimm@atrpms.net> adds:
> > 
> > Axel.Thimm> Hi, we have a setup, where we would like to have autofs mount
> > Axel.Thimm> over NFS a certain folder and then bind-mount from subfolders
> > Axel.Thimm> to other places.
> > 
> > Axel.Thimm> Can this work with autofs? E.g. can autofs cascade mount
> > Axel.Thimm> requests?  E.g. if the first autofs request would require a
> > Axel.Thimm> second one to be performed first, would the second one properly
> > Axel.Thimm> mount the NFS share and the outer one continue with bind
> > Axel.Thimm> mounting?. It looks like the first one would lock
> > Axel.Thimm> /var/lock/autofs and the inner autofs request would fail.
> > 
> > Correct.  The way things are structured in autofs4.1.4, recursive mounts
> > such as this are not supported.
> 
> This should be able to be done with Sun style offset mounts (which we are 
> calling multi-mounts). We can't do that atm but that's comming.

Saying that this can't be done is not entirely correct.

What can be done now is to specify your mounts as a multi-mount map entry.

The limitation is that, currently, a multi-mount must be treated as a 
single unit. Meaning that all the offsets must be mounted on access and 
similarly on umount.

For example a map entry like:

example		/	host:/you/nfs/mount \
		/other/one	:/dev/sda1 \
		/this/two	host2:/another/mount

would mount all three of these and not umount them until all three have 
been idle for at least timout.

The auto.net example program map script does this for a list of exports 
when passed a key corresponding to a server server.

Ian
