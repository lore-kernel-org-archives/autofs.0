From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] fix backwards #ifndef INET6
Date: Fri, 04 Sep 2009 12:24:11 -0400
Message-ID: <x491vmmwudw.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: ikent@redhat.com
Cc: autofs@linux.kernel.org

Hi, Ian,

Looks like a wire got crossed here.

Cheers,
Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/modules/replicated.c b/modules/replicated.c
index a66de9f..7ea86d7 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -231,7 +231,7 @@ static unsigned int get_proximity(struct sockaddr *host_addr)
 			break;
 
 		case AF_INET6:
-#ifndef INET6
+#ifdef INET6
 			if (host_addr->sa_family == AF_INET)
 				break;
