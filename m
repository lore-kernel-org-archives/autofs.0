From: Todd Denniston <Todd.Denniston@ssa.crane.navy.mil>
Subject: Re: Has replicated mount failover  been implemented?
Date: Thu, 11 Oct 2007 17:39:43 -0500
Message-ID: <470EA62F.2050007@ssa.crane.navy.mil>
References: <145207.13740.qm@web81811.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <145207.13740.qm@web81811.mail.mud.yahoo.com>
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
To: John Simon <tzzhc4@yahoo.com>
Cc: autofs@linux.kernel.org

John Simon wrote, On 10/11/2007 01:50 PM:
> Since client-side failover is not currently possible
> with Linux autofs does anyone have any recommendations
> for minimizing server side impact during when a HA-NFS
> server fails over. Right now what happens with HA-NFS
> is all the clients retry so much they basically end up
> DOS'ing the NFS server and causing it to failover
> again and again. We have hundreds of clients.
> 
> 

Do you mean an HA Linux[1] server?

You might try running nslookup|dig in a for loop that has all of your client 
machines listed, if that for loop takes very long (greater than 30-60 seconds 
to lookup every client in your domain) then you may want to maintain a full 
/etc/hosts table on the server.  When I had some problems with name service 
taking a while to respond[3] HA would give up on nfs getting started and fall 
back to the other machine (repeatedly), and that was when all the client 
machines were shutdown.
Unfortunately, you will need to maintain this hosts table so I would suggest, 
that like me, you write a script to build looked up information and let you 
know when that differs from the current /etc/hosts file.

Assuming that the failover again and again is caused by HA getting impatient 
with 'service nfs start', you might ask on the HA list[2] if there is a 
timeout value you could increase to give it a better chance of coming up in 
your environment (been a _long_ time since I messed with HA's timeouts and 
that was for ver 1.2.X).


Jeff's timeo nfs mount option might help too.


[1] http://www.linux-ha.org/
	which IIRC works on solaris too.

[2] http://lists.linux-ha.org/mailman/listinfo/linux-ha

[3] it WAS very sick DNS hardware.

> 
> --- John Simon <tzzhc4@yahoo.com> wrote:
> 
>> We are in the process of switching from Sun blades
>> to
>> Linux blades for our compute farm and are running
>> into
>> issues with automount not failing over when an NFS
>> server goes down. I am wondering if it is a
>> configuration issue, if I am using a version of
>> autofs
>> that doesn't support failover or if it hasn't been
>> implemented yet.
> 
> 
> 


-- 
Todd Denniston
Crane Division, Naval Surface Warfare Center (NSWC Crane)
Harnessing the Power of Technology for the Warfighter
