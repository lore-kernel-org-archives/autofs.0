From: Ian Kent <raven@themaw.net>
Subject: Re: Problem with autofs 3.1.7 -> 4.1.0-beta2
Date: Sun, 7 Dec 2003 20:29:07 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0312072016350.3078-100000@raven.themaw.net>
References: <3FD2CC22.6050401@kmaclub.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FD2CC22.6050401@kmaclub.com>
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
To: Michael Blandford <michael@kmaclub.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Sat, 6 Dec 2003, Michael Blandford wrote:

> 
> If there is a good way to do an ldapsearch to show the exact config, 
> please show me the syntax and I would be happy to report that back.

Which schema are you using the nisMap or automountMap.

I'll need an ldif example in order to duplicate the problem.

You should be able to do an ldapsearch -x and get the entire database. As 
long as your /etc/openldap/ldap.conf specifies the BASE and HOST entries.

> 
> According to the automount man page, the wildcard for ldap is a / so 
> that is what I was using.  What I thought was odd was it was always 
> choosing the same thing and it *wasn't* the wildcard.

Think the code is incorrect.

> 
> I didnt think there was ordering per say in the nis or ldap maps.

Yep. As Peter says my understanding is not right.

> 
> If my config is wrong, or if I cant do wildcards in this way, that is 
> fine.  I just know it works differently between 3.1.7 and 4.1.0.

That's no good.

Wherever possible and relevant v3 and v4 should provide the same behavior 
for any given configuration.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
