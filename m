From: Piete Brooks <Piete.Brooks@cl.cam.ac.uk>
Subject: Re: autofs5: unable to locate ldap master map
Date: Fri, 25 Aug 2006 10:03:46 +0100
Message-ID: <E1GGXbO-0000MZ-00@mta2.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
From: Piete.Brooks--autofs@cl.cam.ac.uk
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs mailing list <autofs@linux.kernel.org>

> Do you really have an use to be able to define your ldap connection
> settings in a file named differently from "autofs_ldap_auth.conf" ?

Sorry -- misunderstood :-((

>> PS: LDAP failed for me too until I edited /etc/sysconfig/autofs to use the 
>> correct schema -- now it works fine!
> Even without configuring the top dn explicitely ?

I believe that to be the case.
I have been HACKing away to get it working, but I don't think I set it 
anywhere.
The change to the schema in /etc/sysconfig/autofs ws the bit which made it 
work, and that has no full name:

DEFAULT_MAP_OBJECT_CLASS="automountMap"
DEFAULT_ENTRY_OBJECT_CLASS="automount"
DEFAULT_MAP_ATTRIBUTE="ou"
DEFAULT_ENTRY_ATTRIBUTE="cn"
DEFAULT_VALUE_ATTRIBUTE="automountInformation"

Comparing the failing and working entries I have:

Aug 25 06:36:04 pbtest8 automount[32611]: do_connect: lookup(ldap): ldap 
anonymous bind returned 0
Aug 25 06:36:04 pbtest8 automount[32611]: get_query_dn: lookup(ldap): query 
succeeded, no matches for (&(objectclass=nisMap)(nisMapName=auto.master))
Aug 25 06:36:04 pbtest8 automount[32611]: unbind_ldap_connection: use_tls: 0

vs

Aug 25 06:51:23 pbtest8 automount[32657]: do_connect: lookup(ldap): ldap 
anonymous bind returned 0
Aug 25 06:51:23 pbtest8 automount[32657]: get_query_dn: lookup(ldap): query dn 
ou=auto.master,dc=cl,dc=cam,dc=ac,dc=uk
Aug 25 06:51:23 pbtest8 automount[32657]: unbind_ldap_connection: use_tls: 0

so my guess is that the "(&(objectclass=automountMap)(ou=auto.master))" worked 
(shame it only reports the search if it fails) and returned 
"ou=auto.master,dc=cl,dc=cam,dc=ac,dc=uk" -- that's what ldapsearch does:

ivatt:~: ldapsearch -LLL -x "(&(objectclass=automountMap)(ou=auto.master))"
dn: ou=auto.master,dc=cl,dc=cam,dc=ac,dc=uk
objectClass: top
objectClass: automountMap
automountMapName: auto.master
ou: auto.master

ivatt:~: 

What does your debug say just after "ldap anonymous bind returned 0"?
Do you have base set correctly?

>> Any chance of it it defaulting to try the three example schemas?
> Which would means having multiple default values for a configuration
> directive that only accept one... It may be practical, but rather messy.

OK -- put it down to a "simplistic user view of the problem" :-(
I was thinking you could do something equiv to

(|(&(objectclass=automountMap)(ou=auto.master))
  (&(objectclass=nisMap)(nisMapName=auto.master))
)

but I suspect I'm missing the actual workings of LDAP (e.g. where the value is)
