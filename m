From: raven@themaw.net
Subject: Re: NIS maps loading.
Date: Wed, 26 Jan 2005 22:49:00 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0501262243490.1716@donald.themaw.net>
References: <41F56D27.1080005@redhat.com>
	<Pine.LNX.4.58.0501250904250.21644@wombat.indigo.net.au>
	<20050125121827.GE2032@ba.issia.cnr.it>
Mime-Version: 1.0
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: "Francesco P. Lovergine" <frankie@debian.org>
Cc: autofs@linux.kernel.org

On Tue, 25 Jan 2005, Francesco P. Lovergine wrote:

> Changes in indirect maps such as auto.home
> distributed via NIS are ignored until all daemons are killed and
> restarted.
> That's of course not always possible or practical (it requires all
> users logout). This behavior is not present in other *nix such as
> Solaris or True64, so it can be considered a true bug.

Umm ... thats been discussed quite a bit on the list. You must have missed 
it. It was a fair while ago.

As is mentioned later in this thread, I did create patches for this but as 
it was added funtionality (and was under test) it wasn't placed on kernel.org.

It is however in the 4.1.4 beta and I've made some additional fixes 
during testing the last couple of days. Please test this out in the beta.

Ian
