From: "Francesco P. Lovergine" <frankie@debian.org>
Subject: Re: NIS maps loading.
Date: Tue, 25 Jan 2005 13:36:11 +0100
Message-ID: <20050125123611.GF2032@ba.issia.cnr.it>
References: <41F56D27.1080005@redhat.com>
	<Pine.LNX.4.58.0501250904250.21644@wombat.indigo.net.au>
	<20050125121827.GE2032@ba.issia.cnr.it>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Tue, Jan 25, 2005 at 01:18:27PM +0100, Francesco P. Lovergine wrote:
> Changes in indirect maps such as auto.home
> distributed via NIS are ignored until all daemons are killed and 
> restarted.
> That's of course not always possible or practical (it requires all 
> users logout). This behavior is not present in other *nix such as 
> Solaris or True64, so it can be considered a true bug.
> 

ugh, sorry for thread hijacking :-(

-- 
Francesco P. Lovergine
