From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] No-rmdir-patch
Date: Tue, 25 Jan 2005 09:01:12 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0501250854000.21644@wombat.indigo.net.au>
References: <41F531F3.2040509@redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <41F531F3.2040509@redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Feist <cfeist@redhat.com>
Cc: autofs@linux.kernel.org


Looks OK.

I'll merge it into 4.1.4 brta1.

It wuould be good if you could make your changes against a current CVS 
snapshot as there have been a lot of changes from 4.1.3.

Jeff has the CVS info.

Ian

On Mon, 24 Jan 2005, Chris Feist wrote:

> When you specify a directory where a map will be mounted in auto.master, 
> if it does not exist, autofs will create it upon startup and remove the 
> directory when it shuts down.  However, if the directory already exists, 
> autofs will still remove it when you shut down.  I've attached a patch 
> to autofs-4.1.3 which will prevent autofs from removing previously 
> exisiting directories.
> 
> If you have any questions, let me know!
> 
> Thanks,
> Chris
> 
> 
> 
> 
