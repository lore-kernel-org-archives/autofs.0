From: "Francesco P. Lovergine" <f.lovergine@ba.issia.cnr.it>
Subject: Re: NIS maps loading.
Date: Tue, 25 Jan 2005 16:41:38 +0100
Message-ID: <20050125154138.GB8093@ba.issia.cnr.it>
References: <41F56D27.1080005@redhat.com>
	<Pine.LNX.4.58.0501250904250.21644@wombat.indigo.net.au>
	<20050125121827.GE2032@ba.issia.cnr.it>
	<41F6649D.2030602@sedona.intel.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <41F6649D.2030602@sedona.intel.com>
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

On Tue, Jan 25, 2005 at 08:24:13AM -0700, Michael Blandford wrote:
> Francesco P. Lovergine wrote:
> 
> >Changes in indirect maps such as auto.home
> >distributed via NIS are ignored until all daemons are killed and 
> >restarted.
> >That's of course not always possible or practical (it requires all 
> >users logout). This behavior is not present in other *nix such as 
> >Solaris or True64, so it can be considered a true bug.
> >
> > 
> >
> 
> What version of autofs are you using?  Have you applied the kernel 
> patches at kernel.org ( if you aren't using 2.6.10 )
> 
> Michael

Autofs 4.1.3-8 in Debian testing. That's with stock debian kernel 2.6.8
(which is a patched 2.6.8.1). I suspect that has nothing to do with
kernel space, anyway. It's a mere missing invalidation of NIS maps. 
Note that ypcat returns correctly the new map, but autofs continues
to use the wrong obsolete one. I can try 2.6.10 if you will feel better 
with that :) In fact, if the old map auto.home contains something like

frankie	hostA:/pathA

and the new map in the same file

frankie	hostB:/pathB

autofs will mount hostA:/pathA for user frankie instead of the new one.
The only workaround is restarting autofs daemon. That's obviuosly
true even if user home was not mounted previously.
BTW, I have the same problem with FC3. That's quite annoying, also
considering that other unices behaves correctly.

-- 
Francesco P. Lovergine
