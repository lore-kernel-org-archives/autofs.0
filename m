From: "Anthony M. Martinez" <twopir@nmt.edu>
Subject: bind mount not working as expected
Date: Thu, 6 Apr 2006 09:29:22 -0600
Message-ID: <20060406152922.GD10241@nmt.edu>
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
Cc: Timo Felbinger <Timo.Felbinger@physik.uni-potsdam.de>

As suggested, I am forwarding this question to the autofs mailing list,
since my problem doesn't seem to be Timo's patch. 

On Fri, Mar 24, 2006 at 06:05:31PM +0100, Timo Felbinger wrote:
> On Thu, Mar 23, 2006 at 09:57:15AM -0700, Pi (aka Anthony Martinez) wrote:
> > > > 
> > > Is it correct that this is a "program" map which is to telling
> > > automount to mount /fs/administratium/accounts/p/pi as /u/pi,
> > > and this information is taken from an ldap entry containing the
> > > attributes
> > >   uid: pi
> > >   tccRawHomeDir: /fs/administratium/accounts/p/pi
> > 
> > > ? If so, would
> > >   automount /u ldap "ldap://<server>/<base>?uid,tccRawHomeDir?sub?<filter>"
> > > do what you want?
> > 
> > OK. I am using
> > ldaps://<server>/ou=accounts,<base>?uid,tccRawHomeDir?sub?(objectClass=tccAccount)
> > 
> > but this mounts /u/pi in some weird fashion:

(the results of 'find /u/pi')

> > 
> > /u/pi
> > /u/pi/fs
> > /u/pi/fs/administratium
> > /u/pi/fs/administratium/accounts
> > /u/pi/fs/administratium/accounts/p
> > /u/pi/fs/administratium/accounts/p/pi
> > 
> 
> No, that's definitely not what it should do. (and I just tried and
> failed to reproduce this problem)
> 
> However, I do not see how this is specific to the lookup_ldap module
> (which is the only one affected by my patch). Essentially, these lookup
> modules just get handed a key value (in your example, "pi"), and return
> information on what to mount there (in your example,
> "/fs/administratium/accounts/p/pi"), much like your program map.
> The result should be the same as what you get manually with
>   mount -o bind /fs/administratium/accounts/p/pi /u/pi
> (this is a local (not NFS) mount, right?), and it works for me like that.

Additional information: /fs is also handled by automount, but that mount
works correctly

> 
> So your problem might be more general (too old kernel version, maybe?),

Debian Stable, kernel 2.6.8, autofs 4.1.3+4.1.4beta2 (with both Timo and
my patches relating to LDAP functionality)

> and maybe you could ask this on the autofs mailing list
> (http://linux.kernel.org/mailman/listinfo/autofs)?
> 
> Regards,
> 
> Timo


-- 
<aydiosmio> wow
<aydiosmio> someone's password in this db is "secrets"
<aydiosmio> I thought hackers was a lie
<com`fu> it was
<com`fu> they said secret
