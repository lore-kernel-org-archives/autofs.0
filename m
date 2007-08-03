From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS5 Ldap base strangeness
Date: Fri, 03 Aug 2007 13:20:41 +0800
Message-ID: <1186118441.3573.31.camel@raven.themaw.net>
References: <46B23DFB.7060200@cs.ou.edu>
	<x49odhpek9z.fsf@segfault.boston.devel.redhat.com>
	<46B247E7.3020902@cs.ou.edu>
	<x498x8tej4o.fsf@segfault.boston.devel.redhat.com>
	<46B24D15.4070306@cs.ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46B24D15.4070306@cs.ou.edu>
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
To: jsummers@bachman.cs.ou.edu
Cc: autofs@linux.kernel.org

On Thu, 2007-08-02 at 16:31 -0500, Jim Summers wrote:
> Jeff Moyer wrote:
> > Jim Summers <jsummers@bachman.cs.ou.edu> writes:
> > 
> >> Jeff Moyer wrote:
> >>> Jim Summers <jsummers@bachman.cs.ou.edu> writes:
> >>>
> >>>> hello all,
> >>>>
> >>>> I am just about to get my automounting working with autofs5 and my ldap.  I am
> >>>> able to start the automount daemon and it loads and reads /home map, which
> >>>> points at ou=auto.home for the user's home directory location and options.
> >>>>
> >>>> but when i attempt to su - <user> it can not mount the user's home.  here is
> >>>> what i see in the ldap server's access log:
> >>>> ===
> >>>> [31/Jul/2007:15:28:19 -0500] conn=8420 op=1 SRCH
> >>>> base="cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu" scope=2
> >>>> filter="(&(objectClass=automount)(|(automountKey=tmac)(automountKey=/)))"
> >>>> attrs="automountKey automountInformation"
> >>>> [31/Jul/2007:15:28:19 -0500] conn=8420 op=1 RESULT err=0 tag=101 nentries=0
> >>>> etime=0
> >>>> [31/Jul/2007:15:28:19 -0500] conn=8420 op=2 UNBIND
> >>>> ===
> >>>>
> >>>> the weird part of the above is, in the first line it says "cn=sfu" but then
> >>>> also says automountKey=tmac
> >>>>
> >>>> the su command is:  su - tmac
> >>>>
> >>>> so the correct username is tmac not sfu.
> >>>>
> >>>> any ideas where the sfu thing is coming from??
> >>>>
> >>>> is the info cached somewhere?  I ask because when I start the daemon, i can
> >>>> see in the logs where it does:
> >>>> ===
> >>>> [31/Jul/2007:15:35:40 -0500] conn=8536 op=1 SRCH
> >>>> base="ou=auto.home,dc=it,dc=ou,dc=edu" scope=2
> >>>> filter="(objectClass=automount)" attrs="1.1"
> >>>> [31/Jul/2007:15:35:40 -0500] conn=8536 op=1 RESULT err=0 tag=101 nentries=617
> >>>> etime=0
> >>>> ===
> >>>> which is returning 617 entries.
> >>>>
> >>>> not sure what i have wroong here??
> >>> Please send a debug log:
> >>>   http://people.redhat.com/jmoyer
> >> Will do Jeff.  Just to cut some time out how can i generate the debug
> >> log?  In /etc/sysconfig/autofs, i have set:
> >>
> >> LOGGING="debug"
> >> and
> >> OPTIONS="-v"
> >>
> >> but that seems to only increase the noise in /var/log/messages a little.
> >>
> >> i do have the following installed:
> >>
> >> autofs-5.0.1-20
> >> autofs-debuginfo-5.0.1-20
> > 
> 
> >>From the web page to which I pointed you:
> > 
> > ---
> > debug output.
> > 
> >     * Add a line like the following to your /etc/syslog.conf:
> > 
> >       daemon.*			/var/log/debug
> > 
> > Restart syslogd (or send it a HUP signal).
> > ---
> > 
> > -Jeff
> 
> Sorry Jeff.  Got it done.  i have attached the debug file.  let me know if I 
> should inline it or what works best.
> 
> from what i can decipher it appears to be trying to pull the auto.home stuff 
> from under the cn=sfu.  but that doesn't make sense to me.

Indeed it is.

Snip ...

> Aug  2 16:21:44 leech automount[13929]: lookup_nss_read_map: reading
> map ldap //landin/ou=auto.home,dc=it,dc=ou,dc=edu
> Aug  2 16:21:44 leech automount[13929]: parse_server_string:
> lookup(ldap): Attempting to parse LDAP information from string
> "//landin/ou=auto.home,dc=it,dc=ou,dc=edu".
> Aug  2 16:21:44 leech automount[13929]: parse_server_string:
> lookup(ldap): server "landin", base dn
> "ou=auto.home,dc=it,dc=ou,dc=edu"

And we've been told what the base dn is here.

> Aug  2 16:21:44 leech automount[13929]: parse_ldap_config: ldap
> authentication configured with the following options: 
> Aug  2 16:21:44 leech automount[13929]: parse_ldap_config: use_tls: 0,
> tls_required: 0, auth_required: 1, sasl_mech: (null) 
> Aug  2 16:21:44 leech automount[13929]: parse_ldap_config: user:
> (null), secret: unspecified, client principal: (null) 
> Aug  2 16:21:44 leech automount[13929]: do_connect: auth_required: 1,
> sasl_mech (null)
> Aug  2 16:21:44 leech automount[13929]: do_connect: lookup(ldap): ldap
> anonymous bind returned 0
> Aug  2 16:21:44 leech automount[13929]: get_query_dn: lookup(ldap):
> query dn cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu

But then it seems that this dn has objectclass automountMap and is under
ou=auto.home,dc=it,dc=ou,dc=edu.

I suspect that making this case in get_query_dn a subtree search was a
mistake. There is also a question about whether we should connect to the
LDAP server at all at this point since we've been given the base dn. I'd
rather continue to connect in order to validate the base dn and server
availability.

Could you try this patch please.

Ian

---
diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index de8d515..73d393f 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -859,7 +859,7 @@ static int get_query_dn(LDAP *ldap, struct lookup_context *ctxt)
 			      MODPREFIX "error forming query string");
 			return 0;
 		}
-		scope = LDAP_SCOPE_SUBTREE;
+		scope = LDAP_SCOPE_ONE;
 	}
 	query[l] = '\0';
