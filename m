From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: rpc_ping always uses UDP
Date: Thu, 13 May 2004 08:45:18 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16547.28126.916381.460256@segfault.boston.redhat.com>
References: <16546.29772.254542.152548@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0405132039530.13693@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405132039530.13693@donald.themaw.net>
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] rpc_ping always uses UDP; raven@themaw.net adds:

raven> On Wed, 12 May 2004, Jeff Moyer wrote:
>> Hello Ian, list,
>> 
>> I had a user report an issue which is summed up in the subject.
>> Basically, he disallowed UDP traffic to his NFS server.  Because the
>> autofs code uses UDP in the rpc_ping function to determine if a server
>> is alive, it would conclude that the server was not alive.  He was, of
>> course, using NFSv4 over TCP.

>> So, thoughts?  Comments?

raven> Oh and another thing.

raven> The rpc ping should only occur if replicated server mount syntax is
raven> being used. If this is not the case it's also a bug.

raven> Is he using the latest replicated server patch?

Not at the time of the bug report.  I'll ask him to try the latest stuff.

Thanks,

Jeff
