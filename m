From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] fix SIGSEGV when yp domain not bound
Date: Wed, 5 May 2004 09:36:23 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405050933570.18190@wombat.indigo.net.au>
References: <16535.53709.132008.904350@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16535.53709.132008.904350@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Tue, 4 May 2004, Jeff Moyer wrote:

> Hi Ian, list,
> 
> If you happen to find your systems unable to communicate with the yp
> server, the subprocess launched to automount a share will receive a
> SIGSEGV, because we only check for err == YPERR_KEY in the lookup_yp
> module.  We get a different error, of course, and then go on to do a
> cache_update with NULL values.  Here is a patch which addresses this
> issue.  Comments more than welcome.  Oh, and I took the liberty of doing
> minor reformatting; I hope you don't mind, Ian.
> 

Cool. Looks good to me.

Ian
