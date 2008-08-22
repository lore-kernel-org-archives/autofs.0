From: Rob Horton <robh@dongle.org.uk>
Subject: Re: Autofs 4->5 with LDAP problems
Date: Fri, 22 Aug 2008 20:59:50 +0100
Message-ID: <20080822195950.GA14334@dongle.org.uk>
References: <20080822150940.GA13963@dongle.org.uk>
	<x49k5e93uoo.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <x49k5e93uoo.fsf@segfault.boston.devel.redhat.com>
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
To: autofs@linux.kernel.org

On Fri, Aug 22, 2008 at 12:01:43PM -0400, Jeff Moyer wrote:
> Rob Horton <robh@dongle.org.uk> writes:
> 
> > Hi,
> >
> > I'm having problems getting autofs5 to work with LDAP. We have a setup
> > which works fine with autofs4 clients. Initially automount was
> > complaining that it could not find the auto.master information, but
> > after fiddling with the DEFAULT_MAP_OBJECT_CLASS etc entries it starts
> > without error but doesn't appear to actually do anything (and there is
> > no automount process). Despite turning on debugging and giving the -v
> > and -d options I can't get any useful logging to find out what the
> > problem is. Here's a sample of the LDAP objects:
> >
> > # auto.master, maths.qmul.ac.uk
> > dn: ou=auto.master,dc=maths,dc=qmul,dc=ac,dc=uk
> > ou: auto.master
> > objectClass: top
> > objectClass: automountMap
> >
> > # /misc, auto.master, maths.qmul.ac.uk
> > dn: cn=/misc,ou=auto.master,dc=maths,dc=qmul,dc=ac,dc=uk
> > objectClass: automount
> > automountInformation: ldap:ou=auto.misc,dc=maths,dc=qmul,dc=ac,dc=uk
> > -browse
> > cn: /misc
> >
> > # orac_raid0, auto.misc, maths.qmul.ac.uk
> > dn: cn=orac_raid0,ou=auto.misc,dc=maths,dc=qmul,dc=ac,dc=uk
> > objectClass: automount
> > cn: orac_raid0
> > automountInformation:
> > -rw,hard,rsize=32768,wsize=32768,tcp,lock,intr,quota    
> >     orac:/orac/raid0
> >
> >
> > /etc/sysconfig/autofs:
> >
> > DEFAULT_MAP_OBJECT_CLASS="automountMap"
> > DEFAULT_ENTRY_OBJECT_CLASS="automount"
> > DEFAULT_MAP_ATTRIBUTE="ou"
> > DEFAULT_ENTRY_ATTRIBUTE="automountInformation"
> > DEFAULT_VALUE_ATTRIBUTE="automountInformation"
> > OPTIONS="--debug"
> >
> > We're running autofs-5.0.1 from Scientific Linux (RHEL clone) 5.1. I'd
> > be grateful if anyone can spot a problem with the setup, or at least
> > suggest how to get some more verbose output.
> 
> http://people.redhat.com/jmoyer contains instructions for gathering
> debug logs.  Please provide them here when you have them.  Please also
> give the *exact* version of autofs you are running.  rpm -q autofs
> should do the trick.  automount -V would also be useful, given we don't
> know how your distribution builds it.
> 
> Cheers,
> 
> Jeff
> 

Thanks - here's the logs that are produced with the setup above:

Starting automounter version 5.0.1-0.rc2.55.el5.2, master map
auto.master
using kernel protocol version 5.00
lookup_nss_read_master: reading master ldap auto.master
parse_server_string: lookup(ldap): Attempting to parse LDAP information
from string 
"auto.master".
parse_server_string: lookup(ldap): mapname auto.master
parse_ldap_config: ldap authentication configured with the following
options: 
parse_ldap_config: use_tls: 0, tls_required: 0, auth_required: 1,
sasl_mech: (null) 
parse_ldap_config: user: (null), secret: unspecified, client principal:
(null) 
do_connect: auth_required: 1, sasl_mech (null)
do_connect: lookup(ldap): ldap anonymous bind returned 0
get_query_dn: lookup(ldap): query dn
ou=auto.master,dc=maths,dc=qmul,dc=ac,dc=uk
unbind_ldap_connection: use_tls: 0
parse_init: parse(sun): init gathered global options: (null)
mount_init: mount(bind): bind_works = 1
do_connect: auth_required: 1, sasl_mech (null)
do_connect: lookup(ldap): ldap anonymous bind returned 0
lookup_read_master: lookup(ldap): searching for
"(objectclass=automount)" under "ou=
auto.master,dc=maths,dc=qmul,dc=ac,dc=uk"
lookup_read_master: lookup(ldap): examining entries


