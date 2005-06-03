From: "Peter C. Norton" <spacey-autofs@lenin.net>
Subject: Autofs and NIS+ bug
Date: Fri, 3 Jun 2005 07:14:51 -0700
Message-ID: <20050603141451.GJ18045@lenin.net>
Mime-Version: 1.0
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
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Greetings list,

I've been working on an issue with the lookup_nisplus.c that runs
headfirst into a bug in the linux glibc's NIS+ code.

First, let me start by saying that I know that NIS+ is a dinosaur, but
I'm stuck supporting it, so by using some code from the linux nis+
tools, I've found a way to fix the issue by using this code and
patching lookup_nisplus.c.

Background:

NIS+ is an update to the venerable NIS. Sun created it as a system
that would allow for heirarchical domains. Whereas NIS/YP required a
flat single domain, and one domain couldn't speak to another, NIS+ has
heirarchy and visibility between domains that are in the same
heirarchy. This visibility extends to two features that allow a table
in one directory to actually either include data that exists in
another table (even one in another domain). These are called search
paths. The second mechanism is called a link, and like a symbolic link
on a filesystem, it points a table in one directory to another table
in its entirety (paths include another table, links do not allow the
mixture of local and remote data).

The Problem:

The normal, easy way, to perform a lookup using NIS+ involves a few
simple calls:

calling nis_lookup() with the argument of a string table_name, and a
list of options which can specify performing resolution of the domain,
following links, following paths, and other behaviours.

Then, using the table name returned by nis_lookup (from which the
linked-to table name can also be gotten) you pass a string that is the
lookup to the call nis_list(table_name, flags, callback(), [separator]).

The result from the nis_list should be useable, via the callback, as
an argument to the nis_print_object() call. When the looking being
performed is not an indexed lookup (a lookup that does not have the
equivelant of a SQL "WHERE" clauses) this works. When the looking is
an indexed lookup, the call fails by causing a segfault somewhere deep
in the c library. Trying to debug this has led me to having
nonsensical debugging info - I assume due to optimization on my test
platform (Red Hat Enterprise Linux 3).

In trying to unwind this, I used the results of the nis_lookup to get
the name of the actual table being referred to, and tried to call
nis_list on the table directly, but the indexed lookup crashed yet
again.

Resolution:

After butting my head against this, I used code from the linux NIS+
tools, which instead of using the nis_print* functions seems to access
the individual elements of the returned array, and prints them itself.

Doing this from within a callback has caused a tiny bit of ugliness in
the code, but I can confirm that where before I had businesses that
could not use the automounter in some parts of their NIS+ environment,
now they can.

So, I'd like to know if I can submit this code for the review of the
list to be included. I am doing this with two goals in mind: 1) if
there is anyone else out there who is in the same unfortunate support
situation as my company (a very large one that is trying to move away
from NIS+, but it is slooooooow going) I'd like to save them the
effort. 2) I'd like to encourage my linux vendor (Red Hat) to get this
included in their internal package by making it a mainstream part of
the automounter until NIS+ finally gets a bullet in the head. I know
Jeff has done a lot of good work here and is agressively fixing autofs
in RHEL and Fedora, but from the management end this sort of task can
be difficult.

So let me know if in principle this kind of patch could be reviewed,
and I'll pass it along, with a minimal description of how to reproduce
a test case... if anyone is interested.

Thanks,

-Peter

-- 
The 5 year plan:
In five years we'll make up another plan.
Or just re-use this one.
