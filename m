From: Bryce as root <root@www.linux.org.uk>
Subject: Re: Re: [patch] fix a file descriptor leak in rpc_subs.c
Date: Tue, 7 Sep 2004 11:56:41 +0100 (BST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1C4deT-0004s0-5J@www.linux.org.uk>
References: <Pine.LNX.4.58.0409062142310.13402@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409062142310.13402@donald.themaw.net> from
	"raven@themaw.net" at Sep 06, 2004 09:50:09 PM
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

> 
> On Mon, 23 Aug 2004, Jeff Moyer wrote:
> 
> > Hi Ian, list,
> > 
> > We never close the file descriptors we open in the rpc ping path.  Here is
> > a patch which addresses this.  The patch appears in my latest rpms on my
> > people page.
> 
> While I was looking at the problem Bryce reported I got the impression 
> that the socket leak patch may not have completely covered the closeing of 
> open sockets. I'm probably wrong but I came up with this alternative patch 
> which I've called autofs-4.1.3-sock-leak-fix-2.patch.
> 
> Any thoughts?
> 
> --- autofs-4.1.3/lib/rpc_subs.c.sock-leak-fix-2	2004-09-06 19:26:30.000000000 +0800
> +++ autofs-4.1.3/lib/rpc_subs.c	2004-09-06 19:41:19.000000000 +0800
> @@ -48,7 +48,7 @@
>   */
>  static CLIENT* create_udp_client(struct conn_info *info)
>  {
> -	int fd = -1;
> +	int fd = RPC_ANYSOCK;
>  	CLIENT *client;
>  	struct sockaddr_in addr;
>  	struct hostent *hp;
> @@ -179,6 +179,12 @@
>  	if (!client)
>  		goto out_close;
>  
> +	/* Close socket fd on destroy, as is default for rpcowned fds */
> +	if  (!clnt_control(client, CLSET_FD_CLOSE, NULL)) {
> +		clnt_destroy(client);
> +		goto out_close;
> +	}
> +
>  	return client;
>  
>  out_close:


Applied and tried.. (and failed. Same messages about "nfs bindresvport:
Address already in use" in the log file)
One thing of note from an earlier email is that quite a few sockets are left
around from just one mount

[root@localhost test]# netstat --inet
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 192.168.1.40:ssh        192.168.1.100:32985     ESTABLISHED 
[root@localhost test]# ls 1
1
[root@localhost test]# netstat --inet
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 192.168.1.40:855        192.168.1.100:sunrpc    TIME_WAIT   
tcp        0      0 192.168.1.40:858        192.168.1.100:sunrpc    TIME_WAIT   
tcp        0      0 192.168.1.40:800        192.168.1.100:nfs       ESTABLISHED 
tcp        0      0 192.168.1.40:ssh        192.168.1.100:32985     ESTABLISHED 
tcp        0      0 192.168.1.40:856        192.168.1.100:1013      TIME_WAIT 

so when it comes around to doing an ls * on my setup
[root@localhost test]# netstat --inet | wc -l
   2011
Thats an awful lot of sockets for a meer 200+ mount points
Admittidly the vast majority are in TIME_WAIT states

Unfortunately I can't help beyond just observing results as my knowledge
of RPC extends to just being able to spell it 8/

Phil
=--=
