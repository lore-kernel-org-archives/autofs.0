From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [ANNOUNCE] autofs 4.1.4 beta2 release
Date: Tue, 15 Feb 2005 03:04:14 +0100
Message-ID: <20050215020414.GA953@uio.no>
References: <Pine.LNX.4.61.0502142233210.1653@donald.themaw.net>
	<20050215014857.GA26216@uio.no>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20050215014857.GA26216@uio.no>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Tue, Feb 15, 2005 at 02:48:57AM +0100, Steinar H. Gunderson wrote:
> Apart from that, looks like everything went in; I'm building a new version
> now and will upload after I get your feedback on the points above.

I just found another bug; on upgrades, autofs attempts to restart itself,
which invokes "debian stop"; this invokes something like

  start-stop-daemon --stop --quiet --retry USR2/$DAEMON_EXIT_WAIT --pidfile $file --exec /usr/sbin/automount

The problem here is that the pid does not really run /usr/sbin/automount
anymore; or more correctly, /proc/<pid>/exe does not point to the current
/usr/sbin/automount, it points to the _old_ /usr/sbin/automount, and that
version was just removed as part of the upgrade.  Thus, the stop fails, and the
entire upgrade fails.

Any good ideas? Stripping the --exec would be the easiest solution, but
perhaps also the ugliest...
 
/* Steinar */ 
-- 
Homepage: http://www.sesse.net/
