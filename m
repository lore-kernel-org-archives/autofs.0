From: raven@themaw.net
Subject: Re: rpc_ping always uses UDP
Date: Thu, 13 May 2004 20:27:06 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405132017250.1562@donald.themaw.net>
References: <16546.29772.254542.152548@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16546.29772.254542.152548@segfault.boston.redhat.com>
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

On Wed, 12 May 2004, Jeff Moyer wrote:

> Hello Ian, list,
> 
> I had a user report an issue which is summed up in the subject.  Basically,
> he disallowed UDP traffic to his NFS server.  Because the autofs code uses
> UDP in the rpc_ping function to determine if a server is alive, it would
> conclude that the server was not alive.  He was, of course, using NFSv4
> over TCP.

I was looking at this when I was working on the replicated server stuff 
the other day. I wondered how long it would be before this came up.

> 
> This is a bit of a corner case.  I'm not sure if this is a valid problem or
> not, and I'm sure it could be argued either way.  So, what does the list
> think?

This definitely needs fixing. At least a little. I'm not sure how far to 
go at this point in time so see below ...

> 
> To provide further information on the implementation implications, we would
> actually have to look at the filesystem options, which is something we
> don't really need to bother ourselves with, at the moment.  That part
> sounds a little ugly to me.

Don't think that is really needed. This process is very much a "are you 
there" and "do you do NFS". I don't think it's a big problem if it answers 
postive sometimes when it should be negative. This would be caught by 
mount anyway.

> 
> So, thoughts?  Comments?

This process must be simple if it's to be useful.

If it's possible, can you ask your client to try this test program in his 
environment please. If this method works OK I'll make a patch and merge it.

Perhaps we can add v4 at some later stage when we've had a chance to check 
it out.

#include <rpc/rpc.h>
#include <nfs/nfs.h>
#include <linux/nfs2.h>
#include <linux/nfs3.h>
#include <rpc/xdr.h>

int rpc_ping_proto(const char *host,
		   unsigned long nfs_version, const char *proto,
		   long seconds, long micros)
{
	CLIENT *client;
	struct timeval tout;
	enum clnt_stat stat;

	client = clnt_create(host, NFS_PROGRAM, nfs_version, proto);
	if (client == NULL) {
		return 0;
	}

	tout.tv_sec = seconds;
	tout.tv_usec = micros;

	clnt_control(client, CLSET_TIMEOUT, (char *)&tout);
	clnt_control(client, CLSET_RETRY_TIMEOUT, (char *)&tout);

	stat = clnt_call(client, NFSPROC_NULL,
			 (xdrproc_t)xdr_void, 0, (xdrproc_t)xdr_void, 0, tout);

	clnt_destroy(client);

	if (stat != RPC_SUCCESS) {
		return 0;
	}

	return 1;
}

int rpc_ping_v2(const char *host, long seconds, long micros)
{
	int status = 0;

	status = rpc_ping_proto(host, NFS2_VERSION, "udp", seconds, micros);
	if (status)
		return status;

	status = rpc_ping_proto(host, NFS2_VERSION, "tcp", seconds, micros);
	if (status)
		return status;

	return status;
}

int rpc_ping_v3(const char *host, long seconds, long micros)
{
	int status = 0;

	status = rpc_ping_proto(host, NFS3_VERSION, "udp", seconds, micros);
	if (status)
		return status;

	status = rpc_ping_proto(host, NFS3_VERSION, "tcp", seconds, micros);
	if (status)
		return status;

	return status;
}

int main(int argc, char **argv)
{
	int status;

	if (argc != 2) {
		printf("no host\n");
		exit(1);
	}

	status = rpc_ping_v2(argv[1], 5, 0);
	if (status)
		printf("detected NFS V2 on host %s\n", argv[1]);

	status = rpc_ping_v3(argv[1], 5, 0);
	if (status)
		printf("detected NFS V3 on host %s\n", argv[1]);

	exit(0);
}
