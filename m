From: "Francesco P. Lovergine" <f.lovergine@ba.issia.cnr.it>
Subject: Re: NIS maps loading.
Date: Tue, 25 Jan 2005 16:50:21 +0100
Message-ID: <20050125155021.GC8093@ba.issia.cnr.it>
References: <41F56D27.1080005@redhat.com>
	<Pine.LNX.4.58.0501250904250.21644@wombat.indigo.net.au>
	<20050125121827.GE2032@ba.issia.cnr.it>
	<16886.26557.799629.351909@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <16886.26557.799629.351909@segfault.boston.redhat.com>
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
Cc: sesse@debian.org

On Tue, Jan 25, 2005 at 10:37:33AM -0500, Jeff Moyer wrote:
> ==> Regarding [autofs] NIS maps loading.; "Francesco P. Lovergine" <frankie@debian.org> adds:
> 
> frankie> Changes in indirect maps such as auto.home distributed via NIS are
> frankie> ignored until all daemons are killed and restarted.  That's of
> frankie> course not always possible or practical (it requires all users
> frankie> logout). This behavior is not present in other *nix such as
> frankie> Solaris or True64, so it can be considered a true bug.
> 
> This is a known issue, and there are patches to address it.  Depending on
> what kernel you are running, you may also have to patch that as well.
> 
> Unfortunately, I can't find the map update patch in the usual place.  You
> can get it from the srpms here:
> 
>      http://people.redhat.com/jmoyer/
> 
> Grab the latest srpm, and extract these two patches:
> 
>      autofs-4.1.3-ian-map-expiry-1.patch
>      autofs-4.1.3-ian-map-expiry-multimount-fix.patch
> 
> The kernel patch you want is also listed on the website above.  You could
> also just wait for 4.1.4 (or the beta version thereof).

Uhm, probably we missed that in current debian. Isn't it the same of FC3?

-- 
Francesco P. Lovergine
