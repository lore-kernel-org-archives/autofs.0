From: Chris Feist <cfeist@redhat.com>
Subject: [PATCH] small patch for documenting weighted maps
Date: Mon, 24 Jan 2005 15:48:23 -0600
Message-ID: <41F56D27.1080005@redhat.com>
Reply-To: cfeist@redhat.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010901020209000309090800"
Return-path: <autofs-bounces@linux.kernel.org>
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--------------010901020209000309090800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

In the linux automounter if you have something like this in a map file:

/test  hosta(10):/export localhost(20):/export hostb(30):/export

the automounter will ignore the weighting and always pick the localhost. 
The Sun automounter also behaves in this way.  The patch I'm submitted 
just clarifies the documentation so the user is not surprised when it 
happens.

Thanks,
Chris

--------------010901020209000309090800
Content-Type: text/x-patch;
 name="autofs-4.1.3-replicated-server-doc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="autofs-4.1.3-replicated-server-doc.patch"

--- autofs-4.1.3/README.replicated-server.orig	2005-01-24 15:26:28.609436878 -0600
+++ autofs-4.1.3/README.replicated-server	2005-01-24 15:27:57.592082878 -0600
@@ -27,7 +27,10 @@ Mutliple weighted, replicated hosts same
 Will pick lowest weighted host that responds to RPC call.  
 RPC time is not counted, only whether the call got a reply 
 at all.  Initially does a .1 second timeout, if all hosts 
-fail this, moves to 10 second timeout.
+fail this, moves to 10 second timeout.  If one of the hosts
+is localhost, the automounter will choose that regardless of
+its weight.  (This has been done to remain compatible with
+Sun's automounter)
 
 Multiple weighted, replicated hosts different (potentially) 
 paths:

--------------010901020209000309090800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------010901020209000309090800--

