From: Michael Blandford <mlblandf@sedona.ch.intel.com>
Subject: Re: NIS maps loading.
Date: Tue, 25 Jan 2005 08:24:13 -0700
Message-ID: <41F6649D.2030602@sedona.intel.com>
References: <41F56D27.1080005@redhat.com>	<Pine.LNX.4.58.0501250904250.21644@wombat.indigo.net.au>
	<20050125121827.GE2032@ba.issia.cnr.it>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Francesco P. Lovergine" <frankie@debian.org>
Cc: autofs@linux.kernel.org

Francesco P. Lovergine wrote:

>Changes in indirect maps such as auto.home
>distributed via NIS are ignored until all daemons are killed and 
>restarted.
>That's of course not always possible or practical (it requires all 
>users logout). This behavior is not present in other *nix such as 
>Solaris or True64, so it can be considered a true bug.
>
>  
>

What version of autofs are you using?  Have you applied the kernel 
patches at kernel.org ( if you aren't using 2.6.10 )

Michael
