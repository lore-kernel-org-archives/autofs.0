From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: NIS maps loading.
Date: Tue, 25 Jan 2005 10:37:33 -0500
Message-ID: <16886.26557.799629.351909@segfault.boston.redhat.com>
References: <41F56D27.1080005@redhat.com>
	<Pine.LNX.4.58.0501250904250.21644@wombat.indigo.net.au>
	<20050125121827.GE2032@ba.issia.cnr.it>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050125121827.GE2032@ba.issia.cnr.it>
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
To: "Francesco P. Lovergine" <frankie@debian.org>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] NIS maps loading.; "Francesco P. Lovergine" <frankie@debian.org> adds:

frankie> Changes in indirect maps such as auto.home distributed via NIS are
frankie> ignored until all daemons are killed and restarted.  That's of
frankie> course not always possible or practical (it requires all users
frankie> logout). This behavior is not present in other *nix such as
frankie> Solaris or True64, so it can be considered a true bug.

This is a known issue, and there are patches to address it.  Depending on
what kernel you are running, you may also have to patch that as well.

Unfortunately, I can't find the map update patch in the usual place.  You
can get it from the srpms here:

     http://people.redhat.com/jmoyer/

Grab the latest srpm, and extract these two patches:

     autofs-4.1.3-ian-map-expiry-1.patch
     autofs-4.1.3-ian-map-expiry-multimount-fix.patch

The kernel patch you want is also listed on the website above.  You could
also just wait for 4.1.4 (or the beta version thereof).

Hope this helps.

Jeff
