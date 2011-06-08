From: Greg Wooledge <wooledg@eeg.ccf.org>
Subject: Re: failed to mount offset
Date: Wed, 8 Jun 2011 09:43:26 -0400
Message-ID: <20110608134326.GB16849@eeg.ccf.org>
References: <BANLkTinFxOHK1NMJfBy5bjHMpozM8oY9kg@mail.gmail.com>
	<1307539055.3275.64.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1307539055.3275.64.camel@perseus.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Wed, Jun 08, 2011 at 09:17:35PM +0800, Ian Kent wrote:
> On Wed, 2011-06-08 at 05:06 -0500, Mag Gam wrote:
> > Trying to mount a newly created volume on a fileserver (appliance) and
> > nis. Able to see the volume using showmount and able to mount so, I
> > don't believe its a permission problem.

> I'm guessing you are using the hosts map?
> 
> You will get that until the mount tree under /net/appliance expires away
> so the exported entries can be updated. The exported entries can't be
> sanely updated while the mount tree under the server directory is being
> used since export list can be hierarchical and so can have order of
> mount/umount dependencies.

When you add a new file system (or a new export at least) to an NFS
server that is being accessed through the hosts map, there is no way
to tell autofs on the clients to re-read the list of exports.  As Ian
says, it can't be updated while autofs is still running.

The only workaround is to reboot the client systems.  Sorry.  It affects
us too.
