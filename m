From: Ian Kent <raven@themaw.net>
Subject: Re: Re[4]: autofs reload
Date: Mon, 29 Mar 2004 18:56:19 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403291854490.29659@raven.themaw.net>
References: <16484.25454.659035.551208@segfault.boston.redhat.com>
 <E1B6v3m-0000cJ-00.ia6432-inbox-ru@f25.mail.ru>
 <16484.27293.279258.40887@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16484.27293.279258.40887@segfault.boston.redhat.com>
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

On Fri, 26 Mar 2004, Jeff Moyer wrote:

> 
> It may even be beneficial to change autofs reload to send a HUP to all
> automount daemons.  Ian, what do you think?
> 

Adding this patch after the previous one should deal with the HUP signal.

diff -Nur autofs-4.1.1.status/samples/rc.autofs.in autofs-4.1.1/samples/rc.autofs.in
--- autofs-4.1.1.status/samples/rc.autofs.in	2004-03-29 17:28:27.000000000 +0800
+++ autofs-4.1.1/samples/rc.autofs.in	2004-03-29 17:28:43.000000000 +0800
@@ -403,6 +403,9 @@
 			kill -USR2 $pid 2> /dev/null
 			echo $"Stop $command"
 		    fi
+		else
+			kill -HUP $pid 2> /dev/null
+			echo $"Reload map $command"
 		fi
 	    done
 	)
@@ -464,6 +467,9 @@
 		then
 			echo "Stopping automounter: $command"
 			kill -USR2 $pid 2> /dev/null
+		else
+			echo "Reloading automounter map: $command"
+			kill -HUP $pid 2> /dev/null
 		fi
 	done
 	rm -f $TMP
