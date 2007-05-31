From: Ian Kent <raven@themaw.net>
Subject: Re: Program maps in Autofs version 5.
Date: Thu, 31 May 2007 16:10:29 +0800
Message-ID: <1180599029.3563.6.camel@raven.themaw.net>
References: <Pine.GSO.4.64L.0705301742100.6143@home-on-the-dome.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.GSO.4.64L.0705301742100.6143@home-on-the-dome.mit.edu>
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
To: Omri Schwarz <ocschwar@MIT.EDU>
Cc: autofs@linux.kernel.org

On Wed, 2007-05-30 at 17:49 -0400, Omri Schwarz wrote:
> Hi, all. I am trying to test program maps for a legacy-ridden environment,
> and am going step by step through this article from Developer Works:
> 
> http://www.ibm.com/developerworks/aix/library/au-namespace/index.html
> 
> It fails immediately because as this program map shows,
> $PWD is not set. auto.master says:
> 
> /TEST	/etc/auto.prog
> 
> auto.prog says:
> #!/bin/bash
> echo $1 | logger -t autofs-test
> echo $PWD |logger -t autofs-test
> printenv | logger -t autofs-test
> 
> $PWD turns out to be /, and nothing in the environment
> of the automounter mentions /TEST.

No, there's not.
But the patch below should fix it.

> 
> So, is there a way to do this?
> (I am using FC 6 with the autofs provided by the RPM)

It would be good if you'd log a bug for this.

Ian

---
--- autofs-5.0.1/modules/lookup_program.c.set-pwd-on-exec	2007-05-31 16:03:52.000000000 +0800
+++ autofs-5.0.1/modules/lookup_program.c	2007-05-31 16:05:26.000000000 +0800
@@ -202,6 +202,10 @@ int lookup_mount(struct autofs_point *ap
 		dup2(epipefd[1], STDERR_FILENO);
 		close(pipefd[1]);
 		close(epipefd[1]);
+		if (chdir(ap->path))
+			warn(ap->logopt,
+			     MODPREFIX "couldn't set PWD for map %s",
+			     ap->path, ctxt->mapname);
 		execl(ctxt->mapname, ctxt->mapname, name, NULL);
 		_exit(255);	/* execl() failed */
 	}
