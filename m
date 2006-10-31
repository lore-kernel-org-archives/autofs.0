From: Peter Staubach <staubach@redhat.com>
Subject: Re: autofs Digest, Vol 43, Issue 12
Date: Tue, 31 Oct 2006 13:14:37 -0500
Message-ID: <4547928D.3070007@redhat.com>
References: <mailman.1.1162296001.31020.autofs@linux.kernel.org>
	<45478B5A.7000106@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45478B5A.7000106@cypress.com>
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
To: Risto Bell <reb@cypress.com>
Cc: autofs@linux.kernel.org

Risto Bell wrote:
>  > My system defaults to tcp nfs v3 if no options are specified.
>
> How does one achieve/config that (Solaris like) in autofs4?
> Likewise achieving the NETAPP recommended TCP options timeo=600,retrans=2
>
> If you have mix of servers, some only supporting UDP, but wish
> to prefer TCPv3 whereever it's available and UDP only if no choice...
>
> I use scripts programs (like auto.net), that do rpcinfo
> to test if the server supports TCP and add the options. But even
> emulating NIS look-ups, overall result (scripts) are considerably
> slower.

Perhaps I am missing something, but the default NFS Version 3 over TCP.
If that is not available, then the client falls back to NFS Version 3
over UDP, NFS Version 2 over TCP, and then NFS Version 2 over UDP,
in that order.

As far as I can tell, it should not be necessary to specify any mount
options controlling the NFS protocol version or transport choice, unless
you specifically want it to be a single combination and not allow it to
fall back.

All that extra support is just overhead if the mount command is already
doing the right thing.

    Thanx...

       ps
