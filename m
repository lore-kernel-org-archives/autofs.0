From: "Prakash Velayutham" <Prakash.Velayutham@cchmc.org>
Subject: Re: autofs-4.1.3 not working properly
Date: Sat, 26 Nov 2005 10:20:52 -0500
Message-ID: <s388370e.055@n6mcgw16.cchmc.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org
Cc: raven@themaw.net

>>> Ian Kent <raven@themaw.net> 11/25/05 1:47 PM >>>
On Thu, 24 Nov 2005, Prakash Velayutham wrote:

> Hi,
> 
> I am new to this list, so please forgive my ignorances.
> I had a SuSE Pro 9.0 system running autofs (v3) running earlier. The 
> autofs itself did not have any issues at all until I decided to
upgrade 
> the system to SuSE 9.3. It was a clean install, and autofs4-4.1.3
became 
> the default kernel autofs module. My autofs master map comes from a 
> OpenLDAP server and it contains 3 different mount maps.
> /users (LDAP map)
> /protein/users (LDAP map)
> /import/users (LDAP map)
> I also have a file-based map in this server (/export/users).
> 
> Recently I was trying to move a user's home dir from server1 to
server2. 
> After moving his home dir and making the relevant changes to his LDAP 
> entry (homeDirectory attribute), I tried to restart autofs in the 
> above-mentioned server. The server already had several users logged in

> under /protein/users. Though the restart did not complain, I noticed 
> that autofs status showed "Configured mount points" correctly and 
> removed the currently mounted mount points from "Active mount points".

> Is there a reason why? Also strangely the ownerships of the previously

> mounted dirs had been changed to root:root.

I'm not sure what is not working or what has been broken.
What is the actual problem and symptom?

Ian

Thanks Ian for a reply. What if I restart autofs when a user whose home
dir is mounted through autofs is already logged into the system (and
hence at least one of the automount entries is being used)? What will
the system do in that case?

And also if I change the ldap attribute "homeDirectory" for a user, do I
have to restart autofs in a system for that change to be seen. Because I
sometimes see that the system has cached the user's attributes from LDAP
and tries to use that and fails.

Prakash