...and that's it. Running the search at the bottom returns two objects.
What's odd is that if DEFAULT_ENTRY is set incorrectly it runs
as expected (it fails, but gets further):


Starting automounter version 5.0.1-0.rc2.55.el5.2, master map
auto.master
using kernel protocol version 5.00
lookup_nss_read_master: reading master ldap auto.master
parse_server_string: lookup(ldap): Attempting to parse LDAP information
from string "auto.master".
parse_server_string: lookup(ldap): mapname auto.master
parse_ldap_config: ldap authentication configured with the following
options: 
parse_ldap_config: use_tls: 0, tls_required: 0, auth_required: 1,
sasl_mech: (null) 
parse_ldap_config: user: (null), secret: unspecified, client principal:
(null) 
do_connect: auth_required: 1, sasl_mech (null)
do_connect: lookup(ldap): ldap anonymous bind returned 0
get_query_dn: lookup(ldap): query dn
ou=auto.master,dc=maths,dc=qmul,dc=ac,dc=uk
unbind_ldap_connection: use_tls: 0
parse_init: parse(sun): init gathered global options: (null)
mount_init: mount(bind): bind_works = 1
do_connect: auth_required: 1, sasl_mech (null)
do_connect: lookup(ldap): ldap anonymous bind returned 0
lookup_read_master: lookup(ldap): searching for
"(objectclass=automount)" under
"ou=auto.master,dc=maths,dc=qmul,dc=ac,dc=uk"
lookup_read_master: lookup(ldap): examining entries
unbind_ldap_connection: use_tls: 0
master_do_mount: mounting /home/network
lookup_nss_read_map: reading map ldap
ldap:ou=auto.home,dc=maths,dc=qmul,dc=ac,dc=uk
parse_server_string: lookup(ldap): Attempting to parse LDAP information
from string "ldap:ou=auto.home,dc=maths,dc=qmul,dc=ac,dc=uk".
parse_server_string: lookup(ldap): server "(default)", base dn
"ou=auto.home,dc=maths,dc=qmul,dc=ac,dc=uk"
parse_ldap_config: ldap authentication configured with the following
options: 
parse_ldap_config: use_tls: 0, tls_required: 0, auth_required: 1,
sasl_mech: (null) 
parse_ldap_config: user: (null), secret: unspecified, client principal:
(null) 
do_connect: auth_required: 1, sasl_mech (null)
do_connect: lookup(ldap): ldap anonymous bind returned 0
get_query_dn: lookup(ldap): query succeeded, no matches for
(objectclass=automountMap)
unbind_ldap_connection: use_tls: 0
lookup_init: lookup(ldap): failed to get query dn
do_read_map: lookup module ldap failed
mount_autofs_indirect: failed to read map for /home/network
handle_mounts: mount of /home/network failed!
master_do_mount: failed to startup mount
master_do_mount: mounting /misc
lookup_nss_read_map: reading map ldap
ldap:ou=auto.misc,dc=maths,dc=qmul,dc=ac,dc=uk
parse_server_string: lookup(ldap): Attempting to parse LDAP information
from string "ldap:ou=auto.misc,dc=maths,dc=qmul,dc=ac,dc=uk".
parse_server_string: lookup(ldap): server "(default)", base dn
"ou=auto.misc,dc=maths,dc=qmul,dc=ac,dc=uk"
parse_ldap_config: ldap authentication configured with the following
options: 
parse_ldap_config: use_tls: 0, tls_required: 0, auth_required: 1,
sasl_mech: (null) 
parse_ldap_config: user: (null), secret: unspecified, client principal:
(null) 
do_connect: auth_required: 1, sasl_mech (null)


# rpm -q autofs
autofs-5.0.1-0.rc2.55.el5.2.i386

# automount -V

Linux automount version 5.0.1-0.rc2.55.el5.2

Directories:
	config dir:	/etc/sysconfig
	maps dir:	/etc
	modules dir:	/usr/lib/autofs

Compile options:
  DISABLE_MOUNT_LOCKING
  ENABLE_IGNORE_BUSY_MOUNTS WITH_HESIOD
  WITH_LDAP 
  WITH_SASL 




Any thoughts?

Thanks,
Rob
