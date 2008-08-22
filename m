From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Autofs 4->5 with LDAP problems
Date: Fri, 22 Aug 2008 12:01:43 -0400
Message-ID: <x49k5e93uoo.fsf@segfault.boston.devel.redhat.com>
References: <20080822150940.GA13963@dongle.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080822150940.GA13963@dongle.org.uk> (Rob Horton's message of
	"Fri, 22 Aug 2008 16:09:41 +0100")
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
To: Rob Horton <robh@dongle.org.uk>
Cc: autofs@linux.kernel.org

Rob Horton <robh@dongle.org.uk> writes:

> Hi,
>
> I'm having problems getting autofs5 to work with LDAP. We have a setup
> which works fine with autofs4 clients. Initially automount was
> complaining that it could not find the auto.master information, but
> after fiddling with the DEFAULT_MAP_OBJECT_CLASS etc entries it starts
> without error but doesn't appear to actually do anything (and there is
> no automount process). Despite turning on debugging and giving the -v
> and -d options I can't get any useful logging to find out what the
> problem is. Here's a sample of the LDAP objects:
>
> # auto.master, maths.qmul.ac.uk
> dn: ou=auto.master,dc=maths,dc=qmul,dc=ac,dc=uk
> ou: auto.master
> objectClass: top
> objectClass: automountMap
>
> # /misc, auto.master, maths.qmul.ac.uk
> dn: cn=/misc,ou=auto.master,dc=maths,dc=qmul,dc=ac,dc=uk
> objectClass: automount
> automountInformation: ldap:ou=auto.misc,dc=maths,dc=qmul,dc=ac,dc=uk
> -browse
> cn: /misc
>
> # orac_raid0, auto.misc, maths.qmul.ac.uk
> dn: cn=orac_raid0,ou=auto.misc,dc=maths,dc=qmul,dc=ac,dc=uk
> objectClass: automount
> cn: orac_raid0
> automountInformation:
> -rw,hard,rsize=32768,wsize=32768,tcp,lock,intr,quota    
>     orac:/orac/raid0
>
>
> /etc/sysconfig/autofs:
>
> DEFAULT_MAP_OBJECT_CLASS="automountMap"
> DEFAULT_ENTRY_OBJECT_CLASS="automount"
> DEFAULT_MAP_ATTRIBUTE="ou"
> DEFAULT_ENTRY_ATTRIBUTE="automountInformation"
> DEFAULT_VALUE_ATTRIBUTE="automountInformation"
> OPTIONS="--debug"
>
> We're running autofs-5.0.1 from Scientific Linux (RHEL clone) 5.1. I'd
> be grateful if anyone can spot a problem with the setup, or at least
> suggest how to get some more verbose output.

http://people.redhat.com/jmoyer contains instructions for gathering
debug logs.  Please provide them here when you have them.  Please also
give the *exact* version of autofs you are running.  rpm -q autofs
should do the trick.  automount -V would also be useful, given we don't
know how your distribution builds it.

Cheers,

Jeff
