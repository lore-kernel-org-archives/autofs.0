From: Greg Wooledge <wooledg@eeg.ccf.org>
Subject: Re: Failure to Unmount NFS Filesystems causes clients to
	hang on reboot
Date: Tue, 7 Sep 2004 08:18:37 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040907121837.GF17289@eeg.ccf.org>
References: <41379465.6030603@physics.ucsd.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <41379465.6030603@physics.ucsd.edu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Terrence Martin <tmartin@physics.ucsd.edu>
Cc: autofs@linux.kernel.org

On Thu, Sep 02, 2004 at 02:45:09PM -0700, Terrence Martin wrote:
> I am having a problem where my client machines are not able to reboot 
> correctly because the NFS mounted file systems are hanging at shutdown 
> time and refuse to unmount.

I don't know anything about your version of Red Hat, but in some older
versions, I've seen the symlinks to the shutdown scripts in the wrong
order.  Take a look through your shutdown directories (/etc/rc.d/rc0.d
and rc5.d and rc6.d, assuming it's unchanged from RH6) and make sure
that any network-mounted file systems are unmounted *before* the network
is brought down.

(I had this problem on a Red Hat 6.2 system, which had been upgraded from
Red Hat 5.x.  The upgrade didn't handle the renaming of the symlinks
cleanly.)
