From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Fix, to fix the ordering of +ypmapname entries
	in /etc/auto.master
Date: Fri, 22 Oct 2004 13:37:28 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0410221336410.7438@wombat.indigo.net.au>
References: <1098400501.3014.50.camel@gold.msp.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1098400501.3014.50.camel@gold.msp.redhat.com>
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

On Thu, 21 Oct 2004, Chris Feist wrote:

> Ian,
> 
> This patch will have automount process map entries that refer to yp maps
> (ie. +auto_master) in the same order as they show up in the
> /etc/auto.master file.  Previously all entries that didn't refer to
> another yp map were processed before entries refering to a yp map.
> 
> For example with the following /etc/auto.master:
> /home /etc/auto.home
> +auto_master
> /misc /etc/auto.misc
> 
> In 4.1.3, all maps in auto_master would be included after the /home &
> /misc line.
> 
> With this patch all lines in the auto_master file will be processed
> after the /home line, but before the /misc line.
> 

Seems I'll need a reply template for you Chris.

Thanks as usual.

Ian
