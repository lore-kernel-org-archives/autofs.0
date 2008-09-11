From: Ian Kent <raven@themaw.net>
Subject: Re: 5.0.3 oddity with LDAP map
Date: Thu, 11 Sep 2008 10:53:23 +0800
Message-ID: <1221101603.2966.1.camel@raven.themaw.net>
References: <20080909220416.GB22997@u20m2mm.qualcomm.com>
	<1221018890.3030.66.camel@raven.themaw.net>
	<1221026325.3030.69.camel@raven.themaw.net>
	<20080910195023.GB30958@u20m2mm.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080910195023.GB30958@u20m2mm.qualcomm.com>
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
To: Mike Marion <mmarion@qualcomm.com>
Cc: "autofs@kernel.org" <autofs@kernel.org>

On Wed, 2008-09-10 at 12:50 -0700, Mike Marion wrote:
> On Tue, Sep 09, 2008 at 10:58:45PM -0700, Ian Kent wrote:
> 
> > I've tried a bunch of variations but can't see a problem.
> > I'll need the map configuration.
> 
> Assuming you mean this.. (I'm not privy to the ldap servers themselves,
> but could pull the admin that originally setup the stuff if needed):
> 
> $ ldapsearch -x -h qctldap -b automountMapName=auto_master,ou=automountMaps,ou=sandiego,ou=qct,dc=qualcomm,dc=com "(objectclass=automount)"

And the stuff with objectclass=automountMap

> # extended LDIF
> #
> # LDAPv3
> # base
> # <automountMapName=auto_master,ou=automountMaps,ou=sandiego,ou=qct,dc=qualcomm,dc=com>
> # with scope subtree
> # filter: (objectclass=automount)
> # requesting: ALL
> #
> 
> # /-, auto_master, automountMaps, sandiego, qct, qualcomm.com
> dn: automountKey=/-,automountMapName=auto_master,ou=automountMaps,ou=sandiego,
>  ou=qct,dc=qualcomm,dc=com
> automountInformation: auto.projects
> automountKey: /-
> description: /-
> objectClass: automount
> objectClass: top
> 
> # /net, auto_master, automountMaps, sandiego, qct, qualcomm.com
> dn: automountKey=/net,automountMapName=auto_master,ou=automountMaps,ou=sandieg
>  o,ou=qct,dc=qualcomm,dc=com
> automountInformation: -hosts -nosuid
> automountKey: /net
> objectClass: automount
> objectClass: top
> 
> # /usr2, auto_master, automountMaps, sandiego, qct, qualcomm.com
> dn: automountKey=/usr2,automountMapName=auto_master,ou=automountMaps,ou=sandie
>  go,ou=qct,dc=qualcomm,dc=com
> automountInformation: auto.home
> automountKey: /usr2
> description: /usr2
> objectClass: automount
> objectClass: top
> 
> # search result
> search: 2
> result: 0 Success
> 
> # numResponses: 4
> # numEntries: 3
> 
> This same setup has been working great with autofs-5.0.2.   Well, not
> perfect, but basically every problem we've had can be related to either
> filer bugs, or the box being run OOM and the automount daemon suffering
> 
> If I then query for, say auto.projects, I get (as of now) 8551 results
> (yeah, we have MASSIVE maps and we're working on trimming to subsets
> where required), trimmed for just one path result and header/footer
> from that... 
> 
> $ ldapsearch -x -h qctldap -b automountMapName=auto.projects,ou=automountMaps,ou=sandiego,ou=qct,dc=qualcomm,dc=com
> "(objectclass=automount)" | less
> # extended LDIF
> #
> # LDAPv3
> # base
> # <automountMapName=auto.projects,ou=automountMaps,ou=sandiego,ou=qct,dc=qualcomm,dc=com>
> # with scope subtree
> # filter: (objectclass=automount)
> # requesting: ALL
> #
> [snip]
> # /prj/qct/gv, auto.projects, automountMaps, sandiego, qct, qualcomm.com
> dn: automountKey=/prj/qct/gv,automountMapName=auto.projects,ou=automountMaps,o
>  u=sandiego,ou=qct,dc=qualcomm,dc=com
> objectClass: top
> objectClass: automount
> automountKey: /prj/qct/gv
> automountInformation: -rw,acdirmin=1,acdirmax=5,acregmin=1,acregmax=5,noquota
>  filer:/vol/volname/qct_gv
> [snip]
> # search result
> search: 2
> result: 0 Success
> 
> # numResponses: 8552
> # numEntries: 8551
> 
> Not entirely sure this 2nd ldapsearch is completely right.. the strace
> is hard to read
> 
