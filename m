From: Michael Blandford <michael@kmaclub.com>
Subject: Re: Problem with autofs 3.1.7 -> 4.1.0-beta2
Date: Sat, 06 Dec 2003 23:43:46 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FD2CC22.6050401@kmaclub.com>
References: <Pine.LNX.4.44.0312071347540.2974-100000@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0312071347540.2974-100000@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


>This looks like a NIS map. Shouldn't the / be a * in this case and 
>shouldn't the wildcard map entry come last. I thouht that the defined 
>behaviour of the wildcard map entry was that once it is encountered map 
>processing stops.
>
>  
>
Yes, I didnt know how to represent what was in ldap very well so I made 
it look like it did in NIS.

If there is a good way to do an ldapsearch to show the exact config, 
please show me the syntax and I would be happy to report that back.

According to the automount man page, the wildcard for ldap is a / so 
that is what I was using.  What I thought was odd was it was always 
choosing the same thing and it *wasn't* the wildcard.

I didnt think there was ordering per say in the nis or ldap maps.

If my config is wrong, or if I cant do wildcards in this way, that is 
fine.  I just know it works differently between 3.1.7 and 4.1.0.

Michael
