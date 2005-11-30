From: Ian Kent <raven@themaw.net>
Subject: Re: autofs-4.1.3 not working properly
Date: Wed, 30 Nov 2005 23:12:21 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511302302210.2069@donald.themaw.net>
References: <s38caaf0.054@n6mcgw16.cchmc.org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <s38caaf0.054@n6mcgw16.cchmc.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Prakash Velayutham <Prakash.Velayutham@cchmc.org>
Cc: autofs@linux.kernel.org

On Tue, 29 Nov 2005, Prakash Velayutham wrote:

> But what happens in the following scenario.
> 
> In client C, users user1 and user2 are both logged in and their home
> dirs are /server1/users/user1 and /server1/users/user2.
> 
> Now I want to move user1 to a different server server2. His home will be
> changed to /server2/users/user1. I can unmount /server1/users/user1, but
> cannot unmount /server1/users/user2. Now if user1 tries to login, would
> autofs automatically mount /server2/users/user1 for him or keep
> complaining about /server1/users/user1 not available (as the home dir
> has already been moved to server2 and not available in server1 any
> more)?

There's not much you can do about user2, at least till the mount is not 
busy and is umounted. This change should be seen next time the mount is 
accessed.

The server2 mount for user1 should be seen on next access provided 
LDAP has been updated. At least that's what 4.1.4 should do.

If it doesn't I've got an error in the LDAP lookup module.

If in doubt send a HUP signal to the daemon to force a re-read of the map.

Ian
