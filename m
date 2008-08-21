From: Jeff Blaine <jblaine@kickflop.net>
Subject: Re: LDAP-based "auto.net" for /net
Date: Thu, 21 Aug 2008 09:44:21 -0400
Message-ID: <48AD7135.9080406@kickflop.net>
References: <39967.129.83.31.3.1219317751.squirrel@webmail.kickflop.net>
	<x493akyjxr4.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x493akyjxr4.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

Jeff Moyer wrote:
> jblaine@kickflop.net writes:
> 
>> If anyone has been successful in getting /net/hostname
>> automounting working with LDAP-based autofs maps (not
>> a local /etc/auto.net file), I would love to see your
>> LDIF information showing how you configured it.
> 
> First, program maps must be on a file system.  Second, are you using
> autofs version 4 or 5?  

AutoFS 5.

 > If 5, then you can simply use the ldif equivalent of:
 > /net       -hosts

That's what I am trying to do :)  I was hoping someone could
show me theirs.  It's not clear to me how to construct that
particular set of LDIF info.
