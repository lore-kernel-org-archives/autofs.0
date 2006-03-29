From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Autofs wrongly tries to use NFS for a program map
Date: Wed, 29 Mar 2006 14:38:11 -0500
Message-ID: <x49hd5havoc.fsf@segfault.boston.redhat.com>
References: <442ACE3C.5020600@alma.ch>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <442ACE3C.5020600@alma.ch> (Mi's message of "Wed, 29 Mar 2006
	20:13:16 +0200")
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
Content-Transfer-Encoding: 7bit
To: Mi <mi.lists@alma.ch>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] Autofs wrongly tries to use NFS for a program map; Mi <mi.lists@alma.ch> adds:

mi> Hello, I'm trying to use a program map for external Firewire drives,
mi> but autofs seems to think it's supposed to be a NFS map, and fails.

mi> I simplified things to a minimum to show the problem.  /etc/auto.test1
mi> is a normal map which works.  /etc/auto.test2 is a program map which
mi> outputs the exact same content as is in auto.test1, yet it fails:

mi>     # grep test /etc/auto.master /test1 /etc/auto.test1 --timeout=60
mi> /test2 /etc/auto.test2 --timeout=60

mi>     # cat /etc/auto.test1 sdb7 -fstype=ext3 :/dev/sdb7

mi>     # cat /etc/auto.test2
mi>     #!/bin/bash echo "sdb7 -fstype=ext3 :/dev/sdb7"

Program maps need not print the "key".  Since the automount daemon already
knows what key it is looking up, this would be redundant information.
Simply get rid of the "sdb7" from the beginning of your echo line and
things should work

-Jeff
