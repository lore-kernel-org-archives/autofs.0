From: Jeff Moyer <jmoyer@redhat.com>
Subject: [RFC] rpc_ping and looong timeouts
Date: Thu, 3 Jun 2004 16:30:26 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16575.35426.918728.134817@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hello, Ian, list,

You may recall my asking for the rpc_ping function to take TCP only servers
into account.  Well, be careful what you ask for!  Now, if a server is down
in a replicated server configuration, it takes quite a while to timeout
due to the TCP connect.  The mount will eventually succeed, but I've seen
this take up to 10 minutes.

Perhaps we should first test to see if a host is reachable at all before we
begin our rpc pings?

Comments?

Jeff
