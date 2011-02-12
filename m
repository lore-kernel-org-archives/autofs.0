From: Steve Thompson <smt@vgersoft.com>
Subject: Re: Wrong network
Date: Sat, 12 Feb 2011 15:21:06 -0500 (EST)
Message-ID: <alpine.LRH.0.9999.1102121518420.12882@helios.vgersoft.com>
References: <alpine.LRH.0.9999.1102120924290.6851@helios.vgersoft.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LRH.0.9999.1102120924290.6851@helios.vgersoft.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

On Sat, 12 Feb 2011, Steve Thompson wrote:

> CentOS 5.5 (32- and 64-bit), autofs-5.0.1-0.rc2.143.el5_5.6.
>
> Two subnets, A (192.168.0/22) and B (192.168.4/22). NFS server has an 
> interface on both A and B. NFS client has an interface on B only. Maps come 
> via LDAP. On the client:
>
> 	# mount
> 	<server>:/mnt/point on /fs/<blah> type nfs (rw,addr=192.168.0.69)
>
> The addr= looks wrong to me; should be 192.168.4.x. On other clients, the 
> subnet pointed to by addr= is sometimes right, sometimes wrong. What's wrong 
> here?

Let me expand a little on this. A DNS lookup of the NFS server name 
returns two IP addresses, one in subnet A and one in subnet B. I was under 
the impression that autofs would see that the address on subnet B is in 
the same segment as the client, using PROXIMITY_SUBNET. It doesn't appear 
to be working the way I would expect.

Steve
