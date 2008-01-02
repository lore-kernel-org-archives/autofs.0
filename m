From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: basic SOHO NFS/autofs setup for noob help
Date: Wed, 02 Jan 2008 14:22:56 -0500
Message-ID: <x49hchw117z.fsf@segfault.boston.devel.redhat.com>
References: <9b72f9a90801021042m65d350ak5467b4c500d94933@mail.gmail.com>
	<x49lk7812d7.fsf@segfault.boston.devel.redhat.com>
	<9b72f9a90801021110k3b3d74e7kb227b1e5bb772544@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <9b72f9a90801021110k3b3d74e7kb227b1e5bb772544@mail.gmail.com>
	(Jerzy Jalocha N.'s message of "Wed\,
	2 Jan 2008 13\:10\:16 -0600")
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
To: Jerzy Jalocha N <jjalocha@gmail.com>
Cc: autofs@linux.kernel.org

"Jerzy Jalocha N" <jjalocha@gmail.com> writes:

>> Try:
>>
>> auto.master:
>> /shared /etc/auto.shared
>>
>> /etc/auto.shared:
>> *       -hard,intr      192.168.1.20:/shared/&
>
> Thanks, Jeff, but sorry, that doesn't work. It's one of the first
> settings I had. Tried it again now, but without success. 'ls' just
> shows nothing, even with 'cd /shared'.
>
> Any other ideas?

Of course it shows nothing.  What directories exist under /shared on
the server?  Try to cd to one of those.

If you want the directory names to appear in a listing of /shared,
then you would have to have a separate key in the auto.shared map for
each of the directories (instead of using the wildcard key).

-Jeff
