From: raven@themaw.net
Subject: [PATCH] autofs-4.1.3 - replicated server selection logic bug
Date: Sun, 24 Oct 2004 21:02:51 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0410242052390.16257@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs mailing list <autofs@linux.kernel.org>
Cc: Chris Feist <cfeist@redhat.com>


Hi all,

Working with Jeremy we discovered a logic error in the server selection 
code when choosing from a list of replicated servers.

The patch has been copied to kernel.org in the usual place and I've called 
it autofs-4.1.3-replicated_server_select.patch.

Ian
