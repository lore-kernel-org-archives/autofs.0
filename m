From: Ian Kent <raven@themaw.net>
Subject: Re: failed to mount offset
Date: Fri, 10 Jun 2011 10:58:53 +0800
Message-ID: <1307674733.3393.12.camel@perseus.themaw.net>
References: <BANLkTinFxOHK1NMJfBy5bjHMpozM8oY9kg@mail.gmail.com>
	<1307539055.3275.64.camel@perseus.themaw.net>
	<20110608134326.GB16849@eeg.ccf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=XGzVZaUnyg/h9erk11cN2YV6TY8=;
	b=FGQN4UdwksZEafP6n3Qvioj0lz42jFx5ko9MtHnXiOITEgNLKzTSceDpcsxwTFNQ8JNGmfWzHiIfZmnqwHPS0Ec7vBeYfB9rm/b3HfVSmoOb/VWWBhpoj1KnPyBahBClegpQL4c1N6ZXuPNDCRAqp1piMUyPXiBinCzytrNgCyk=
In-Reply-To: <20110608134326.GB16849@eeg.ccf.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Greg Wooledge <wooledg@eeg.ccf.org>
Cc: autofs@linux.kernel.org

On Wed, 2011-06-08 at 09:43 -0400, Greg Wooledge wrote:
> On Wed, Jun 08, 2011 at 09:17:35PM +0800, Ian Kent wrote:
> > On Wed, 2011-06-08 at 05:06 -0500, Mag Gam wrote:
> > > Trying to mount a newly created volume on a fileserver (appliance) and
> > > nis. Able to see the volume using showmount and able to mount so, I
> > > don't believe its a permission problem.
> 
> > I'm guessing you are using the hosts map?
> > 
> > You will get that until the mount tree under /net/appliance expires away
> > so the exported entries can be updated. The exported entries can't be
> > sanely updated while the mount tree under the server directory is being
> > used since export list can be hierarchical and so can have order of
> > mount/umount dependencies.
> 
> When you add a new file system (or a new export at least) to an NFS
> server that is being accessed through the hosts map, there is no way
> to tell autofs on the clients to re-read the list of exports.  As Ian
> says, it can't be updated while autofs is still running.
> 
> The only workaround is to reboot the client systems.  Sorry.  It affects
> us too.

Or get the mount to expire away, which, as you observe is hard to do on
a busy system.

I've been thinking about this for a while now as I do need to improve
the situation.

I should be able to check for dependent mount sub-trees and avoid
updating only those until they aren't in use, since they should be
handled as sub-trees (for both mounting and expiring) at points in the
tree that introduce dependencies. But I suspect the sub-tree handling
code doesn't actually work how I originally wanted it to, so that will
also make it harder.

Consequently, it's going to be fairly difficult to implement so I won't
start working on it until I have a clearer picture of how I'll do it.
And these the "failed to mount offset" messages sound like they need
work as well.

Ian
