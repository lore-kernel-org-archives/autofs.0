From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] Updated autofs-4.1.3-signal-race-fix.patch
Date: Tue, 19 Oct 2004 11:46:21 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0410191144440.7757@wombat.indigo.net.au>
References: <1098114614.6300.11.camel@dhcp187.msp.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1098114614.6300.11.camel@dhcp187.msp.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Feist <cfeist@redhat.com>
Cc: autofs@linux.kernel.org

On Mon, 18 Oct 2004, Chris Feist wrote:

> Ian,
> 
> I've attached an updated patch from Jeff Moyer's earlier signal race
> patch which allows the SIGCHLD signal to be received in the middle of
> st_expire() before ap.state can be set to ST_EXPIRE.  This causes the
> signal handling function for SIG_CHLD to never run the alarm() function
> which causes the SIGALRM signal to never be sent (or received) by
> automount, which causes directories w/ a timeout to never be unmounted.
> 

Cool. Thanks.

I'll check and add it to the list of patches I'm collecting.

Ian
